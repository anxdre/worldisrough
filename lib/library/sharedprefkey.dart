import 'package:shared_preferences/shared_preferences.dart';

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
