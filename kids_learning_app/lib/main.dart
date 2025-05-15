import 'age_selection_screen.dart';
import 'package:flutter/material.dart';
import 'preschool_math_screen.dart';
import 'preschool_letters_screen.dart';
import 'missing_letter_screen.dart';
import 'MatchWordWithImageQuestion.dart';
import 'letter_sounds_screen.dart';
import 'syllable_reading_screen.dart';
import 'build_word_screen.dart';
import 'find_shape_screen.dart';
import 'find_color_screen.dart';
import 'repeat_sound_screen.dart';
import 'responsive_scaffold.dart';
import 'FindSoundInWordScreen.dart';
import 'find_sound_position_screen.dart';
import 'build_word_from_sounds.dart';
import 'grade_school_screen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/build_word_from_sounds': (context) => BuildWordFromSoundsScreen(),
  '/find_sound_position': (context) => FindSoundPositionScreen(),
  '/find_sound': (context) => FindSoundInWordScreen(),
  '/repeat_sound': (context) => RepeatSoundScreen(),
  '/find_color': (context) => FindColorScreen(),
  '/shapes': (context) => FindShapeScreen(),
  '/build_word': (context) => BuildWordScreen(),
  '/syllables': (context) => SyllableReadingScreen(),
  '/sounds': (context) => LetterSoundsScreen(),
  '/image_match': (context) => MatchWordWithImageScreen(),
  '/missing_letter': (context) => MissingLetterScreen(),
  '/letters': (context) => PreschoolLettersScreen(),
  '/lessons': (context) => LessonsScreen(),
  '/speech': (context) => SpeechTherapyScreen(),
  '/grade_school': (context) => GradeSchoolScreen(),
};

void main() {
  runApp(KidsLearningApp());
}

class KidsLearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Учимся вместе',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: StartWrapper(),
      routes: appRoutes,
    );
  }
}


class StartWrapper extends StatefulWidget {
  @override
  State<StartWrapper> createState() => _StartWrapperState();
}

class _StartWrapperState extends State<StartWrapper> {
  String? _group;

  void _handleGroupSelected(String group) {
    setState(() {
      _group = group;
    });
  }

  void _handleChangeGroup() {
    setState(() {
      _group = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_group == null) {
      return AgeSelectionScreen(onContinue: _handleGroupSelected);
    } else {
      return HomeScreen(
        onChangeGroup: _handleChangeGroup,
        group: _group!, // мы уверены, что _group не null
      );
    }
  }
}

class HomeScreen extends StatelessWidget {
  final void Function()? onChangeGroup;
  final String group;

  const HomeScreen({required this.group, this.onChangeGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: Text('Главная'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (onChangeGroup != null) {
              onChangeGroup!();
            }
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Добро пожаловать!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),

              // 👶 Для дошкольников
              if (group == 'preschool') ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/lessons');
                  },
                  child: Text(
                    '📚 Уроки 3–6 лет',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/speech');
                  },
                  child: Text('🗣️ Логопедия', style: TextStyle(fontSize: 20)),
                ),
              ],

              // 👦 Для школьников
              if (group == 'school') ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/grade_school');
                  },
                  child: Text(
                    '📘 Уроки 7–11 лет',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class LessonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Уроки: Дошкольный возраст',
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        children: [
          _LessonCard(
            icon: Icons.calculate,
            title: 'Математика',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PreschoolMathScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.abc,
            title: 'Буквы',
            onTap: () {
              Navigator.pushNamed(context, '/letters');
            },
          ),
          _LessonCard(
            icon: Icons.spellcheck,
            title: 'Найди букву',
            onTap: () {
              Navigator.pushNamed(context, '/missing_letter');
            },
          ),
          _LessonCard(
            icon: Icons.image,
            title: 'Слово и картинка',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MatchWordWithImageScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.hearing,
            title: 'Звуки букв',
            onTap: () {
              Navigator.pushNamed(context, '/sounds');
            },
          ),
          _LessonCard(
            icon: Icons.speaker_notes,
            title: 'Слоговое чтение',
            onTap: () {
              Navigator.pushNamed(context, '/syllables');
            },
          ),
          _LessonCard(
            icon: Icons.spellcheck,
            title: 'Составь слово',
            onTap: () {
              Navigator.pushNamed(context, '/build_word');
            },
          ),
          _LessonCard(
            icon: Icons.circle,
            title: 'Формы',
            onTap: () {
              Navigator.pushNamed(context, '/shapes');
            },
          ),
          _LessonCard(
            icon: Icons.palette,
            title: 'Найди цвет',
            onTap: () {
              Navigator.pushNamed(context, '/find_color');
            },
          ),
          _LessonCard(
            icon: Icons.lock_clock,
            title: 'Скоро',
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Скоро новый урок! 📚')));
            },
          ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _LessonCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.deepPurple.shade100,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.deepPurple),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeechTherapyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Логопедия',
      child: SingleChildScrollView(
        // ← добавлено
        padding: const EdgeInsets.all(20), // немного отступов
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Выбери упражнение',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/repeat_sound');
              },
              child: Text('🔤 Повтори звук', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/find_sound');
              },
              child: Text('🔍 Найди звук', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/find_sound_position');
              },
              child: Text('📍 Позиция звука', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/build_word_from_sounds');
              },
              child: Text(
                '🧩 Собери слово из звуков',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
