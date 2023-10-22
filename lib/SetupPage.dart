import 'package:flutter/material.dart';
import 'package:worldisrough/gamepage.dart';

import 'main.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final _formKey = GlobalKey<FormState>();
  int? selectedDifficulty = 0;

  //game settings singletone
  final gameSettings = GameSettings();

  //controller
  final player1NameController = TextEditingController();
  final player2NameController = TextEditingController();
  final textRoundController = TextEditingController();


  @override
  void initState() {
    super.initState();
    gameSettings.getDataFromPref();
    player1NameController.text = gameSettings.player1Name!;
    player2NameController.text = gameSettings.player2Name!;
    selectedDifficulty = gameSettings.difficulty;


    if (gameSettings.totalRound != null) {
      textRoundController.text = gameSettings.totalRound.toString();
    } else {
      textRoundController.text = "";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mati Murup The Game"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: player1NameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill player 1 name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Player 1 name",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: player2NameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill player 2 name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Player 2 name",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: textRoundController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required total round';
                    }
                    if (int.parse(value) > 10 || int.parse(value) < 1) {
                      return 'Total minimum are 1 and maximum 10';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Total round",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(16))),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            key: const Key("drop"),
                            isExpanded: true,
                            hint: const Text(
                              "Choose difficulty",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                            value: selectedDifficulty,
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text(
                                  "Easy",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text(
                                  "Normal",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text(
                                  "Hard",
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedDifficulty = value!;
                              });
                            }),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill blank data')),
                      );
                      return;
                    } else if (selectedDifficulty == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please Select difficulty')),
                      );
                      return;
                    }

                    gameSettings.player1Name = player1NameController.text;
                    gameSettings.player2Name = player2NameController.text;
                    gameSettings.totalRound = int.parse(textRoundController.text);
                    gameSettings.difficulty = selectedDifficulty;
                    gameSettings.playedRound = 0;
                    gameSettings.listOfScore = [];
                    gameSettings.saveIntoPref();

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const GamePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 16),
                      minimumSize: Size(MediaQuery
                          .of(context)
                          .size
                          .width, 56)),
                  child: const Text(
                    'Start Playing',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
