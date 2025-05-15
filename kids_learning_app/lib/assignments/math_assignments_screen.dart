import 'package:flutter/material.dart';
import 'base_assignment.dart';
import '../responsive_scaffold.dart';

class MathAssignmentsScreen extends StatefulWidget {
  @override
  _MathAssignmentsScreenState createState() => _MathAssignmentsScreenState();
}

class _MathAssignmentsScreenState extends State<MathAssignmentsScreen> {
  int currentAssignmentIndex = 0;
  int score = 0;
  bool showHint = false;
  final TextEditingController _answerController = TextEditingController();

  final List<BaseAssignment> assignments = [
    MathProblem(
      question: 'Реши пример: 5 + 7 = ?',
      hint: 'Попробуй посчитать на пальцах!',
      correctAnswer: 12,
    ),
    MathProblem(
      question: 'Сколько будет 9 - 4?',
      hint: 'Отсчитай 4 от 9',
      correctAnswer: 5,
    ),
    MathProblem(
      question: 'Реши: 3 × 4 = ?',
      hint: 'Это то же самое, что 3 + 3 + 3 + 3',
      correctAnswer: 12,
    ),
    MathProblem(
      question: 'Реши: 15 + 28 = ?',
      hint: 'Сначала сложи десятки, потом единицы',
      correctAnswer: 43,
    ),
    MathProblem(
      question: 'Реши: 72 - 35 = ?',
      hint: 'Вычитай по разрядам',
      correctAnswer: 37,
    ),
    MathProblem(
      question: 'Реши: 6 × 7 = ?',
      hint: 'Это 6 раз по 7',
      correctAnswer: 42,
    ),
    MathProblem(
      question: 'Реши: 48 ÷ 6 = ?',
      hint: 'Сколько раз 6 помещается в 48?',
      correctAnswer: 8,
    ),
    MathProblem(
      question: 'Реши: 125 + 378 = ?',
      hint: 'Складывай по разрядам',
      correctAnswer: 503,
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

    // Показываем результат
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'Правильно! +${assignment.points} балл' : 'Попробуй еще раз!',
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );

    // Переходим к следующему заданию через 1.5 секунды
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
      title: 'Математика',
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

class MathProblem extends BaseAssignment {
  final int correctAnswer;

  MathProblem({
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
    return answer == correctAnswer;
  }

  @override
  Widget buildAnswerWidget(Function(dynamic) onAnswer, {TextEditingController? answerController}) {
    return Column(
      children: [
        buildTextField(
          controller: answerController!,
          keyboardType: TextInputType.number,
          onSubmitted: (value) {
            final answer = int.tryParse(value);
            if (answer != null) {
              onAnswer(answer);
            }
          },
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final answer = int.tryParse(answerController.text);
            if (answer != null) {
              onAnswer(answer);
            }
          },
          child: Text('Проверить'),
        ),
      ],
    );
  }
} 