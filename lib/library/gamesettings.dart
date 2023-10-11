import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldisrough/library/sharedprefkey.dart';
import 'package:worldisrough/library/gamescore.dart';
import 'package:worldisrough/library/sharedprefhelper.dart';

class GameSettings {
  static final GameSettings _instance = GameSettings.internal();

  GameSettings.internal();

  factory GameSettings() {
    return _instance;
  }

  String? player1Name = "";
  String? player2Name = "";
  int? totalRound;
  int? difficulty = 0;
  int playedRound = 0;
  List<GameScore> listOfScore = [];

  saveIntoPref() async {
    SharedPrefKey(SharedPrefsHelper.instance)
        .saveDataIntoPref(player1Name!, player2Name!, totalRound!, difficulty!);
  }

  String getDifficulty() {
    switch (difficulty) {
      case 0:
        return "Easy";
      case 1:
        return "Normal";
      case 2:
        return "Master";
      default:
        return "Undefined";
    }
  }

  getDataFromPref() async {
    final preference = SharedPrefKey(SharedPrefsHelper.instance);
    player1Name = preference.getPlayer1Name();
    player2Name = preference.getPlayer2Name();
    totalRound = preference.getTotalRound();
    difficulty = preference.getDifficulty();
  }

  resetGameRound() {
    playedRound = 0;
    listOfScore.clear();
  }

  getWinner() {
    int player1Score = 0;
    int player2Score = 0;
    for (var item in listOfScore) {
      if (item.player1Answer == true && item.player2Answer == false) {
        player1Score++;
      } else if (item.player1Answer == false && item.player2Answer == true) {
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
}
