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
      question: 'Реши пример: 125 + 378 = ?',
      hint: 'Складывай по разрядам',
      correctAnswer: 503,
    ),
    MathProblem(
      question: 'Реши: 96 ÷ 8 = ?',
      hint: 'Сколько раз 8 помещается в 96?',
      correctAnswer: 12,
    ),
    MathProblem(
      question: 'Реши: 7 × 8 = ?',
      hint: 'Это 7 раз по 8',
      correctAnswer: 56,
    ),
    MathProblem(
      question: 'Реши: 234 - 156 = ?',
      hint: 'Вычитай по разрядам',
      correctAnswer: 78,
    ),
    MathProblem(
      question: 'Реши: 45 × 3 = ?',
      hint: 'Умножь 40 на 3 и 5 на 3, потом сложи',
      correctAnswer: 135,
    ),
    MathProblem(
      question: 'Реши: 84 ÷ 7 = ?',
      hint: 'Сколько раз 7 помещается в 84?',
      correctAnswer: 12,
    ),
    MathProblem(
      question: 'Реши: 256 + 189 = ?',
      hint: 'Складывай по разрядам',
      correctAnswer: 445,
    ),
    MathProblem(
      question: 'Реши: 9 × 9 = ?',
      hint: 'Это 9 раз по 9',
      correctAnswer: 81,
    ),
    MathProblem(
      question: 'Реши: 432 - 287 = ?',
      hint: 'Вычитай по разрядам',
      correctAnswer: 145,
    ),
    MathProblem(
      question: 'Реши: 56 × 4 = ?',
      hint: 'Умножь 50 на 4 и 6 на 4, потом сложи',
      correctAnswer: 224,
    ),
    MathProblem(
      question: 'Реши: 144 ÷ 12 = ?',
      hint: 'Сколько раз 12 помещается в 144?',
      correctAnswer: 12,
    ),
    MathProblem(
      question: 'Реши: 367 + 458 = ?',
      hint: 'Складывай по разрядам',
      correctAnswer: 825,
    ),
    MathProblem(
      question: 'Реши: 8 × 7 = ?',
      hint: 'Это 8 раз по 7',
      correctAnswer: 56,
    ),
    MathProblem(
      question: 'Реши: 528 - 349 = ?',
      hint: 'Вычитай по разрядам',
      correctAnswer: 179,
    ),
    MathProblem(
      question: 'Реши: 72 ÷ 6 = ?',
      hint: 'Сколько раз 6 помещается в 72?',
      correctAnswer: 12,
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