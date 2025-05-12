import 'package:flutter/material.dart';

class MatchWordWithImageScreen extends StatefulWidget {
  @override
  _MatchWordWithImageScreenState createState() =>
      _MatchWordWithImageScreenState();
}

class _MatchWordWithImageScreenState extends State<MatchWordWithImageScreen> {
  int currentIndex = 0;
  String? feedback;
  int correctCount = 0;

  void checkAnswer(int selectedIndex) {
    final correctIndex = imageMatchQuestions[currentIndex].correctImageIndex;
    setState(() {
      feedback =
          (selectedIndex == correctIndex) ? 'Верно! 🎉' : 'Неправильно 🙃';
      if (selectedIndex == correctIndex) correctCount++;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentIndex < imageMatchQuestions.length - 1) {
          currentIndex++;
          feedback = null;
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Молодец!'),
                  content: Text(
                    'Ты правильно ответил на $correctCount из ${imageMatchQuestions.length}',
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
                      child: Text('Начать заново'),
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
    final q = imageMatchQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('🖼️ Слово и картинка')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Задание ${currentIndex + 1} из ${imageMatchQuestions.length}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            Text(
              'Найди картинку для слова:',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              q.word,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: List.generate(q.imagePaths.length, (index) {
                  return InkWell(
                    onTap: () => checkAnswer(index),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          q.imagePaths[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            if (feedback != null) ...[
              Text(
                feedback!,
                style: TextStyle(
                  fontSize: 22,
                  color: feedback == 'Верно! 🎉' ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class MatchWordWithImageQuestion {
  final String word;
  final List<String> imagePaths;
  final int correctImageIndex;

  MatchWordWithImageQuestion({
    required this.word,
    required this.imagePaths,
    required this.correctImageIndex,
  });
}

final List<MatchWordWithImageQuestion> imageMatchQuestions = [
  MatchWordWithImageQuestion(
    word: 'Мяч',
    imagePaths: [
      'assets/images/ball.png',
      'assets/images/apple.png',
      'assets/images/car.png',
    ],
    correctImageIndex: 0,
  ),
  MatchWordWithImageQuestion(
    word: 'Яблоко',
    imagePaths: [
      'assets/images/dog.png',
      'assets/images/apple.png',
      'assets/images/house.png',
    ],
    correctImageIndex: 1,
  ),
  MatchWordWithImageQuestion(
    word: 'Машина',
    imagePaths: [
      'assets/images/ball.png',
      'assets/images/car.png',
      'assets/images/tree.png',
    ],
    correctImageIndex: 1,
  ),
   MatchWordWithImageQuestion(
    word: 'Трава',
    imagePaths: [
      'assets/images/grass.png',
      'assets/images/dirt.png',
      'assets/images/tree.png',
    ],
    correctImageIndex: 0,
   ),
    MatchWordWithImageQuestion(
    word: 'Велосипед',
    imagePaths: [
      'assets/images/plane.png',
      'assets/images/skateboard.png',
      'assets/images/bicycle.png',
    ],
    correctImageIndex: 2,
    ),
];
