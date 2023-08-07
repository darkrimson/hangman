import 'package:flutter/material.dart';
import 'package:hangman/game_screen_provider.dart';
import 'package:provider/provider.dart';

import 'game_screen.dart';

void main() {
  runApp(const HangmanApp());
}

class HangmanApp extends StatelessWidget {
  const HangmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GameMethods(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const GameScreen(),
      ),
    );
  }
}
