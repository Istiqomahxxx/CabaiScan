import 'dart:io';

class DetectionResult {
  final File image;
  final String label;
  final double confidence;
  final String description;
  final String suggestion;

  DetectionResult({
    required this.image,
    required this.label,
    required this.confidence,
    required this.description,
    required this.suggestion,
  });

  String get displayLabel {
    return label
        .split('_')
        .map(
          (word) =>
              word.isEmpty
                  ? word
                  : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  String toSpeechText() {
    final percent = (confidence * 100).toStringAsFixed(1);
    return 'Hasil deteksi: $displayLabel, dengan tingkat keyakinan $percent persen. '
        '$description $suggestion';
  }
}