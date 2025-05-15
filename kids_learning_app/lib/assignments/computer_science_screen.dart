import 'package:flutter/material.dart';
import '../responsive_scaffold.dart';
import 'base_assignment.dart';

class ComputerScienceScreen extends StatefulWidget {
  @override
  _ComputerScienceScreenState createState() => _ComputerScienceScreenState();
}

class _ComputerScienceScreenState extends State<ComputerScienceScreen> {
  int currentAssignmentIndex = 0;
  int score = 0;
  bool showHint = false;
  final TextEditingController _answerController = TextEditingController();

  final List<BaseAssignment> assignments = [
    ComputerScienceAssignment(
      question: 'Как называется устройство для ввода текста?',
      hint: 'На нем есть буквы и цифры',
      correctAnswer: 'клавиатура',
    ),
    ComputerScienceAssignment(
      question: 'Как называется устройство для вывода изображения?',
      hint: 'Оно похоже на телевизор',
      correctAnswer: 'монитор',
    ),
    ComputerScienceAssignment(
      question: 'Как называется основная часть компьютера?',
      hint: 'В ней находится процессор',
      correctAnswer: 'системный блок',
    ),
    ComputerScienceAssignment(
      question: 'Как называется устройство для управления курсором?',
      hint: 'Оно похоже на мышь',
      correctAnswer: 'мышь',
    ),
    ComputerScienceAssignment(
      question: 'Как называется программа для просмотра веб-страниц?',
      hint: 'Например, Chrome или Firefox',
      correctAnswer: 'браузер',
    ),
    ComputerScienceAssignment(
      question: 'Как называется файл с текстом?',
      hint: 'Он имеет расширение .txt',
      correctAnswer: 'текстовый документ',
    ),
    ComputerScienceAssignment(
      question: 'Как называется папка для временных файлов?',
      hint: 'В ней хранятся удаленные файлы',
      correctAnswer: 'корзина',
    ),
    ComputerScienceAssignment(
      question: 'Как называется устройство для печати?',
      hint: 'Оно печатает на бумаге',
      correctAnswer: 'принтер',
    ),
    ComputerScienceAssignment(
      question: 'Как называется программа для рисования?',
      hint: 'В ней можно рисовать красками',
      correctAnswer: 'paint',
    ),
    ComputerScienceAssignment(
      question: 'Как называется устройство для сканирования?',
      hint: 'Оно копирует изображения с бумаги',
      correctAnswer: 'сканер',
    ),
    ComputerScienceAssignment(
      question: 'Как называется программа для вычислений?',
      hint: 'В ней можно делать таблицы',
      correctAnswer: 'excel',
    ),
    ComputerScienceAssignment(
      question: 'Как называется устройство для вывода звука?',
      hint: 'Оно надевается на уши',
      correctAnswer: 'наушники',
    ),
    ComputerScienceAssignment(
      question: 'Как называется программа для презентаций?',
      hint: 'В ней можно делать слайды',
      correctAnswer: 'powerpoint',
    ),
    ComputerScienceAssignment(
      question: 'Как называется устройство для ввода изображения?',
      hint: 'Оно делает фотографии',
      correctAnswer: 'камера',
    ),
    ComputerScienceAssignment(
      question: 'Как называется программа для работы с текстом?',
      hint: 'В ней можно писать документы',
      correctAnswer: 'word',
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
      title: 'Информатика',
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

class ComputerScienceAssignment extends BaseAssignment {
  final String correctAnswer;

  ComputerScienceAssignment({
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