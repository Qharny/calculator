import 'package:calculator/constant/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        backgroundColor: colorGray,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              DrawerHeader(
                  child: Image.asset(
                'assets/calculator.png',
              )),
              const Text(
                'Calculator',
                style: TextStyle(color: textColor),
              ),
              ListTile(
                leading: const Icon(
                  Icons.calculate_outlined,
                  color: textColor,
                ),
                title: const Text(
                  'Standard',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.science_outlined,
                  color: textColor,
                ),
                title: const Text(
                  'Scientific',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.code,
                  color: textColor,
                ),
                title: const Text(
                  'Programmer',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.date_range,
                  color: textColor,
                ),
                title: const Text(
                  'Date Calculator',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {},
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Convetor',
                style: TextStyle(color: textColor),
              )
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Hello, World!',
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
