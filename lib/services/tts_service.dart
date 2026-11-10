import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> _init() async {
    if (_isInitialized) return;
    await _flutterTts.setLanguage('id-ID');
    await _flutterTts.setSpeechRate(0.55);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    await _init();
    await _flutterTts.stop();
    await _flutterTts.speak(text);
  }

  Future<void> stop() async => await _flutterTts.stop();
}
