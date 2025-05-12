import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FindColorScreen extends StatefulWidget {
  @override
  _FindColorScreenState createState() => _FindColorScreenState();
}

class _FindColorScreenState extends State<FindColorScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  int correctCount = 0;
  bool showFeedback = false;
  bool isCorrect = false;

  final List<ColorQuestion> colorQuestions = [
    ColorQuestion(
      questionAudio: 'audio/colors/find_red.mp3',
      correctColor: Colors.red,
      options: [Colors.blue, Colors.red, Colors.green],
    ),
    ColorQuestion(
      questionAudio: 'audio/colors/find_yellow.mp3',
      correctColor: Colors.yellow,
      options: [Colors.yellow, Colors.purple, Colors.orange],
    ),
    ColorQuestion(
      questionAudio: 'audio/colors/find_blue.mp3',
      correctColor: Colors.blue,
      options: [Colors.green, Colors.blue, Colors.brown],
    ),
  ];

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  void playAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(
      AssetSource(colorQuestions[currentIndex].questionAudio),
    );
  }

  void handleSelection(Color selected) {
    final correct = selected == colorQuestions[currentIndex].correctColor;
    setState(() {
      isCorrect = correct;
      showFeedback = true;
      if (correct) correctCount++;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showFeedback = false;
        if (currentIndex < colorQuestions.length - 1) {
          currentIndex++;
          playAudio();
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Молодец!'),
                  content: Text(
                    'Ты правильно выбрал ${correctCount} из ${colorQuestions.length} цветов.',
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
    final question = colorQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('🎨 Найди цвет')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Цвет ${currentIndex + 1} из ${colorQuestions.length}',
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
                  question.options.map((color) {
                    return GestureDetector(
                      onTap: () => handleSelection(color),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
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

class ColorQuestion {
  final String questionAudio;
  final Color correctColor;
  final List<Color> options;

  ColorQuestion({
    required this.questionAudio,
    required this.correctColor,
    required this.options,
  });
}
