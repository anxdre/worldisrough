class GameProgress {
  int round;
  int totalRound;

  String finalResult = "draw";

  bool? player1correct;
  bool? player2correct;

  GameProgress(this.round,this.totalRound);

  int getRound(){
    return round;
  }
}