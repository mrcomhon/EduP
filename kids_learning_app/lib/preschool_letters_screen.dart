import 'package:flutter/material.dart';

class PreschoolLettersScreen extends StatefulWidget {
  @override
  _PreschoolLettersScreenState createState() => _PreschoolLettersScreenState();
}

class _PreschoolLettersScreenState extends State<PreschoolLettersScreen> {
  int currentIndex = 0;
  String? feedback;
  int correctCount = 0;

  void checkAnswer(String selected) {
    final correct = letterQuestions[currentIndex].correctWord;
    setState(() {
      feedback = (selected == correct) ? 'Верно! 🎉' : 'Попробуй ещё 🙃';
      if (selected == correct) correctCount++;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        if (currentIndex < letterQuestions.length - 1) {
          currentIndex++;
          feedback = null;
        } else {
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text('Молодец!'),
                  content: Text(
                    'Ты правильно ответил на $correctCount из ${letterQuestions.length}',
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
    final q = letterQuestions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('🔤 Изучаем буквы')),
body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Задание ${currentIndex + 1} из ${letterQuestions.length}',
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Выбери слово на букву "${q.letter}"',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.purple.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            q.letter,
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ...q.options.map(
                      (word) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 400),
                            child: ElevatedButton(
                              onPressed: () => checkAnswer(word),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              child: Text(
                                word,
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (feedback != null) ...[
                      SizedBox(height: 20),
                      Text(
                        feedback!,
                        style: TextStyle(
                          fontSize: 22,
                          color:
                              feedback == 'Верно! 🎉'
                                  ? Colors.green
                                  : Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LetterQuestion {
  final String letter;
  final List<String> options;
  final String correctWord;

  LetterQuestion({
    required this.letter,
    required this.options,
    required this.correctWord,
  });
}

final List<LetterQuestion> letterQuestions = [
  LetterQuestion(
    letter: 'А',
    options: ['Арбуз', 'Слон', 'Рыба'],
    correctWord: 'Арбуз',
  ),
  LetterQuestion(
    letter: 'Б',
    options: ['Мяч', 'Бабочка', 'Дерево'],
    correctWord: 'Бабочка',
  ),
  LetterQuestion(
    letter: 'В',
    options: ['Волк', 'Кот', 'Торт'],
    correctWord: 'Волк',
  ),
  LetterQuestion(
    letter: 'Г',
    options: ['Гриб', 'Птица', 'Дом'],
    correctWord: 'Гриб',
  ),
  LetterQuestion(
    letter: 'Д',
    options: ['Яблоко', 'Лев', 'Дом'],
    correctWord: 'Дом',
  ),
  LetterQuestion(
    letter: 'Е',
    options: ['Ёжик', 'Ель', 'Зонт'],
    correctWord: 'Ель',
  ),
  LetterQuestion(
    letter: 'Ж',
    options: ['Жук', 'Машина', 'Карандаш'],
    correctWord: 'Жук',
  ),
  LetterQuestion(
    letter: 'З',
    options: ['Заяц', 'Носорог', 'Кукуруза'],
    correctWord: 'Заяц',
  ),
  LetterQuestion(
    letter: 'И',
    options: ['Игла', 'Стул', 'Кот'],
    correctWord: 'Игла',
  ),
  LetterQuestion(
    letter: 'Й',
    options: ['Йогурт', 'Торт', 'Ручка'],
    correctWord: 'Йогурт',
  ),
  LetterQuestion(
    letter: 'К',
    options: ['Кошка', 'Апельсин', 'Молоко'],
    correctWord: 'Кошка',
  ),
  LetterQuestion(
    letter: 'Л',
    options: ['Лимон', 'Снег', 'Груша'],
    correctWord: 'Лимон',
  ),
  LetterQuestion(
    letter: 'М',
    options: ['Машина', 'Облако', 'Слон'],
    correctWord: 'Машина',
  ),
  LetterQuestion(
    letter: 'Н',
    options: ['Нос', 'Чайник', 'Книга'],
    correctWord: 'Нос',
  ),
  LetterQuestion(
    letter: 'О',
    options: ['Окно', 'Медведь', 'Тетрадь'],
    correctWord: 'Окно',
  ),
  LetterQuestion(
    letter: 'П',
    options: ['Панда', 'Молоко', 'Собака'],
    correctWord: 'Панда',
  ),
  LetterQuestion(
    letter: 'Р',
    options: ['Ракета', 'Сыр', 'Бабочка'],
    correctWord: 'Ракета',
  ),

   LetterQuestion(
    letter: 'С',
    options: ['Собака', 'Яблоко', 'Дерево'],
    correctWord: 'Собака',
  ),
  LetterQuestion(
    letter: 'Т',
    options: ['Торт', 'Лиса', 'Река'],
    correctWord: 'Торт',
  ),
  LetterQuestion(
    letter: 'У',
    options: ['Утка', 'Кошка', 'Мяч'],
    correctWord: 'Утка',
  ),
  LetterQuestion(
    letter: 'Ф',
    options: ['Флаг', 'Машина', 'Стол'],
    correctWord: 'Флаг',
  ),
  LetterQuestion(
    letter: 'Х',
    options: ['Хлеб', 'Молоко', 'Вилка'],
    correctWord: 'Хлеб',
  ),
  LetterQuestion(
    letter: 'Ц',
    options: ['Цапля', 'Ручка', 'Груша'],
    correctWord: 'Цапля',
  ),
  LetterQuestion(
    letter: 'Ч',
    options: ['Чайник', 'Снег', 'Медведь'],
    correctWord: 'Чайник',
  ),
  LetterQuestion(
    letter: 'Ш',
    options: ['Шарик', 'Петух', 'Облако'],
    correctWord: 'Шарик',
  ),
  LetterQuestion(
    letter: 'Щ',
    options: ['Щука', 'Тетрадь', 'Печенье'],
    correctWord: 'Щука',
  ),
  LetterQuestion(
    letter: 'Ъ',
    options: ['Подъезд', 'Ёлка', 'Арбуз'],
    correctWord: 'Подъезд',
  ),
    LetterQuestion(
    letter: 'Ы',
    options: ['Таракан', 'Носок', 'Лыжи'],
    correctWord: 'Лыжи',
  ),
  LetterQuestion(
    letter: 'Ь',
    options: ['Лошадь', 'Книга', 'Дверь'],
    correctWord: 'Лошадь',
  ),
  LetterQuestion(
    letter: 'Э',
    options: ['Экран', 'Печка', 'Торт'],
    correctWord: 'Экран',
  ),
  LetterQuestion(
    letter: 'Ю',
    options: ['Юла', 'Чашка', 'Котёнок'],
    correctWord: 'Юла',
  ),
  LetterQuestion(
    letter: 'Я',
    options: ['Яблоко', 'Рыба', 'Машина'],
    correctWord: 'Яблоко',
  ),
];
