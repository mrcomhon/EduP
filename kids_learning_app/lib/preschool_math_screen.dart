import 'package:flutter/material.dart';

class PreschoolMathScreen extends StatefulWidget {
  @override
  _PreschoolMathScreenState createState() => _PreschoolMathScreenState();
}

class _PreschoolMathScreenState extends State<PreschoolMathScreen> {
  int currentIndex = 0;
  int score = 0;
  String? feedback;

  void checkAnswer(String selected) {
    final correct = questions[currentIndex].correctAnswer;
    setState(() {
      if (selected == correct) {
        score++;
        feedback = '✅ Молодец!';
      } else {
        feedback = '❌ Неправильно, попробуй ещё.';
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentIndex < questions.length - 1) {
          currentIndex++;
          feedback = null;
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (_) => AlertDialog(
                  title: Text('Результат'),
                  content: Text(
                    'Ты набрал $score из ${questions.length} баллов! 🎉',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          currentIndex = 0;
                          score = 0;
                          feedback = null;
                        });
                      },
                      child: Text('Пройти заново'),
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
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Математика для дошкольников')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Задание ${currentIndex + 1} из ${questions.length}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    if (question.imageAsset != null)
                      Image.asset(question.imageAsset!, height: 150),
                    SizedBox(height: 20),
                    Text(
                      question.question,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ...question.options.map(
                      (option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(option),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(option, style: TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ),
                    if (feedback != null) ...[
                      SizedBox(height: 20),
                      Text(
                        feedback!,
                        style: TextStyle(
                          fontSize: 22,
                          color:
                              feedback!.contains('Молодец')
                                  ? Colors.green
                                  : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionData {
  final String question;
  final String? imageAsset;
  final List<String> options;
  final String correctAnswer;

  QuestionData({
    required this.question,
    this.imageAsset,
    required this.options,
    required this.correctAnswer,
  });
}

final List<QuestionData> questions = [
  QuestionData(
    question: 'Сколько яблок?',
    imageAsset: 'assets/apples_3.png',
    options: ['2', '3', '4'],
    correctAnswer: '3',
  ),
  QuestionData(
    question: '2 + 1 = ?',
    options: ['2', '3', '4'],
    correctAnswer: '3',
  ),
  QuestionData(
    question: 'Что больше?',
    options: ['5', '3', '2'],
    correctAnswer: '5',
  ),
  QuestionData(
    question: 'Сколько здесь предметов?',
    imageAsset: 'assets/balls_4.png',
    options: ['4', '5', '3'],
    correctAnswer: '4',
  ),
  QuestionData(
    question: '1 + 2 = ?',
    options: ['4', '3', '2'],
    correctAnswer: '3',
  ),
  QuestionData(
    question: 'Где меньше?',
    options: ['1', '3', '2'],
    correctAnswer: '1',
  ),
  QuestionData(
    question: 'Сколько квадратов?',
    imageAsset: 'assets/squares_2.png',
    options: ['2', '3', '1'],
    correctAnswer: '2',
  ),
  QuestionData(
    question: '3 + 2 = ?',
    options: ['4', '5', '6'],
    correctAnswer: '5',
  ),
  QuestionData(
    question: 'Что больше?',
    options: ['6', '4', '5'],
    correctAnswer: '6',
  ),
  QuestionData(
    question: '2 + 3 = ?',
    options: ['4', '6', '5'],
    correctAnswer: '5',
  ),
];
