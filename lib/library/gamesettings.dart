class GameSettings {
  static final GameSettings _instance = GameSettings.internal();

  GameSettings.internal();

  factory GameSettings() {
    return _instance;
  }

  String? player1Name = "";
  String? player2Name = "";
  int? totalRound = 0;
  int? difficulty = 0;
  int playedRound = 0;


}
