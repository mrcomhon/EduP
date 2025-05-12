import 'package:flutter/material.dart';

class BuildWordScreen extends StatefulWidget {
  @override
  _BuildWordScreenState createState() => _BuildWordScreenState();
}

class _BuildWordScreenState extends State<BuildWordScreen> {
  int currentIndex = 0;
  String assembledWord = '';
  String? feedback;
  int correctCount = 0;

  void selectLetter(String letter) {
    setState(() {
      assembledWord += letter;
    });

    final currentQuestion = buildWordQuestions[currentIndex];

    if (assembledWord.length == currentQuestion.correctWord.length) {
      final isCorrect = assembledWord == currentQuestion.correctWord;
      setState(() {
        feedback = isCorrect ? 'Верно! 🎉' : 'Неверно 🙃';
        if (isCorrect) correctCount++;
      });

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          assembledWord = '';
          feedback = null;
          if (currentIndex < buildWordQuestions.length - 1) {
            currentIndex++;
          } else {
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: Text('Готово!'),
                    content: Text(
                      'Ты правильно собрал $correctCount из ${buildWordQuestions.length} слов.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            currentIndex = 0;
                            correctCount = 0;
                            assembledWord = '';
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
  }

  Widget buildHint(BuildWordQuestion question) {
    if (question.hint.endsWith('.png') || question.hint.endsWith('.jpg')) {
      return Image.asset(question.hint, height: 150);
    } else {
      return Text(
        'Подсказка: ${question.hint}',
        style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = buildWordQuestions[currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text('🧩 Собери слово')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Слово ${currentIndex + 1} из ${buildWordQuestions.length}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Выбери буквы, чтобы составить слово:',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              assembledWord,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildHint(q), // ← ЭТО ДОБАВЛЯЕМ!
            SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  q.letterOptions.map((letter) {
                    return ElevatedButton(
                      onPressed: () => selectLetter(letter),
                      child: Text(letter, style: TextStyle(fontSize: 24)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            if (feedback != null) ...[
              SizedBox(height: 20),
              Text(
                feedback!,
                style: TextStyle(
                  fontSize: 24,
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

class BuildWordQuestion {
  final String correctWord;
  final List<String> letterOptions;
  final String hint; // Текст или путь к картинке

  BuildWordQuestion({
    required this.correctWord,
    required this.letterOptions,
    required this.hint,
  });
}

final List<BuildWordQuestion> buildWordQuestions = [
  BuildWordQuestion(
    correctWord: 'МЯЧ',
    letterOptions: ['М', 'А', 'Я', 'Ч', 'Т'],
    hint: 'assets/images/ball.png',
  ),
  BuildWordQuestion(
    correctWord: 'МАШИНА',
    letterOptions: ['А', 'М', 'Ш', 'Н', 'И'],
    hint: 'assets/images/car.png',
  ),
  BuildWordQuestion(
    correctWord: 'ЛЕС',
    letterOptions: ['Л', 'Е', 'С', 'А', 'Б'],
    hint: 'Это место с деревьями 🌲',
  ),
  BuildWordQuestion(
    correctWord: 'ДОМ',
    letterOptions: ['И', 'О', 'М', 'Д', 'К'],
    hint: 'assets/images/house.png',
  ),
  BuildWordQuestion(
    correctWord: 'НОС',
    letterOptions: ['Ч', 'О', 'С', 'И', 'Н'],
    hint: 'Это часть лица 👃',
  ),
];
