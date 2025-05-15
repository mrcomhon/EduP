import 'package:flutter/material.dart';
import '../responsive_scaffold.dart';
import 'base_assignment.dart';

class EnglishScreen extends StatefulWidget {
  @override
  _EnglishScreenState createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen> {
  int currentAssignmentIndex = 0;
  int score = 0;
  bool showHint = false;
  final TextEditingController _answerController = TextEditingController();

  final List<BaseAssignment> assignments = [
    EnglishAssignment(
      question: 'Переведи слово "кот" на английский',
      hint: 'Это слово начинается на "c"',
      correctAnswer: 'cat',
    ),
    EnglishAssignment(
      question: 'Как будет "яблоко" по-английски?',
      hint: 'Это слово начинается на "a"',
      correctAnswer: 'apple',
    ),
    EnglishAssignment(
      question: 'Переведи фразу "Я люблю читать"',
      hint: 'I love to...',
      correctAnswer: 'i love to read',
    ),
    EnglishAssignment(
      question: 'Как будет "собака" по-английски?',
      hint: 'Это слово начинается на "d"',
      correctAnswer: 'dog',
    ),
    EnglishAssignment(
      question: 'Переведи слово "книга"',
      hint: 'Это слово начинается на "b"',
      correctAnswer: 'book',
    ),
    EnglishAssignment(
      question: 'Как будет "школа" по-английски?',
      hint: 'Это слово начинается на "s"',
      correctAnswer: 'school',
    ),
    EnglishAssignment(
      question: 'Переведи фразу "Я учусь в школе"',
      hint: 'I study at...',
      correctAnswer: 'i study at school',
    ),
    EnglishAssignment(
      question: 'Как будет "ручка" по-английски?',
      hint: 'Это слово начинается на "p"',
      correctAnswer: 'pen',
    ),
    EnglishAssignment(
      question: 'Переведи слово "стол"',
      hint: 'Это слово начинается на "t"',
      correctAnswer: 'table',
    ),
    EnglishAssignment(
      question: 'Как будет "окно" по-английски?',
      hint: 'Это слово начинается на "w"',
      correctAnswer: 'window',
    ),
    EnglishAssignment(
      question: 'Переведи фразу "Я играю в футбол"',
      hint: 'I play...',
      correctAnswer: 'i play football',
    ),
    EnglishAssignment(
      question: 'Как будет "мама" по-английски?',
      hint: 'Это слово начинается на "m"',
      correctAnswer: 'mother',
    ),
    EnglishAssignment(
      question: 'Переведи слово "папа"',
      hint: 'Это слово начинается на "f"',
      correctAnswer: 'father',
    ),
    EnglishAssignment(
      question: 'Как будет "сестра" по-английски?',
      hint: 'Это слово начинается на "s"',
      correctAnswer: 'sister',
    ),
    EnglishAssignment(
      question: 'Переведи фразу "Я люблю свою семью"',
      hint: 'I love my...',
      correctAnswer: 'i love my family',
    ),
  ];

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _handleAnswer(dynamic answer) {
    final assignment = assignments[currentAssignmentIndex];
    final isCorrect = assignment.checkAnswer(answer);

    setState(() {
      if (isCorrect) {
        score += assignment.points;
        assignment.isCorrect = true;
      }
      assignment.isCompleted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'Правильно! +${assignment.points} балл' : 'Попробуй еще раз!',
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );

    if (currentAssignmentIndex < assignments.length - 1) {
      Future.delayed(Duration(milliseconds: 1500), () {
        setState(() {
          currentAssignmentIndex++;
          showHint = false;
          _answerController.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Английский язык',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Счет: $score',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      showHint = !showHint;
                    });
                  },
                  icon: Icon(Icons.lightbulb_outline),
                  label: Text('Подсказка'),
                ),
              ],
            ),
          ),
          Expanded(
            child: AssignmentCard(
              assignment: assignments[currentAssignmentIndex],
              onAnswer: _handleAnswer,
              showHint: showHint,
              answerController: _answerController,
            ),
          ),
        ],
      ),
    );
  }
}

class EnglishAssignment extends BaseAssignment {
  final String correctAnswer;

  EnglishAssignment({
    required String question,
    String? hint,
    required this.correctAnswer,
  }) : super(question: question, hint: hint);

  @override
  Widget buildQuestionWidget() {
    return Text(question);
  }

  @override
  bool checkAnswer(dynamic answer) {
    return answer.toString().toLowerCase() == correctAnswer.toLowerCase();
  }

  @override
  Widget buildAnswerWidget(Function(dynamic) onAnswer, {TextEditingController? answerController}) {
    return Column(
      children: [
        buildTextField(
          controller: answerController!,
          onSubmitted: (value) => onAnswer(value),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            onAnswer(answerController.text);
          },
          child: Text('Проверить'),
        ),
      ],
    );
  }
} 