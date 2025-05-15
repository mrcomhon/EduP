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
    WorldAroundAssignment(
      question: 'Какое животное впадает в спячку зимой?',
      hint: 'Это животное живет в лесу и любит мед',
      correctAnswer: 'медведь',
    ),
    WorldAroundAssignment(
      question: 'Какое время года наступает после лета?',
      hint: 'В это время года листья желтеют и опадают',
      correctAnswer: 'осень',
    ),
    WorldAroundAssignment(
      question: 'Какая планета самая большая в солнечной системе?',
      hint: 'Эта планета названа в честь римского бога',
      correctAnswer: 'юпитер',
    ),
    WorldAroundAssignment(
      question: 'Какой океан самый большой на Земле?',
      hint: 'Этот океан омывает берега Азии и Америки',
      correctAnswer: 'тихий',
    ),
    WorldAroundAssignment(
      question: 'Какое животное самое быстрое на суше?',
      hint: 'Это животное из семейства кошачьих',
      correctAnswer: 'гепард',
    ),
    WorldAroundAssignment(
      question: 'Какая птица не умеет летать?',
      hint: 'Эта птица живет в Антарктиде',
      correctAnswer: 'пингвин',
    ),
    WorldAroundAssignment(
      question: 'Какое животное самое большое на Земле?',
      hint: 'Это животное живет в океане',
      correctAnswer: 'синий кит',
    ),
    WorldAroundAssignment(
      question: 'Какая планета ближе всего к Солнцу?',
      hint: 'Эта планета названа в честь римского бога торговли',
      correctAnswer: 'меркурий',
    ),
    WorldAroundAssignment(
      question: 'Какой материк самый маленький?',
      hint: 'Этот материк находится в южном полушарии',
      correctAnswer: 'австралия',
    ),
    WorldAroundAssignment(
      question: 'Какое животное самое высокое на Земле?',
      hint: 'У этого животного очень длинная шея',
      correctAnswer: 'жираф',
    ),
    WorldAroundAssignment(
      question: 'Какая птица самая большая в мире?',
      hint: 'Эта птица не умеет летать и живет в Африке',
      correctAnswer: 'страус',
    ),
    WorldAroundAssignment(
      question: 'Какой океан самый маленький?',
      hint: 'Этот океан находится на севере',
      correctAnswer: 'северный ледовитый',
    ),
    WorldAroundAssignment(
      question: 'Какое животное самое ядовитое?',
      hint: 'Это животное живет в Австралии',
      correctAnswer: 'кубомедуза',
    ),
    WorldAroundAssignment(
      question: 'Какая планета известна своими кольцами?',
      hint: 'Эта планета названа в честь римского бога земледелия',
      correctAnswer: 'сатурн',
    ),
    WorldAroundAssignment(
      question: 'Какой материк самый большой?',
      hint: 'На этом материке находится Россия',
      correctAnswer: 'евразия',
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

class WorldAroundAssignment extends BaseAssignment {
  final String correctAnswer;

  WorldAroundAssignment({
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