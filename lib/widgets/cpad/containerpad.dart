import 'package:flutter/material.dart';
import 'package:worldisrough/widgets/cpad/cpadcontroller.dart';

class ContainerPad extends StatefulWidget {
  final CpadController controller;

  const ContainerPad(this.controller, {super.key});

  @override
  State<ContainerPad> createState() => _ContainerPadState();
}

class _ContainerPadState extends State<ContainerPad> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      color: widget.controller.backgroundColor,
      padding: const EdgeInsets.all(8),
    );
  }
}
