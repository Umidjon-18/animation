import 'dart:io';
import 'dart:math';

import 'options.dart';


class WaitAndClear {
  Future clearFunction() async {
    await Future.delayed(Duration(milliseconds: 300));
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }

  Future clearFunctionEnd() async {
    await Future.delayed(Duration(milliseconds: 300));
  }

  Future clearGame() async {
    await Future.delayed(Duration(milliseconds: 1500));
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }

  Future wait() async {
    await Future.delayed(Duration(milliseconds: 700));
  }
}

// Instance of Waiting class
WaitAndClear waitAndClear = WaitAndClear();
// Mixing combinations
Options options = Options();
var combination = [
  options.birVaIkki, // 0
  options.ikkiVaUch, // 1
  options.birVaUch, // 2
  options.birVaIkkiTeskari, // 3
  options.ikkiVaUchTeskari, // 4
  options.birVaUchTeskari // 5
];
// Motor of game
Future game() async {
  print('''
Xazinani topish o'yini 💰💰💰

⭐️   ⭐️   ⭐️  
1    2    3

''');
  await waitAndClear.wait();
  int secret = Random.secure().nextInt(3) + 1;
  print("Xazinaning yashirilgan o'rni $secret 😉😉😉");
  await waitAndClear.clearGame();
  print("Aralashtirish sonini kiriting ");
  await waitAndClear.wait();
  int mixingNumber = int.parse(stdin.readLineSync()!);
  print("Aralashtirishni boshlaymiz ");
  await waitAndClear.clearGame();
  int newSecret = await mix(mixingNumber, secret);
  await waitAndClear.clearGame();
  print('''

⭐️   ⭐️   ⭐️  
1    2    3

''');
  print("Javobingizni kiriting");
  int check = int.parse(stdin.readLineSync()!);
  await waitAndClear.wait();
  if (check == newSecret) {
    print("Tabriklaymiz siz g'olib bo'ldingiz 🥳🥳🥳");
  } else {
    print("Afsus siz yutqazdingiz, xazina $newSecret-o'rinda edi 😥😥😥");
  }
}

//Random mixing function
Future<int> mix(int mixingNumber, int secret) async {
  for (var i = 0; i < mixingNumber; i++) {
    int randomCycle = Random.secure().nextInt(6);
    switch (secret) {
      case 1:
        await combination[randomCycle]();
        if (randomCycle == 0 || randomCycle == 3) secret = 2;
        if (randomCycle == 2 || randomCycle == 5) secret = 3;
        break;
      case 2:
        await combination[randomCycle]();
        if (randomCycle == 1 || randomCycle == 4) secret = 3;
        if (randomCycle == 0 || randomCycle == 3) secret = 1;
        break;
      case 3:
        await combination[randomCycle]();
        if (randomCycle == 1 || randomCycle == 4) secret = 2;
        if (randomCycle == 2 || randomCycle == 5) secret = 1;
        break;
    }
  }
  return secret;
}
