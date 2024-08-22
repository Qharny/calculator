import 'package:calculator/constant/colors.dart';
import 'package:calculator/screen/calcs/standard.dart';
import 'package:calculator/widget/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variable to keep current selected item
  int currentSelected = 0;

  void onItemTapped(int index) {
    setState(() {
      currentSelected = index;
    });
    Navigator.pop(context);
  }

  Widget _getBody() {
    switch (currentSelected) {
      case 0:
        return const Center(
          child: StandardCalc(),
        );
      case 1:
        return const Center(
          child: Text(
            'Scientific',
            style: TextStyle(color: textColor),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            'Programmer',
            style: TextStyle(color: textColor),
          ),
        );
      default:
        return const Center(child: StandardCalc());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(color: textColor),
          ),
          backgroundColor: Colors.transparent,
        ),

        // Drawer seicton code
        drawer: const CustomDrawer(),
        body: _getBody());
  }
}
