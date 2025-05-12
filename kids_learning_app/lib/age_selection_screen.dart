import 'package:flutter/material.dart';

class AgeSelectionScreen extends StatefulWidget {
  final void Function(String group) onContinue;

  const AgeSelectionScreen({required this.onContinue, super.key});

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  double _selectedAge = 4;

  String get ageGroup {
    if (_selectedAge <= 6) return 'Дошкольный';
    return 'Начальная школа';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Выбор возраста')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Выберите возраст ребёнка:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            Slider(
              value: _selectedAge,
              min: 3,
              max: 11,
              divisions: 8,
              label: _selectedAge.round().toString(),
              onChanged: (value) {
                setState(() {
                  _selectedAge = value;
                });
              },
            ),
            SizedBox(height: 8),
            Text(
              'Возраст: ${_selectedAge.round()} лет\nГруппа: $ageGroup',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                widget.onContinue(_selectedAge <= 6 ? 'preschool' : 'school');
              },
              child: Text('Продолжить'),
            ),
          ],
        ),
      ),
    );
  }
}
