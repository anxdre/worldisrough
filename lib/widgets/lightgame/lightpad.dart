import 'package:flutter/material.dart';
import 'package:worldisrough/widgets/lightgame/lightcontroller.dart';

class LightPad extends StatefulWidget {
  final LightPadController controller;

  const LightPad(this.controller, {super.key});

  @override
  State<LightPad> createState() => _LightPadState();
}

class _LightPadState extends State<LightPad> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      color: widget.controller.backgroundColor,
      padding: const EdgeInsets.all(8),
    );
  }
}
