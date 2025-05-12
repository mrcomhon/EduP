import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class RepeatSoundScreen extends StatefulWidget {
  @override
  _RepeatSoundScreenState createState() => _RepeatSoundScreenState();
}

class _RepeatSoundScreenState extends State<RepeatSoundScreen> {
  final List<SpeechSound> sounds = [
    SpeechSound(
      letter: 'М',
      description: 'Замкни губы и произнеси “М-м-м”',
      videoPath: 'assets/videos/m.mp4',
      audioPath: 'audio/m.mp3',
    ),
    SpeechSound(
      letter: 'С',
      description: 'Улыбнись, приоткрой рот и произнеси “С-с-с”',
      videoPath: 'assets/videos/s.mp4',
      audioPath: 'audio/s.mp3',
    ),
    SpeechSound(
      letter: 'Р',
      description: 'Поставь язык за верхние зубы и произнеси “Р-р-р”',
      videoPath: 'assets/videos/r.mp4',
      audioPath: 'audio/r.mp3',
    ),
    SpeechSound(
      letter: 'Щ',
      description: 'Улыбнись, округли губы и скажи “Щ-щ-щ”',
      videoPath: 'assets/videos/shch.mp4',
      audioPath: 'audio/shch.mp3',
    ),
    SpeechSound(
      letter: 'З',
      description: 'Улыбнись, приоткрой рот и произнеси “З-з-з”',
      videoPath: 'assets/videos/z.mp4',
      audioPath: 'audio/z.mp3',
    ),
    SpeechSound(
      letter: 'Ч',
      description: 'Улыбнись, прижми язык и скажи “Ч-ч-ч”',
      videoPath: 'assets/videos/ch.mp4',
      audioPath: 'audio/ch.mp3',
    ),
    SpeechSound(
      letter: 'Л',
      description: 'Поставь язык за верхние зубы и произнеси “Л-л-л”',
      videoPath: 'assets/videos/l.mp4',
      audioPath: 'audio/l.mp3',
    ),
    SpeechSound(
      letter: 'Ш',
      description:
          'Улыбнись, приподними язык и произнеси “Ш-ш-ш” как при шипении',
      videoPath: 'assets/videos/sh.mp4',
      audioPath: 'audio/sh.mp3',
    ),

    SpeechSound(
      letter: 'Ж',
      description: 'Губы в улыбке, язык приподнят — скажи “Ж-ж-ж” как пчёлка',
      videoPath: 'assets/videos/zh.mp4',
      audioPath: 'audio/zh.mp3',
    ),
    
    SpeechSound(
      letter: 'Ц',
      description:
          'Произнеси “Тс-тс-тс” с прижатыми зубами, как звук при одёргивании',
      videoPath: 'assets/videos/ts.mp4',
      audioPath: 'audio/ts.mp3',
    ),
    // Добавь остальные звуки аналогично
  ];

  @override
  void dispose() {
    for (var sound in sounds) {
      sound.controller?.dispose();
    }
    super.dispose();
  }

  Future<void> _initializeVideo(SpeechSound sound) async {
    final controller = VideoPlayerController.asset(sound.videoPath);
    await controller.initialize();
    controller.setVolume(1.0);
    setState(() {
      sound.controller = controller;
      sound.isInitialized = true;
      controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🔊 Повтори звук')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: sounds.length,
        itemBuilder: (context, index) {
          final sound = sounds[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.purple.shade100,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Буква "${sound.letter}"',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  // Видео или кнопка "Загрузить"
                  sound.isInitialized && sound.controller!.value.isInitialized
                      ? AspectRatio(
                        aspectRatio: sound.controller!.value.aspectRatio,
                        child: VideoPlayer(sound.controller!),
                      )
                      : ElevatedButton.icon(
                        onPressed: () => _initializeVideo(sound),
                        icon: Icon(Icons.play_arrow),
                        label: Text('Загрузить и воспроизвести видео'),
                      ),

                  if (sound.isInitialized)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            final controller = sound.controller!;
                            controller.value.isPlaying
                                ? controller.pause()
                                : controller.play();
                          });
                        },
                        icon: Icon(
                          sound.controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        label: Text(
                          sound.controller!.value.isPlaying
                              ? 'Пауза'
                              : 'Проиграть видео',
                        ),
                      ),
                    ),

                  SizedBox(height: 12),
                  Text(
                    sound.description,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      final player = AudioPlayer();
                      player.setVolume(1.0);
                      player.play(AssetSource(sound.audioPath));
                    },
                    icon: Icon(Icons.volume_up),
                    label: Text('Проиграть звук'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SpeechSound {
  final String letter;
  final String description;
  final String videoPath;
  final String audioPath;
  VideoPlayerController? controller;
  bool isInitialized;

  SpeechSound({
    required this.letter,
    required this.description,
    required this.videoPath,
    required this.audioPath,
    this.controller,
    this.isInitialized = false,
  });
}
