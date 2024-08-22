// rounded calculator button widget

import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget { 

  final String text;
  final Color textColor;
  final Color bgColor;
  // final Color borderColor;
  final double textSize;
  final Function callback;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    // required this.borderColor,
    required this.textSize,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            color: bgColor,
            child: InkWell(
              onTap: () => callback(text),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}