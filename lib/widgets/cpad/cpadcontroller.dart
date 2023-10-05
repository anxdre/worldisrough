import 'package:flutter/material.dart';

class CpadController extends ChangeNotifier{
  int id;
  Color backgroundColor = Colors.grey;

  CpadController(this.id);

  changeColor(Color color) {
      backgroundColor = color;
      notifyListeners();
  }

  int getId(){
    return id;
  }

}