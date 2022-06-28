import 'package:flutter/material.dart';
import 'package:musicplayer/src/model/audio_player.dart';
import 'package:musicplayer/src/pages/music_player_page.dart';
import 'package:musicplayer/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerModel()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Music Player',
          theme: miTema,
          home: Scaffold(
            body: MusicPlayerPage(),
          )),
    );
  }
}
