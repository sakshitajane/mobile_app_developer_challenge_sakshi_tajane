import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> initialize() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> speak(String text) async {
    print("Speaking: $text");

    var result = await flutterTts.speak(text);

    print("Result: $result");
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
