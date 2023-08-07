import 'dart:math';

import 'package:flutter/material.dart';

class GameMethods extends ChangeNotifier {
  int lives = 6;
  List<String> wordList = [
    'Apple',
    'Machine',
    'gym',
    'university',
    'programming',
    'example',
    'Rosul',
    'Adam'
  ];
  late var word = randomWordGenerate()
      .toUpperCase(); // Загаданное слово (можете изменить на другое слово)
  List<String> guessedLetters = [];
  final List<String> alphabet = List.generate(26,
      (index) => String.fromCharCode('A'.codeUnitAt(0) + index).toUpperCase());
  int hangState = 0;

  String randomWordGenerate() {
    int randomInt = Random().nextInt(wordList.length);
    return wordList[randomInt];
  }

  bool isLetterGuessed(String letter) {
    return guessedLetters.contains(letter);
  }

  void checkLetter(String letter, BuildContext context) {
    if (!guessedLetters.contains(letter)) {
      guessedLetters.add(letter);
      if (!word.contains(letter)) {
        lives--;
        hangState++;
      }
    }
    if (guessedLetters.toSet().containsAll(word.split(''))) {
      // Если все буквы из загаданного слова содержатся в guessedLetters,
      // то игра завершается, и пользователь побеждает.
      // Мы используем метод toSet() для преобразования списка в множество и
      // containsAll() для проверки, содержит ли множество все элементы из списка.
      // Таким образом, если множество guessedLetters содержит все буквы слова word,
      // то условие выполняется.
      isWin(context);
    }

    if (hangState > 5 || lives == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Поздравляем!'),
            content: const Text('Вы проиграли!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  finishGame();
                },
                child: const Text(
                  'Начать заново',
                ),
              ),
            ],
          );
        },
      );
    }
    notifyListeners();
  }

  void finishGame() {
    notifyListeners();
    lives = 6;
    hangState = 0;
    guessedLetters = [];
    word = randomWordGenerate().toUpperCase();
  }

  void isWin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Поздравляем!'),
          content: const Text('Вы угадали слово!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                finishGame();
              },
              child: const Text('Начать заново'),
            ),
          ],
        );
      },
    );
  }
}
