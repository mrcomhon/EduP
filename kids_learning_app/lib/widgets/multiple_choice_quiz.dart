import 'package:flutter/material.dart';

class QuizQuestion {
  final String prompt;
  final String display;
  final List<String> options;
  final String correct;

  QuizQuestion({
    required this.prompt,
    required this.display,
    required this.options,
    required this.correct,
  });
}

class MultipleChoiceQuiz extends StatefulWidget {
  final String title;
  final List<QuizQuestion> questions;

  const MultipleChoiceQuiz({
    required this.title,
    required this.questions,
    super.key,
  });

  @override
  State<MultipleChoiceQuiz> createState() => _MultipleChoiceQuizState();
}

class _MultipleChoiceQuizState extends State<MultipleChoiceQuiz> {
  int currentIndex = 0;
  int correctCount = 0;
  String? feedback;

  void checkAnswer(String selected) {
    final current = widget.questions[currentIndex];
    setState(() {
      feedback = selected == current.correct ? 'Верно! 🎉' : 'Попробуй ещё 🙃';
      if (selected == current.correct) correctCount++;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (currentIndex < widget.questions.length - 1) {
          currentIndex++;
          feedback = null;
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text('Молодец!'),
                  content: Text(
                    'Ты правильно ответил на $correctCount из ${widget.questions.length}',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          currentIndex = 0;
                          correctCount = 0;
                          feedback = null;
                        });
                      },
                      child: const Text('Начать заново'),
                    ),
                  ],
                ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Задание ${currentIndex + 1} из ${widget.questions.length}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            Text(
              q.prompt,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.purple.shade100,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  q.display,
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...q.options.map(
              (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(option),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(option, style: const TextStyle(fontSize: 20)),
                ),
              ),
            ),
            if (feedback != null) ...[
              const SizedBox(height: 20),
              Text(
                feedback!,
                style: TextStyle(
                  fontSize: 22,
                  color: feedback == 'Верно! 🎉' ? Colors.green : Colors.red,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
