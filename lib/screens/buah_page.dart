import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/detection_result.dart';
import '../services/object_validator_service.dart';
import '../services/history_service.dart';
import '../services/image_services.dart';
import '../services/tflite_service.dart';
import '../services/tts_service.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/result_card.dart';

class BuahPage extends StatefulWidget {
  const BuahPage({super.key});

  @override
  State<BuahPage> createState() => _BuahPageState();
}

class _BuahPageState extends State<BuahPage> {
  final ImageServices _imageServices = ImageServices();
  final TfliteService _tfliteService = TfliteService();
  final TtsService _ttsService = TtsService();
  final HistoryService _historyService = HistoryService();
  final ObjectValidatorService _validatorService = ObjectValidatorService();

  File? _selectedImage;
  DetectionResult? _result;
  bool _isModelLoading = true;
  bool _isDetecting = false;
  bool _isSpeaking = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      await _tfliteService.loadModel(
        modelPath: AppConstants.buahModelPath,
        labelsPath: AppConstants.buahLabelsPath,
      );
    } catch (e) {
      _errorMessage = 'Gagal memuat model buah: $e';
    } finally {
      if (mounted) setState(() => _isModelLoading = false);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final file = await _imageServices.pickImage(source);
    if (file != null) {
      setState(() {
        _selectedImage = file;
        _result = null;
        _errorMessage = null;
      });
    }
  }

  Future<void> _detect() async {
    if (_selectedImage == null) return;
    setState(() {
      _isDetecting = true;
      _errorMessage = null;
    });

    try {
      final isValid = _validatorService.isLikelyChiliObject(
        _selectedImage!,
        minRatio: 0.05,
      );
      if (!isValid) {
        setState(() {
          _errorMessage =
              'Gambar tidak terdeteksi sebagai buah cabai. '
              'Pastikan foto menampilkan bagian tanaman cabai dengan jelas '
              'dan pencahayaan cukup.';
        });
        return;
      }
      final prediction = await _tfliteService.classify(_selectedImage!);
      final label = prediction['label'] as String;
      final confidence = prediction['confidence'] as double;

      setState(() {
        _result = DetectionResult(
          image: _selectedImage!,
          label: label,
          confidence: confidence,
          description: AppConstants.getDescription(label),
          suggestion: AppConstants.getSuggestion(label),
        );
      });

      await _historyService.addEntry(
        image: _selectedImage!,
        type: 'buah',
        label: label,
        confidence: confidence,
        description: AppConstants.getDescription(label),
        suggestion: AppConstants.getSuggestion(label),
      );
    } catch (e) {
      setState(() => _errorMessage = 'Gagal mendeteksi: $e');
    } finally {
      if (mounted) setState(() => _isDetecting = false);
    }
  }

  Future<void> _speakResult() async {
    if (_result == null) return;
    setState(() => _isSpeaking = true);
    await _ttsService.speak(_result!.toSpeechText());
    if (mounted) setState(() => _isSpeaking = false);
  }

  @override
  void dispose() {
    _tfliteService.dispose();
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteksi Buah Cabai'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body:
          _isModelLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 240,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child:
                            _selectedImage == null
                                ? const Center(
                                  child: Text('Belum ada gambar dipilih'),
                                )
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                      ),
                      const SizedBox(height: 16),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: 'Kamera',
                              icon: Icons.camera_alt,
                              color: Colors.deepOrange.shade400,
                              onTap: () => _pickImage(ImageSource.camera),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              label: 'Galeri',
                              icon: Icons.photo_library,
                              color: Colors.deepOrange.shade400,
                              onTap: () => _pickImage(ImageSource.gallery),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        label: 'Deteksi Sekarang',
                        icon: Icons.search,
                        color: Colors.deepOrange.shade700,
                        isLoading: _isDetecting,
                        onTap: _selectedImage == null ? null : _detect,
                      ),
                      if (_result != null)
                        ResultCard(
                          result: _result!,
                          isSpeaking: _isSpeaking,
                          onSpeak: _speakResult,
                        ),
                    ],
                  ),
                ),
              ),
    );
  }
}
