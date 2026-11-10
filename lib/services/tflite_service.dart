import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import '../utils/constants.dart';

class TfliteService {
  Interpreter? _interpreter;
  List<String> _labels = [];

  Future<void> loadModel({
    required String modelPath,
    required String labelsPath,
  }) async {
    _interpreter = await Interpreter.fromAsset(modelPath);

    final jsonString = await rootBundle.loadString(labelsPath);
    final Map<String, dynamic> labelMap = jsonDecode(jsonString);

    final sortedEntries =
        labelMap.entries.toList()
          ..sort((a, b) => (a.value as int).compareTo(b.value as int));

    _labels = sortedEntries.map((e) => e.key as String).toList();
  }

  Float32List _preprocessImage(File imageFile) {
    final rawImage = img.decodeImage(imageFile.readAsBytesSync());
    if (rawImage == null) {
      throw Exception('Gagal membaca gambar. Pastikan format jpg/png.');
    }

    final resized = img.copyResize(
      rawImage,
      width: AppConstants.inputImageSize,
      height: AppConstants.inputImageSize,
    );

    final buffer = Float32List(
      1 * AppConstants.inputImageSize * AppConstants.inputImageSize * 3,
    );
    int i = 0;
    for (int y = 0; y < AppConstants.inputImageSize; y++) {
      for (int x = 0; x < AppConstants.inputImageSize; x++) {
        final pixel = resized.getPixel(x, y);
        buffer[i++] = pixel.r / 255.0;
        buffer[i++] = pixel.g / 255.0;
        buffer[i++] = pixel.b / 255.0;
      }
    }
    return buffer;
  }

  Future<Map<String, dynamic>> classify(File imageFile) async {
    if (_interpreter == null) {
      throw Exception('Model belum di-load. Panggil loadModel() dulu.');
    }

    final input = _preprocessImage(imageFile);
    final inputTensor = input.reshape([
      1,
      AppConstants.inputImageSize,
      AppConstants.inputImageSize,
      3,
    ]);
    final outputTensor = List.filled(
      1 * _labels.length,
      0.0,
    ).reshape([1, _labels.length]);

    _interpreter!.run(inputTensor, outputTensor);

    final scores = List<double>.from(outputTensor[0]);
    double bestScore = -1;
    int bestIndex = 0;
    for (int i = 0; i < scores.length; i++) {
      if (scores[i] > bestScore) {
        bestScore = scores[i];
        bestIndex = i;
      }
    }

    return {'label': _labels[bestIndex], 'confidence': bestScore};
  }

  void dispose() => _interpreter?.close();
}
