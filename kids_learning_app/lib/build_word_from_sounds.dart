import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BuildWordFromSoundsScreen extends StatefulWidget {
  @override
  _BuildWordFromSoundsScreenState createState() => _BuildWordFromSoundsScreenState();
}

class _BuildWordFromSoundsScreenState extends State<BuildWordFromSoundsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  String? feedback;

  final List<BuildWordQuestion> questions = [
    BuildWordQuestion(
      soundAssets: ['audio/k.mp3', 'audio/o.mp3', 'audio/t.mp3'],
      correctWord: 'Кот',
      options: ['Кот', 'Кит', 'Сок'],
    ),
    BuildWordQuestion(
      soundAssets: ['audio/m.mp3', 'audio/a.mp3', 'audio/m.mp3', 'audio/a.mp3'],
      correctWord: 'Мама',
      options: ['Мама', 'Мыло', 'Лама'],
    ),
    // Добавь больше заданий по желанию
  ];

  void playSoundsSequentially(List<String> assets) async {
    for (var asset in assets) {
      await _audioPlayer.play(AssetSource(asset));
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void checkAnswer(String selected) {
    setState(() {
      feedback = selected == questions[currentIndex].correctWord
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
        builder: (_) => AlertDialog(
          title: Text('Отлично!'),
          content: Text('Ты прошёл все задания!'),
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

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('🔊 Собери слово из звуков')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Задание ${currentIndex + 1} из ${questions.length}',
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              Text(
                'Прослушай звуки и собери слово',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => playSoundsSequentially(q.soundAssets),
                icon: Icon(Icons.volume_up),
                label: Text('Слушать звуки'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
              ),
              SizedBox(height: 30),
              ...q.options.map(
                (word) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(word),
                    child: Text(word, style: TextStyle(fontSize: 20)),
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

class BuildWordQuestion {
  final List<String> soundAssets;
  final String correctWord;
  final List<String> options;

  BuildWordQuestion({
    required this.soundAssets,
    required this.correctWord,
    required this.options,
  });
}
