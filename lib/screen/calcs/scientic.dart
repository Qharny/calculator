import 'package:calculator/constant/colors.dart';
import 'package:flutter/material.dart';

class ScientificCalc extends StatelessWidget {
  const ScientificCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('scientific calc', style: TextStyle(color: textColor),)
          ]
        ),
      ),
    );
  }
}