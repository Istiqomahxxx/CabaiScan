import 'dart:convert';

class HistoryEntry {
  final String id;
  final String imagePath;
  final String type; // 'daun' atau 'buah'
  final String label;
  final double confidence;
  final String description;
  final String suggestion;
  final DateTime timestamp;

  HistoryEntry({
    required this.id,
    required this.imagePath,
    required this.type,
    required this.label,
    required this.confidence,
    required this.description,
    required this.suggestion,
    required this.timestamp,
  });

  String get displayLabel {
    return label
        .split('_')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'imagePath': imagePath,
    'type': type,
    'label': label,
    'confidence': confidence,
    'description': description,
    'suggestion': suggestion,
    'timestamp': timestamp.toIso8601String(),
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    id: json['id'],
    imagePath: json['imagePath'],
    type: json['type'],
    label: json['label'],
    confidence: (json['confidence'] as num).toDouble(),
    description: json['description'],
    suggestion: json['suggestion'],
    timestamp: DateTime.parse(json['timestamp']),
  );

  static List<HistoryEntry> listFromJsonString(String jsonString) {
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => HistoryEntry.fromJson(e)).toList();
  }

  static String listToJsonString(List<HistoryEntry> entries) {
    return jsonEncode(entries.map((e) => e.toJson()).toList());
  }
}