import 'package:flutter/material.dart';
import 'package:worldisrough/library/gamesettings.dart';
import 'package:worldisrough/pages/gameplay/gameplay.dart';

class GameResult extends StatelessWidget {
  final GameSettings gameSettings = GameSettings();

  GameResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Game Result"),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "${gameSettings.getWinner()} Winner !!!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Game Statistics",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${gameSettings.player1Name} Vs ${gameSettings
                              .player2Name}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ListView(
                              children: [
                                for (var item in gameSettings.listOfScore)
                                  Card(
                                    child: SizedBox(
                                      height: 64,
                                      child: Row(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text("Round"),
                                                  Text(
                                                    item.round.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              item.finalResult,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: FilledButton(
                        onPressed: () {
                          gameSettings.resetGameRound();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => const GamePlay()));
                        },
                        child: Text(
                          "Play Again",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors
                                .amber)),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Setup Menu",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
