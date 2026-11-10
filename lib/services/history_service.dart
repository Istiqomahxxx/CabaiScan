import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_entry.dart';

class HistoryService {
  static const _prefsKey = 'detection_history';

  Future<List<HistoryEntry>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    final list = HistoryEntry.listFromJsonString(jsonString);
    list.sort((a, b) => b.timestamp.compareTo(a.timestamp)); // terbaru di atas
    return list;
  }

  Future<void> addEntry({
    required File image,
    required String type,
    required String label,
    required double confidence,
    required String description,
    required String suggestion,
  }) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final fileName = 'history_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await image.copy('${docsDir.path}/$fileName');

    final entry = HistoryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: savedImage.path,
      type: type,
      label: label,
      confidence: confidence,
      description: description,
      suggestion: suggestion,
      timestamp: DateTime.now(),
    );

    final current = await getAll();
    current.add(entry);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, HistoryEntry.listToJsonString(current));
  }

  Future<void> deleteEntry(String id) async {
    final current = await getAll();
    final target = current.firstWhere((e) => e.id == id);

    final file = File(target.imagePath);
    if (await file.exists()) {
      await file.delete();
    }

    current.removeWhere((e) => e.id == id);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, HistoryEntry.listToJsonString(current));
  }
}
