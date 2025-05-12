import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FindShapeScreen extends StatefulWidget {
  @override
  _FindShapeScreenState createState() => _FindShapeScreenState();
}

class _FindShapeScreenState extends State<FindShapeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  int correctCount = 0;
  bool showFeedback = false;
  bool isCorrect = false;

  final List<ShapeQuestion> shapeQuestions = [
    ShapeQuestion(
      questionAudio: 'audio/shapes/find_circle.mp3',
      correctImage: 'assets/images/shapes/circle.png',
      options: [
        'assets/images/shapes/triangle.png',
        'assets/images/shapes/square.png',
        'assets/images/shapes/circle.png',
      ],
    ),
    ShapeQuestion(
      questionAudio: 'audio/shapes/find_square.mp3',
      correctImage: 'assets/images/shapes/square.png',
      options: [
        'assets/images/shapes/square.png',
        'assets/images/shapes/triangle.png',
        'assets/images/shapes/oval.png',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  void playAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.setVolume(1.0);
    await _audioPlayer.play(
      AssetSource(shapeQuestions[currentIndex].questionAudio),
    );
  }

  void handleSelection(String selected) {
    final correct = selected == shapeQuestions[currentIndex].correctImage;
    setState(() {
      isCorrect = correct;
      showFeedback = true;
      if (correct) correctCount++;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showFeedback = false;
        if (currentIndex < shapeQuestions.length - 1) {
          currentIndex++;
          playAudio();
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Умница!'),
                  content: Text(
                    'Ты правильно нашёл ${correctCount} из ${shapeQuestions.length} форм.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          currentIndex = 0;
                          correctCount = 0;
                          playAudio();
                        });
                      },
                      child: Text('Сначала'),
                    ),
                  ],
                ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = shapeQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('🔺 Найди фигуру')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Форма ${currentIndex + 1} из ${shapeQuestions.length}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: playAudio,
              icon: Icon(Icons.volume_up),
              label: Text('Слушать задание'),
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children:
                  question.options.map((imagePath) {
                    return GestureDetector(
                      onTap: () => handleSelection(imagePath),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(imagePath),
                      ),
                    );
                  }).toList(),
            ),
            if (showFeedback)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  isCorrect ? 'Правильно! ✅' : 'Неправильно ❌',
                  style: TextStyle(
                    fontSize: 24,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ShapeQuestion {
  final String questionAudio;
  final String correctImage;
  final List<String> options;

  ShapeQuestion({
    required this.questionAudio,
    required this.correctImage,
    required this.options,
  });
}
