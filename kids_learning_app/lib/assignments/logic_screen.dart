import 'package:flutter/material.dart';
import '../responsive_scaffold.dart';
import 'base_assignment.dart';

class LogicScreen extends StatefulWidget {
  @override
  _LogicScreenState createState() => _LogicScreenState();
}

class _LogicScreenState extends State<LogicScreen> {
  int currentAssignmentIndex = 0;
  int score = 0;
  bool showHint = false;
  final TextEditingController _answerController = TextEditingController();

  final List<BaseAssignment> assignments = [
    LogicAssignment(
      question: 'Продолжи последовательность: 2, 4, 6, 8, ?',
      hint: 'Каждое следующее число больше предыдущего на 2',
      correctAnswer: '10',
    ),
    LogicAssignment(
      question: 'Найди лишнее слово: яблоко, груша, морковь, слива',
      hint: 'Одно из этих слов - овощ',
      correctAnswer: 'морковь',
    ),
    LogicAssignment(
      question: 'Реши: Если А=1, Б=2, В=3, то Г=?',
      hint: 'Посмотри на порядок букв в алфавите',
      correctAnswer: '4',
    ),
    LogicAssignment(
      question: 'Сколько треугольников на картинке? (3 линии пересекаются)',
      hint: 'Посчитай все возможные треугольники',
      correctAnswer: '7',
    ),
    LogicAssignment(
      question: 'Продолжи: понедельник, вторник, среда, ?',
      hint: 'Дни недели по порядку',
      correctAnswer: 'четверг',
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
      title: 'Логика',
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

class LogicAssignment extends BaseAssignment {
  final String correctAnswer;

  LogicAssignment({
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