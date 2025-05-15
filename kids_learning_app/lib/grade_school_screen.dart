import 'package:flutter/material.dart';
import 'responsive_scaffold.dart';
import 'assignments/math_assignments_screen.dart';
import 'assignments/russian_language_screen.dart';
import 'assignments/world_around_screen.dart';
import 'assignments/logic_screen.dart';

class GradeSchoolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: 'Начальная школа',
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _SubjectCard(
            icon: Icons.calculate,
            title: 'Математика',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MathAssignmentsScreen()),
              );
            },
          ),
          _SubjectCard(
            icon: Icons.book,
            title: 'Русский язык',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RussianLanguageScreen()),
              );
            },
          ),
          _SubjectCard(
            icon: Icons.nature,
            title: 'Окружающий мир',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WorldAroundScreen()),
              );
            },
          ),
          _SubjectCard(
            icon: Icons.psychology,
            title: 'Логика',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LogicScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SubjectCard({
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