import 'package:flutter/material.dart';
import '../responsive_scaffold.dart';
import 'base_assignment.dart';

class DrawingScreen extends StatefulWidget {
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  int currentAssignmentIndex = 0;
  int score = 0;
  bool showHint = false;
  final TextEditingController _answerController = TextEditingController();

  final List<BaseAssignment> assignments = [
    DrawingAssignment(
      question: 'Как называется инструмент для рисования карандашом?',
      hint: 'Им можно стереть ошибку',
      correctAnswer: 'ластик',
    ),
    DrawingAssignment(
      question: 'Как называется краска, которая разводится водой?',
      hint: 'Ею рисуют в школе',
      correctAnswer: 'акварель',
    ),
    DrawingAssignment(
      question: 'Как называется инструмент для рисования красками?',
      hint: 'У него есть щетина',
      correctAnswer: 'кисть',
    ),
    DrawingAssignment(
      question: 'Как называется краска, которая не разводится водой?',
      hint: 'Она густая и яркая',
      correctAnswer: 'гуашь',
    ),
    DrawingAssignment(
      question: 'Как называется бумага для рисования?',
      hint: 'Она плотная и белая',
      correctAnswer: 'ватман',
    ),
    DrawingAssignment(
      question: 'Как называется инструмент для рисования линий?',
      hint: 'Им чертят прямые линии',
      correctAnswer: 'линейка',
    ),
    DrawingAssignment(
      question: 'Как называется краска, которая сохнет на воздухе?',
      hint: 'Она пластичная',
      correctAnswer: 'пластилин',
    ),
    DrawingAssignment(
      question: 'Как называется инструмент для смешивания красок?',
      hint: 'Он круглый и плоский',
      correctAnswer: 'палитра',
    ),
    DrawingAssignment(
      question: 'Как называется краска для рисования на стекле?',
      hint: 'Она прозрачная',
      correctAnswer: 'витражная',
    ),
    DrawingAssignment(
      question: 'Как называется инструмент для рисования кругов?',
      hint: 'У него две ножки',
      correctAnswer: 'циркуль',
    ),
    DrawingAssignment(
      question: 'Как называется краска для рисования на ткани?',
      hint: 'Она не смывается',
      correctAnswer: 'батик',
    ),
    DrawingAssignment(
      question: 'Как называется инструмент для рисования мелками?',
      hint: 'Он похож на доску',
      correctAnswer: 'мольберт',
    ),
    DrawingAssignment(
      question: 'Как называется краска для рисования на асфальте?',
      hint: 'Ею рисуют мелом',
      correctAnswer: 'мел',
    ),
    DrawingAssignment(
      question: 'Как называется инструмент для рисования тушью?',
      hint: 'У него есть перо',
      correctAnswer: 'перо',
    ),
    DrawingAssignment(
      question: 'Как называется краска для рисования на керамике?',
      hint: 'Она запекается в печи',
      correctAnswer: 'глазурь',
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
      title: 'Рисование',
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

class DrawingAssignment extends BaseAssignment {
  final String correctAnswer;

  DrawingAssignment({
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