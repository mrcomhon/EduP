import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseAssignment {
  final String question;
  final String? hint;
  final int points;
  bool isCompleted;
  bool isCorrect;

  BaseAssignment({
    required this.question,
    this.hint,
    this.points = 1,
    this.isCompleted = false,
    this.isCorrect = false,
  });

  Widget buildQuestionWidget();
  bool checkAnswer(dynamic answer);
  Widget buildAnswerWidget(Function(dynamic) onAnswer, {TextEditingController? answerController});

  // Common TextField configuration for Cyrillic support
  InputDecoration getTextFieldDecoration(String labelText) {
    return InputDecoration(
      border: OutlineInputBorder(),
      labelText: labelText,
    );
  }

  TextField buildTextField({
    required TextEditingController controller,
    required Function(String) onSubmitted,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      decoration: getTextFieldDecoration('Введите ответ'),
      onSubmitted: onSubmitted,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[а-яА-Яa-zA-Z0-9\s]')),
      ],
    );
  }
}

class AssignmentCard extends StatelessWidget {
  final BaseAssignment assignment;
  final Function(dynamic) onAnswer;
  final bool showHint;
  final TextEditingController answerController;

  const AssignmentCard({
    Key? key,
    required this.assignment,
    required this.onAnswer,
    required this.answerController,
    this.showHint = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              assignment.question,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (showHint && assignment.hint != null) ...[
              SizedBox(height: 8),
              Text(
                'Подсказка: ${assignment.hint}',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ],
            SizedBox(height: 16),
            assignment.buildAnswerWidget(onAnswer, answerController: answerController),
          ],
        ),
      ),
    );
  }
} 