import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FindSoundInWordScreen extends StatefulWidget {
  @override
  _FindSoundInWordScreenState createState() => _FindSoundInWordScreenState();
}

class _FindSoundInWordScreenState extends State<FindSoundInWordScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  String? feedback;

  final List<SoundQuestion> questions = [
    SoundQuestion(
      targetSound: 'С',
      audioAsset: 'audio/slon.mp3',
      word: 'Слон',
      options: ['Слон', 'Утка', 'Кошка'],
      correctAnswer: 'Слон',
    ),
    SoundQuestion(
      targetSound: 'Ш',
      audioAsset: 'audio/grusha.mp3',
      word: 'Груша',
      options: ['Молоко', 'Лиса', 'Груша'],
      correctAnswer: 'Груша',
    ),
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
      appBar: AppBar(title: Text('🔊 Найди звук в слове')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Задание ${currentIndex + 1} из ${questions.length}',
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              Text(
                'Где ты слышишь звук "${q.targetSound}"?',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
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
      ),
    );
  }
}

class SoundQuestion {
  final String targetSound;
  final String audioAsset;
  final String word;
  final List<String> options;
  final String correctAnswer;

  SoundQuestion({
    required this.targetSound,
    required this.audioAsset,
    required this.word,
    required this.options,
    required this.correctAnswer,
  });
}
