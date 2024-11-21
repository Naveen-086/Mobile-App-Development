import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const SpeechToTextApp());
}

class SpeechToTextApp extends StatelessWidget {
  const SpeechToTextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SpeechToTextHome(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class SpeechToTextHome extends StatefulWidget {
  const SpeechToTextHome({super.key});

  @override
  _SpeechToTextHomeState createState() => _SpeechToTextHomeState();
}

class _SpeechToTextHomeState extends State<SpeechToTextHome> {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _recognizedText = "Press the button and start speaking";
  double _confidence = 1.0;
  String _selectedLanguage = 'en_US';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() {
          _recognizedText = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            _confidence = val.confidence;
          }
        }),
        localeId: _selectedLanguage,
      );
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  void _onLanguageChanged(String? language) {
    setState(() {
      _selectedLanguage = language!;
    });
  }

  Future<void> _speakText() async {
    await _flutterTts.setLanguage(_selectedLanguage);
    await _flutterTts.speak(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EchoTranscribe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Speech to Text Section
            Card(
              color: Colors.teal[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preferred language:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: _selectedLanguage,
                      items: const [
                        DropdownMenuItem(
                          value: 'en_US',
                          child: Text('English'),
                        ),
                        DropdownMenuItem(
                          value: 'ta_IN',
                          child: Text('Tamil'),
                        ),
                      ],
                      onChanged: _onLanguageChanged,
                      underline: Container(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      _recognizedText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.teal[900],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FloatingActionButton.extended(
              onPressed: _isListening ? _stopListening : _startListening,
              backgroundColor: Colors.teal[700],
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 28.0,
              ),
              label: Text(_isListening ? "Stop Listening" : "Start Listening"),
            ),
            const SizedBox(height: 30), // Space between STT and TTS sections

            // Text to Speech Section
            Card(
              color: Colors.teal[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _textEditingController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Enter text to read',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.teal[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _speakText,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[600],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Speak"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Footer Section
            Center(
              child: Text(
                'Muruganandham',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal[600],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
