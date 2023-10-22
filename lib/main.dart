import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldisrough/classmodel/sharedprefsingleton.dart';
import 'SetupPage.dart';
import 'classmodel/gameprogress.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsSingleton.init();
  runApp(const MyApp());
}

class GameSettings {
  static final GameSettings _instance = GameSettings.internal();

  GameSettings.internal();

  factory GameSettings() {
    return _instance;
  }

  int? totalRound;
  int? difficulty = 0;
  int playedRound = 0;
  String? player1Name = "";
  String? player2Name = "";
  List<GameProgress> listOfScore = [];

  saveIntoPref() async {
    SharedPrefKey(SharedPrefsSingleton.instance)
        .saveDataIntoPref(player1Name!, player2Name!, totalRound!, difficulty!);
  }

  getWinner() {
    int player1Score = 0;
    int player2Score = 0;


    for (var item in listOfScore) {
      if (item.player1correct == true && item.player2correct == false) {
        player1Score++;
      } else if (item.player1correct == false && item.player2correct == true) {
        player2Score++;
      }
    }

    if (player1Score > player2Score) {
      return player1Name;
    }
    if (player2Score > player1Score) {
      return player2Name;
    }
    return "Draw";
  }

  String getDifficulty() {
    switch (difficulty) {
      case 0:
        return "Easy";
      case 1:
        return "Normal";
      case 2:
        return "Hard";
      default:
        return "Undefined";
    }
  }

  getDataFromPref() async {
    final preference = SharedPrefKey(SharedPrefsSingleton.instance);
    player1Name = preference.getPlayer1Name();
    player2Name = preference.getPlayer2Name();
    totalRound = preference.getTotalRound();
    difficulty = preference.getDifficulty();
  }

  clearGameRound() {
    playedRound = 0;
    listOfScore.clear();
  }
}

class SharedPrefKey {
  SharedPreferences prefs;
  final player1Key = "player1";
  final player2Key = "player2";
  final roundKey = "round";
  final difficultKey = "difficulty";


  SharedPrefKey(this.prefs);

  getPlayer1Name() {
    return prefs.getString(player1Key);
  }

  getPlayer2Name() {
    return prefs.getString(player2Key);
  }

  getTotalRound() {
    return prefs.getInt(roundKey);
  }

  getDifficulty() {
    return prefs.getInt(difficultKey);
  }

  saveDataIntoPref(String player1Name,String player2Name, int totalRound, int difficulty) async {
    await prefs.setString(player1Key, player1Name);
    await prefs.setString(player2Key, player2Name);
    await prefs.setInt(roundKey, totalRound);
    await prefs.setInt(difficultKey, difficulty);
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mati Murup The Game',
      initialRoute: '/',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SetupPage(),
    );
  }
}