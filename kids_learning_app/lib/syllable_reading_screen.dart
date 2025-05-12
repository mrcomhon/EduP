import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SyllableReadingScreen extends StatefulWidget {
  @override
  _SyllableReadingScreenState createState() => _SyllableReadingScreenState();
}

class _SyllableReadingScreenState extends State<SyllableReadingScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;

  void nextQuestion() {
    setState(() {
      if (currentIndex < syllableWords.length - 1) {
        currentIndex++;
        playAudio();
      } else {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: Text('Молодец!'),
                content: Text('Ты прошёл все задания!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        currentIndex = 0;
                        playAudio();
                      });
                    },
                    child: Text('Пройти снова'),
                  ),
                ],
              ),
        );
      }
    });
  }

  void playAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(syllableWords[currentIndex].audioPath));
  }

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = syllableWords[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('🧩 Слоговое чтение')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Задание ${currentIndex + 1} из ${syllableWords.length}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: playAudio,
              icon: Icon(Icons.volume_up),
              label: Text('Слушать слово'),
            ),
            SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              children:
                  question.syllables
                      .map(
                        (syllable) => Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.teal.shade100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 20,
                            ),
                            child: Text(
                              syllable,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[900],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            SizedBox(height: 30),
            Text('Прочитай слово:', style: TextStyle(fontSize: 22)),
            SizedBox(height: 10),
            Text(
              question.fullWord,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: nextQuestion,
              child: Text('Следующее'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SyllableWord {
  final List<String> syllables;
  final String fullWord;
  final String audioPath;

  SyllableWord({
    required this.syllables,
    required this.fullWord,
    required this.audioPath,
  });
}

final List<SyllableWord> syllableWords = [
  SyllableWord(
    syllables: ['Ма', 'ма'],
    fullWord: 'Мама',
    audioPath: 'audio/syllables/mama.mp3',
  ),
  SyllableWord(
    syllables: ['Па', 'па'],
    fullWord: 'Папа',
    audioPath: 'audio/syllables/papa.mp3',
  ),
  SyllableWord(
    syllables: ['Со', 'ба', 'ка'],
    fullWord: 'Собака',
    audioPath: 'audio/syllables/sobaka.mp3',
  ),
  SyllableWord(
    syllables: ['Ма', 'ши', 'на'],
    fullWord: 'Машина',
    audioPath: 'audio/syllables/mashina.mp3',
  ),
  SyllableWord(
    syllables: ['Яб', 'ло', 'ко'],
    fullWord: 'Яблоко',
    audioPath: 'audio/syllables/yabloko.mp3',
  ),
];
