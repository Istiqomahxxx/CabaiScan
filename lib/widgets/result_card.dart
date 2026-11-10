import 'package:flutter/material.dart';
import '../models/detection_result.dart';
import '../utils/constants.dart';

class ResultCard extends StatelessWidget {
  final DetectionResult result;
  final VoidCallback onSpeak;
  final bool isSpeaking;

  const ResultCard({
    super.key,
    required this.result,
    required this.onSpeak,
    required this.isSpeaking,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (result.confidence * 100).toStringAsFixed(1);
    final severity = AppConstants.getTingkatKeparahan(result.label);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  result.displayLabel,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Badge tingkat keparahan
              if (severity != '-' && severity != 'Normal')
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _severityColor(severity),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    severity,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Tingkat keyakinan: $percent%',
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 12),

          const Text(
            'Penjelasan:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(result.description),
          const SizedBox(height: 8),

          const Text(
            'Penyebab:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(AppConstants.getPenyebab(result.label)),
          const SizedBox(height: 8),

          const Text('Saran:', style: TextStyle(fontWeight: FontWeight.w600)),
          Text(result.suggestion),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isSpeaking ? null : onSpeak,
              icon: Icon(
                isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
              ),
              label: Text(
                isSpeaking ? 'Sedang membacakan...' : 'Dengarkan Hasil',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _severityColor(String severity) {
    if (severity.contains('Tinggi')) return Colors.red.shade600;
    if (severity.contains('Sedang')) return Colors.orange.shade600;
    if (severity.contains('Ringan')) return Colors.amber.shade700;
    return Colors.grey;
  }
}
