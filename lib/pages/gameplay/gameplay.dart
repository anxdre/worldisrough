import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:worldisrough/library/gamescore.dart';
import 'package:worldisrough/pages/roundresult/roundresult.dart';
import 'package:worldisrough/widgets/cpad/containerpad.dart';
import 'package:worldisrough/widgets/cpad/cpadcontroller.dart';

import '../../library/gamesettings.dart';

class GamePlay extends StatefulWidget {
  @override
  State<GamePlay> createState() => _GamePlayState();

  const GamePlay({super.key});
}

class _GamePlayState extends State<GamePlay> {
  final gameSettings = GameSettings();
  late GameScore gameScore;
  final List<CpadController> _listOfPadController = [];
  var playerTurn = 1;
  final listOfStep = [];
  final listOfUserStep = [];
  var padEnabled = false;
  var padMsgTitle = "Memorize the pattern";

  @override
  void initState() {
    gameSettings.playedRound++;
    gameScore = GameScore(gameSettings.playedRound,gameSettings.totalRound!);
    for (int i = 0; i < 9; i++) {
      _listOfPadController.add(CpadController(i));
    }
    generateStep();
    Future.delayed(Duration(milliseconds: 3000), () {
      playStep();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gameplay"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (playerTurn == 1)
              Text(
                "${gameSettings.player1Name} turn",
                style: TextStyle(fontSize: 16),
              )
            else
              Text("${gameSettings.player2Name} turn",
                  style: TextStyle(fontSize: 16)),
            Text(
              padMsgTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
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
                        splashColor: padEnabled
                            ? Colors.lightBlueAccent
                            : Colors.transparent,
                        onTap: () {
                          if (padEnabled) {
                            listOfUserStep.add(_listOfPadController[i].id);
                            if (listOfUserStep.length == listOfStep.length) {
                              validateStep();
                            }
                            if (gameScore.player1Answer != null &&
                                gameScore.player2Answer != null) {
                              validateWinner();
                            }
                          }
                        },
                        child: ContainerPad(_listOfPadController[i])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  playStep() async {
    setState(() {
      padEnabled = false;
      padMsgTitle = "Memorize the pattern";
    });
    for (var i = 0; i < listOfStep.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _listOfPadController[listOfStep[i]].changeColor(Colors.deepOrange);
        });
      });
      await Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _listOfPadController[listOfStep[i]].changeColor(Colors.grey);
        });
      });
    }
    setState(() {
      padEnabled = true;
      padMsgTitle = "Enter the pattern";
    });
  }

  generateStep() {
    listOfStep.clear();
    switch (gameSettings.difficulty) {
      case 0:
        {
          for (var i = 0; i < 5; i++) {
            listOfStep.add(Random(Random().nextInt(10000)).nextInt(8));
          }
          break;
        }
      case 1:
        {
          for (var i = 0; i < 8; i++) {
            listOfStep.add(Random(Random().nextInt(10000)).nextInt(8));
          }
          break;
        }
      case 2:
        {
          for (var i = 0; i < 12; i++) {
            listOfStep.add(Random(Random().nextInt(10000)).nextInt(8));
          }
          break;
        }
    }
  }

  validateStep() {
    print(listOfStep.toString());
    print(listOfUserStep.toString());
    if (const ListEquality().equals(listOfUserStep, listOfStep)) {
      writeScore(true);
      _showMyDialog("Pattern accepted", "You memorize the pattern correctly",
          "Next", () {
        Navigator.of(context).pop();
        changePlayer();
      });
    } else {
      writeScore(false);
      _showMyDialog("Pattern denied !",
          "You don't memorize the pattern correctly", "Next", () {
        Navigator.of(context).pop();
        changePlayer();
      });
    }
  }

  changePlayer() {
    listOfUserStep.clear();
    if (playerTurn == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RoundResult(result: gameScore)));
      return;
    }
    setState(() {
      playerTurn = 2;
    });
    showMessage("Change to player 2 : Playing pattern on 3 seconds...");
    Future.delayed(const Duration(milliseconds: 3000), () {
      playStep();
    });
  }

  showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  writeScore(bool status) {
    if (playerTurn == 1) {
      gameScore.player1Answer = status;
    } else {
      gameScore.player2Answer = status;
    }
  }

  Future<void> _showMyDialog(String? title, String? message,
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

  validateWinner() {
    if (gameScore.player1Answer! && gameScore.player2Answer! == false) {
      gameScore.finalResult = gameSettings.player1Name! + " Win";
      return;
    }

    if (gameScore.player1Answer! == false && gameScore.player2Answer!) {
      gameScore.finalResult = gameSettings.player2Name! + " Win";
      return;
    }
  }

  @override
  void dispose() {
    _listOfPadController.clear();
    super.dispose();
  }
}
