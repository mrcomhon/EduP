import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LetterSoundQuestion {
  final String correctLetter;
  final List<String> options;
  final String audioPath;

  LetterSoundQuestion({
    required this.correctLetter,
    required this.options,
    required this.audioPath,
  });
}

final List<LetterSoundQuestion> letterSoundQuestions = [
  LetterSoundQuestion(
    correctLetter: 'А',
    options: ['А', 'О', 'Э'],
    audioPath: 'assets/audio/a.mp3',
  ),
  LetterSoundQuestion(
    correctLetter: 'Б',
    options: ['Д', 'Б', 'П'],
    audioPath: 'assets/audio/b.mp3',
  ),
  LetterSoundQuestion(
    correctLetter: 'К',
    options: ['К', 'Т', 'Х'],
    audioPath: 'assets/audio/k.mp3',
  ),
    LetterSoundQuestion(
    correctLetter: 'И',
    options: ['А', 'И', 'Р'],
    audioPath: 'assets/audio/i.mp3',
  ),
    LetterSoundQuestion(
    correctLetter: 'У',
    options: ['В', 'С', 'У'],
    audioPath: 'assets/audio/u.mp3',
  ),
];

class LetterSoundsScreen extends StatefulWidget {
  @override
  State<LetterSoundsScreen> createState() => _LetterSoundsScreenState();
}

class _LetterSoundsScreenState extends State<LetterSoundsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  String? feedback;
  int correctCount = 0;

  void playAudio(String path) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path.replaceFirst('assets/', '')));
  }

  void checkAnswer(String selected) {
    final correct = letterSoundQuestions[currentIndex].correctLetter;
    setState(() {
      feedback = (selected == correct) ? 'Верно! 🎉' : 'Неверно 🙃';
      if (selected == correct) correctCount++;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentIndex < letterSoundQuestions.length - 1) {
          currentIndex++;
          feedback = null;
          playAudio(letterSoundQuestions[currentIndex].audioPath);
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Отлично!'),
                  content: Text(
                    'Ты правильно ответил на $correctCount из ${letterSoundQuestions.length}',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          currentIndex = 0;
                          correctCount = 0;
                          feedback = null;
                          playAudio(letterSoundQuestions[0].audioPath);
                        });
                      },
                      child: Text('Начать заново'),
                    ),
                  ],
                ),
          );
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    playAudio(letterSoundQuestions[currentIndex].audioPath);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = letterSoundQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('📢 Звуки букв')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Задание ${currentIndex + 1} из ${letterSoundQuestions.length}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.volume_up),
              label: Text('Проиграть звук', style: TextStyle(fontSize: 20)),
              onPressed: () => playAudio(q.audioPath),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
            SizedBox(height: 30),
            ...q.options.map(
              (letter) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(letter),
                  child: Text(letter, style: TextStyle(fontSize: 24)),
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
            ],
          ],
        ),
      ),
    );
  }
}
