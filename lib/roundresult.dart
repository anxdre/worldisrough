import 'package:flutter/material.dart';
import 'package:worldisrough/classmodel/gameprogress.dart';
import 'package:worldisrough/gamepage.dart';
import 'package:worldisrough/gameresultpage.dart';

import 'main.dart';

class RoundResult extends StatefulWidget {
  final GameProgress result;

  const RoundResult({super.key, required this.result});

  @override
  State<RoundResult> createState() => _RoundResultState();
}

class _RoundResultState extends State<RoundResult> {
  final GameSettings gameSettings = GameSettings();

  @override
  void initState() {
    gameSettings.listOfScore.add(widget.result); // condition here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("build done");
      if (widget.result.round == widget.result.totalRound) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GameResultPage()));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil Ronde ${widget.result.round.toString()}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Round ${widget.result.round} Of ${widget.result.totalRound} (mode : ${gameSettings.getDifficulty()})",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Colors.black),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Center(
                              child: Text(
                                "${widget.result.finalResult}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "${gameSettings.player1Name} VS ${gameSettings.player2Name}",
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
                child: FilledButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => GamePage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Lanjut Ronde ${widget.result.getRound() + 1}",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
