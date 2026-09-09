import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  
  late FlutterTts _flutterTts;
  bool _isInitialized = false;

  TtsService._internal();

  Future<void> init() async {
    if (_isInitialized) return;
    _flutterTts = FlutterTts();
    await _flutterTts.setSpeechRate(0.45); // Slower for low-literacy clarity
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    _isInitialized = true;
  }

  Future<void> speak(String text, {String languageCode = 'hi-IN'}) async {
    if (!_isInitialized) await init();
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    if (!_isInitialized) return;
    await _flutterTts.stop();
  }

  Future<void> setLanguage(String langCode) async {
    if (!_isInitialized) await init();
    await _flutterTts.setLanguage(langCode);
  }

  Future<void> speakPrice(String material, dynamic price, [String langCode = 'hi-IN']) async {
    final priceStr = price.toString();
    String text;
    switch (langCode) {
      case 'hi-IN':
        text = "$material का भाव $priceStr रुपये है।";
        break;
      case 'mr-IN':
        text = "$material चा भाव $priceStr रुपये आहे.";
        break;
      default:
        text = "The price of $material is $priceStr rupees.";
    }
    await speak(text, languageCode: langCode);
  }

  Future<void> speakGreeting(String langCode) async {
    String text;
    switch (langCode) {
      case 'hi-IN':
        text = "कबाड़ीवाला कनेक्ट में आपका स्वागत है।";
        break;
      case 'mr-IN':
        text = "कबाड़ीवाला कनेक्ट मध्ये आपले स्वागत आहे.";
        break;
      default:
        text = "Welcome to Kabadiwala Connect.";
    }
    await speak(text, languageCode: langCode);
  }

  void dispose() {
    stop();
  }
}
