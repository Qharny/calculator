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
    this.width = 70,
    this.height = 50,
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
          padding: EdgeInsets.zero, // Remove default padding
        ),
        onPressed: () => callback(text),
        child: Center( // Center the text
          child: FittedBox( // Use FittedBox to scale text if needed
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
              ),
              textAlign: TextAlign.center, // Ensure text is centered
            ),
          ),
        ),
      ),
    );
  }
}