import 'package:flutter/material.dart';
import 'package:worldisrough/library/gamesettings.dart';
import 'package:worldisrough/pages/gameplay/gameplay.dart';
import 'package:worldisrough/pages/gameresult/gameresult.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final _formKey = GlobalKey<FormState>();
  int? selectedDifficulty;

  //game settings singletone
  final gameSettings = GameSettings();

  //controller
  final name1Controller = TextEditingController();
  final name2Controller = TextEditingController();
  final roundController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setup Gameplay"),
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
                  controller: name1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add player 1 name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Player name #1",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add player 2 name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Player name #2",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: roundController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required total round';
                    }
                    if(int.parse(value) > 10 || int.parse(value) < 1){
                      return 'Total round must greater than 0 with maximum 10 round';
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
                    width: MediaQuery.of(context).size.width,
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
                                  "Master",
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
                            content: Text('Please fill required data')),
                      );
                      return;
                    } else if (selectedDifficulty == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Select difficulty first')),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Validation OK : Playing pattern on 3 seconds...')),
                    );

                    gameSettings.player1Name = name1Controller.text;
                    gameSettings.player2Name = name2Controller.text;
                    gameSettings.totalRound = int.parse(roundController.text);
                    gameSettings.difficulty = selectedDifficulty;
                    gameSettings.playedRound = 0;

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GamePlay()));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 16),
                      minimumSize: Size(MediaQuery.of(context).size.width, 56)),
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
