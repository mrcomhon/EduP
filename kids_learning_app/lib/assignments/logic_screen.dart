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
      question: 'Продолжи последовательность: 3, 6, 9, 12, ?',
      hint: 'Каждое следующее число больше предыдущего на 3',
      correctAnswer: '15',
    ),
    LogicAssignment(
      question: 'Найди лишнее слово: кошка, собака, попугай, кролик, тигр',
      hint: 'Одно из этих животных - дикое',
      correctAnswer: 'тигр',
    ),
    LogicAssignment(
      question: 'Реши: Если 1=5, 2=10, 3=15, то 4=?',
      hint: 'Каждое число умножается на 5',
      correctAnswer: '20',
    ),
    LogicAssignment(
      question: 'Продолжи: январь, февраль, март, ?',
      hint: 'Месяцы года по порядку',
      correctAnswer: 'апрель',
    ),
    LogicAssignment(
      question: 'Найди лишнее слово: стол, стул, диван, кровать, шкаф, телевизор',
      hint: 'Один предмет не является мебелью',
      correctAnswer: 'телевизор',
    ),
    LogicAssignment(
      question: 'Продолжи последовательность: 5, 10, 15, 20, ?',
      hint: 'Каждое следующее число больше предыдущего на 5',
      correctAnswer: '25',
    ),
    LogicAssignment(
      question: 'Реши: Если красный=1, синий=2, зеленый=3, то желтый=?',
      hint: 'Посчитай порядок цветов радуги',
      correctAnswer: '4',
    ),
    LogicAssignment(
      question: 'Найди лишнее слово: ручка, карандаш, линейка, тетрадь, учебник, ластик',
      hint: 'Один предмет не является канцелярским',
      correctAnswer: 'учебник',
    ),
    LogicAssignment(
      question: 'Продолжи: весна, лето, осень, ?',
      hint: 'Времена года по порядку',
      correctAnswer: 'зима',
    ),
    LogicAssignment(
      question: 'Реши: Если 2×2=4, 3×3=9, 4×4=16, то 5×5=?',
      hint: 'Каждое число умножается само на себя',
      correctAnswer: '25',
    ),
    LogicAssignment(
      question: 'Продолжи последовательность: 2, 4, 8, 16, ?',
      hint: 'Каждое следующее число умножается на 2',
      correctAnswer: '32',
    ),
    LogicAssignment(
      question: 'Найди лишнее слово: Москва, Санкт-Петербург, Новосибирск, Екатеринбург, Сочи, Париж',
      hint: 'Один город находится в другой стране',
      correctAnswer: 'париж',
    ),
    LogicAssignment(
      question: 'Реши: Если А=1, Б=2, В=3, то Г=?',
      hint: 'Посмотри на порядок букв в алфавите',
      correctAnswer: '4',
    ),
    LogicAssignment(
      question: 'Продолжи: понедельник, вторник, среда, ?',
      hint: 'Дни недели по порядку',
      correctAnswer: 'четверг',
    ),
    LogicAssignment(
      question: 'Найди лишнее слово: яблоко, груша, морковь, слива',
      hint: 'Одно из этих слов - овощ',
      correctAnswer: 'морковь',
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