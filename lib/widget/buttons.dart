import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double textSize;
  final Function(String) callback;
  final double width;
  final double height;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.textSize,
    required this.callback,
    this.width = 60, // Default width
    this.height = 60, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: () => callback(text),
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}