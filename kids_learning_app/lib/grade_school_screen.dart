import 'package:flutter/material.dart';
import 'responsive_scaffold.dart';
import 'assignments/math_assignments_screen.dart';
import 'assignments/russian_language_screen.dart';
import 'assignments/world_around_screen.dart';
import 'assignments/logic_screen.dart';
import 'assignments/spelling_screen.dart';
import 'assignments/grammar_screen.dart';
import 'assignments/english_screen.dart';
import 'assignments/computer_science_screen.dart';
import 'assignments/drawing_screen.dart';

class GradeSchoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Уроки: Начальная школа',
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
                MaterialPageRoute(builder: (_) => MathAssignmentsScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.book,
            title: 'Русский язык',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RussianLanguageScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.nature,
            title: 'Окружающий мир',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WorldAroundScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.psychology,
            title: 'Логика',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LogicScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.spellcheck,
            title: 'Правописание',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SpellingScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.edit_note,
            title: 'Грамматика',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => GrammarScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.language,
            title: 'Английский',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EnglishScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.computer,
            title: 'Информатика',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ComputerScienceScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.brush,
            title: 'Рисование',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DrawingScreen()),
              );
            },
          ),
          _LessonCard(
            icon: Icons.lock_clock,
            title: 'Скоро',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Скоро новый урок! 📚')),
              );
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