import 'package:flutter/material.dart';
import 'package:hangman/game_screen_provider.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var alphabet = context.watch<GameMethods>().alphabet;
    var word = context.watch<GameMethods>().word;
    var hangState = context.watch<GameMethods>().hangState;
    var isLetterGuessed = context.read<GameMethods>().isLetterGuessed;
    var checkLetter = context.read<GameMethods>();
    var lives = context.watch<GameMethods>().lives;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Hangman Game',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Image.asset(
                          'images/$hangState.png',
                          height: 500,
                          width: 400,
                          gaplessPlayback: true,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: word.split('').map((letter) {
                          return Text(
                            isLetterGuessed(letter) ? letter : '_',
                            style: const TextStyle(fontSize: 24),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: alphabet
                        .map(
                          (char) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bgColor,
                              disabledBackgroundColor: Colors.grey,
                              disabledForegroundColor: Colors.grey,
                            ),
                            onPressed: !isLetterGuessed(char)
                                ? () => checkLetter.checkLetter(char, context)
                                : null,
                            child: Text(char),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            Text('Lives: $lives'),
          ],
        ),
      ),
    );
  }
}
