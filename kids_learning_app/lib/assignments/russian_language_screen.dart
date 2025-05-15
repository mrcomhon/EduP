import 'package:flutter/material.dart';
import '../responsive_scaffold.dart';
import 'base_assignment.dart';

class RussianLanguageScreen extends StatefulWidget {
  @override
  _RussianLanguageScreenState createState() => _RussianLanguageScreenState();
}

class _RussianLanguageScreenState extends State<RussianLanguageScreen> {
  int currentAssignmentIndex = 0;
  int score = 0;
  bool showHint = false;
  final TextEditingController _answerController = TextEditingController();

  final List<BaseAssignment> assignments = [
    RussianAssignment(
      question: 'Вставь пропущенную букву: м_шина',
      hint: 'Это транспортное средство',
      correctAnswer: 'а',
    ),
    RussianAssignment(
      question: 'Выбери правильное окончание: красив_ дом',
      hint: 'Мужской род',
      correctAnswer: 'ый',
    ),
    RussianAssignment(
      question: 'Вставь пропущенную букву: _кно',
      hint: 'Через него смотрят на улицу',
      correctAnswer: 'о',
    ),
    RussianAssignment(
      question: 'Выбери правильное окончание: высок_ гора',
      hint: 'Женский род',
      correctAnswer: 'ая',
    ),
    RussianAssignment(
      question: 'Вставь пропущенную букву: _зык',
      hint: 'Орган вкуса',
      correctAnswer: 'я',
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
      title: 'Русский язык',
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

class RussianAssignment extends BaseAssignment {
  final String correctAnswer;

  RussianAssignment({
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