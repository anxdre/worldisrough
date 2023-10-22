import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:worldisrough/classmodel/gameprogress.dart';
import 'package:worldisrough/roundresult.dart';
import 'package:worldisrough/widgets/lightgame/lightpad.dart';
import 'package:worldisrough/widgets/lightgame/lightcontroller.dart';

import 'main.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
  const GamePage({super.key});
}

class _GamePageState extends State<GamePage> {
  var isLightEnabled = false;
  var msgTitle = "Memorize the pattern";
  var playerPlay = 1;

  late GameProgress gameScore;
  final gameSettings = GameSettings();

  final List<LightPadController> _listOfPadController = [];
  final listOfStep = [];
  final listOfUserStep = [];


  @override
  void initState() {
    gameSettings.playedRound++;
    gameScore =
        GameProgress(gameSettings.playedRound, gameSettings.totalRound!);
    for (int i = 0; i < 9; i++) {
      _listOfPadController.add(LightPadController(i));
    }
    createQuestion();
    Future.delayed(Duration(milliseconds: 3000), () {
      playQuestion();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(msgTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (playerPlay == 1)
              Text(
                "${gameSettings.player1Name} turn",
                style: TextStyle(fontSize: 16),
              )
            else
              Text("${gameSettings.player2Name} turn",
                  style: TextStyle(fontSize: 16)),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: <Widget>[
                  for (var i = 0; i < 9; i++)
                    InkWell(
                        splashColor: isLightEnabled
                            ? Colors.lightBlueAccent
                            : Colors.transparent,
                        onTap: () {
                          if (isLightEnabled) {
                            listOfUserStep.add(_listOfPadController[i].id);
                            if (listOfUserStep.length == listOfStep.length) {
                              checkAnswer();
                            }
                            if (gameScore.player1correct != null &&
                                gameScore.player2correct != null) {
                              checkWinner();
                            }
                          }
                        },
                        child: LightPad(_listOfPadController[i])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  checkWinner() {
    if (gameScore.player1correct! && gameScore.player2correct! == false) {
      gameScore.finalResult = gameSettings.player1Name! + " Win";
      return;
    }

    if (gameScore.player1correct! == false && gameScore.player2correct!) {
      gameScore.finalResult = gameSettings.player2Name! + " Win";
      return;
    }
  }

  playQuestion() async {
    setState(() {
      isLightEnabled = false;
      msgTitle = "Memorize the pattern";
    });
    for (var i = 0; i < listOfStep.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _listOfPadController[listOfStep[i]].updateColor(Colors.purpleAccent);
        });
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _listOfPadController[listOfStep[i]].updateColor(Colors.grey);
        });
      });
    }
    setState(() {
      isLightEnabled = true;
      msgTitle = "Enter the pattern";
    });
  }

  createQuestion() {
    listOfStep.clear();
    switch (gameSettings.difficulty) {
      case 0:
        {
          for (var i = 0; i < 5; i++) {
            listOfStep.add(Random(Random().nextInt(500)).nextInt(8));
          }
          break;
        }
      case 1:
        {
          for (var i = 0; i < 8; i++) {
            listOfStep.add(Random(Random().nextInt(6100)).nextInt(8));
          }
          break;
        }
      case 2:
        {
          for (var i = 0; i < 12; i++) {
            listOfStep.add(Random(Random().nextInt(190)).nextInt(8));
          }
          break;
        }
    }
  }

  checkAnswer() {
    if (const ListEquality().equals(listOfUserStep, listOfStep)) {
      saveScoreProgress(true);
      _showAlertMessageBuild(
          "Great", "Your pattern is correct", "Lanjut", () {
        Navigator.of(context).pop();
        ubahPemain();
      });
    } else {
      saveScoreProgress(false);
      _showAlertMessageBuild("Ooops !",
          "Your pattern is wrong", "Lanjut", () {
        Navigator.of(context).pop();
        ubahPemain();
      });
    }
  }

  ubahPemain() {
    listOfUserStep.clear();
    if (playerPlay == 2) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RoundResult(result: gameScore)));
      return;
    }
    setState(() {
      playerPlay = 2;
    });
    showAlertMessage("Player 2 turn : Playing pattern ...");
    Future.delayed(const Duration(milliseconds: 3000), () {
      playQuestion();
    });
  }

  showAlertMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  saveScoreProgress(bool status) {
    if (playerPlay == 1) {
      gameScore.player1correct = status;
    } else {
      gameScore.player2correct = status;
    }
  }



  Future<void> _showAlertMessageBuild(String? title, String? message,
      String? approveButton, Function invokeApprove) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message!),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(approveButton!),
              onPressed: () {
                invokeApprove();
              },
            ),
          ],
        );
      },
    );
  }
}
