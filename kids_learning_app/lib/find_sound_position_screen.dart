import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FindSoundPositionScreen extends StatefulWidget {
  @override
  _FindSoundPositionScreenState createState() =>
      _FindSoundPositionScreenState();
}

class _FindSoundPositionScreenState extends State<FindSoundPositionScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  String? feedback;

  final List<PositionQuestion> questions = [
    PositionQuestion(
      sound: 'С',
      word: 'Сок',
      audioAsset: 'audio/sok.mp3',
      options: ['В начале', 'В середине', 'В конце'],
      correctAnswer: 'В начале',
    ),
    PositionQuestion(
      sound: 'Р',
      word: 'Игра',
      audioAsset: 'audio/igra.mp3',
      options: ['В начале', 'В середине', 'В конце'],
      correctAnswer: 'В конце',
    ),
    // добавь больше примеров
  ];

  void checkAnswer(String selected) {
    setState(() {
      feedback =
          selected == questions[currentIndex].correctAnswer
              ? 'Верно! 🎉'
              : 'Неправильно 😔';
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        feedback = null;
      });
    } else {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Молодец!'),
              content: Text('Ты завершил все задания!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Ок'),
                ),
              ],
            ),
      );
    }
  }

  void playAudio(String asset) async {
    await _audioPlayer.play(AssetSource(asset));
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('📍 Позиция звука')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Задание ${currentIndex + 1} из ${questions.length}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Text(
              'Где находится звук "${q.sound}" в слове?',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              q.word,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => playAudio(q.audioAsset),
              icon: Icon(Icons.volume_up),
              label: Text('Слушать слово'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
            ),
            SizedBox(height: 30),
            ...q.options.map(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  child: Text(option, style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),
            ),
            if (feedback != null) ...[
              SizedBox(height: 20),
              Text(
                feedback!,
                style: TextStyle(
                  fontSize: 22,
                  color: feedback == 'Верно! 🎉' ? Colors.green : Colors.red,
                ),
              ),
              if (feedback == 'Верно! 🎉')
                TextButton(onPressed: nextQuestion, child: Text('Дальше')),
            ],
          ],
        ),
      ),
    );
  }
}

class PositionQuestion {
  final String sound;
  final String word;
  final String audioAsset;
  final List<String> options;
  final String correctAnswer;

  PositionQuestion({
    required this.sound,
    required this.word,
    required this.audioAsset,
    required this.options,
    required this.correctAnswer,
  });
}
