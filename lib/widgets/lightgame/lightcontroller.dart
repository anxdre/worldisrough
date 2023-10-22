import 'package:flutter/material.dart';

class LightPadController extends ChangeNotifier{
  int id;
  Color backgroundColor = Colors.grey;

  LightPadController(this.id);

  int getId(){
    return id;
  }

  updateColor(Color color) {
    backgroundColor = color;

    notifyListeners();
  }

}