class GameScore {
  int round;
  int totalRound;
  bool? player1Answer;
  bool? player2Answer;
  String finalResult = "draw";

  GameScore(this.round,this.totalRound);

  int getRound(){
    return round;
  }
}