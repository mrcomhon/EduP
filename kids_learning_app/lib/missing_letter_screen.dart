import 'package:flutter/material.dart';

class MissingLetterScreen extends StatefulWidget {
  @override
  _MissingLetterScreenState createState() => _MissingLetterScreenState();
}

class _MissingLetterScreenState extends State<MissingLetterScreen> {
  int currentIndex = 0;
  String? feedback;
  int correctCount = 0;

  void checkAnswer(String selected) {
    final correct = missingLetterQuestions[currentIndex].correctLetter;
    setState(() {
      feedback = (selected == correct) ? 'Верно! 🎉' : 'Неправильно 🙁';
      if (selected == correct) correctCount++;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentIndex < missingLetterQuestions.length - 1) {
          currentIndex++;
          feedback = null;
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Молодец!'),
                  content: Text(
                    'Ты нашёл $correctCount из ${missingLetterQuestions.length} букв.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          currentIndex = 0;
                          correctCount = 0;
                          feedback = null;
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
  Widget build(BuildContext context) {
    final q = missingLetterQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('🧩 Найди букву')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
              Text(
              'Задание ${currentIndex + 1} из ${missingLetterQuestions.length}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            Text(
              'Слово:',
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              q.wordWithBlank,
              style: TextStyle(fontSize: 48, letterSpacing: 4),
            ),
            SizedBox(height: 30),
            ...q.options.map(
              (letter) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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

class MissingLetterQuestion {
  final String wordWithBlank;
  final List<String> options;
  final String correctLetter;

  MissingLetterQuestion({
    required this.wordWithBlank,
    required this.options,
    required this.correctLetter,
  });
}

final List<MissingLetterQuestion> missingLetterQuestions = [
  MissingLetterQuestion(
    wordWithBlank: 'К_Т',
    options: ['О', 'А', 'Е'],
    correctLetter: 'О',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'М_ЛО',
    options: ['А', 'Ы', 'У'],
    correctLetter: 'Ы',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'С_ЛНЦЕ',
    options: ['А', 'О', 'Е'],
    correctLetter: 'О',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'Д_М',
    options: ['Е', 'А', 'О'],
    correctLetter: 'О',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'З_ЯЦ',
    options: ['Е', 'А', 'Я'],
    correctLetter: 'А',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'М_ШИНА',
    options: ['О', 'А', 'У'],
    correctLetter: 'А',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'К_РОВА',
    options: ['А', 'О', 'И'],
    correctLetter: 'О',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'ЗА_Ц',
    options: ['Е', 'И', 'Я'],
    correctLetter: 'Я',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'РЫ_КА',
    options: ['Б', 'П', 'С'],
    correctLetter: 'Б',
  ),
  MissingLetterQuestion(
    wordWithBlank: 'Л_С',
    options: ['И', 'Е', 'А'],
    correctLetter: 'Е',
  ),
];
