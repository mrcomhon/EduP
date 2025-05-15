import 'package:flutter/material.dart';
import '../responsive_scaffold.dart';
import 'base_assignment.dart';

class WorldAroundScreen extends StatefulWidget {
  @override
  _WorldAroundScreenState createState() => _WorldAroundScreenState();
}

class _WorldAroundScreenState extends State<WorldAroundScreen> {
  int currentAssignmentIndex = 0;
  int score = 0;
  bool showHint = false;
  final TextEditingController _answerController = TextEditingController();

  final List<BaseAssignment> assignments = [
    WorldAssignment(
      question: 'Какое животное не является млекопитающим: кит, дельфин, акула?',
      hint: 'Одно из этих животных откладывает яйца',
      correctAnswer: 'акула',
    ),
    WorldAssignment(
      question: 'Какое время года наступает после лета?',
      hint: 'Листья желтеют и опадают',
      correctAnswer: 'осень',
    ),
    WorldAssignment(
      question: 'Какая планета ближе всего к Солнцу?',
      hint: 'Самая маленькая планета',
      correctAnswer: 'меркурий',
    ),
    WorldAssignment(
      question: 'Какое животное не является хищником: лев, волк, кролик?',
      hint: 'Это животное питается растениями',
      correctAnswer: 'кролик',
    ),
    WorldAssignment(
      question: 'Какой океан самый большой?',
      hint: 'Начинается на букву "Т"',
      correctAnswer: 'тихий',
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
      title: 'Окружающий мир',
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

class WorldAssignment extends BaseAssignment {
  final String correctAnswer;

  WorldAssignment({
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
        TextField(
          controller: answerController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Введите ответ',
          ),
          onSubmitted: (value) => onAnswer(value),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            onAnswer(answerController?.text ?? '');
          },
          child: Text('Проверить'),
        ),
      ],
    );
  }
} 