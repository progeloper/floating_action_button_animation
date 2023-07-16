import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function() callback;
  const CircularButton(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.icon,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        onPressed: callback,
        icon: icon,
        enableFeedback: true,
      ),
    );
  }
}
