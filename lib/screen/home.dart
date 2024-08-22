import 'package:calculator/constant/colors.dart';
import 'package:calculator/screen/calcs/standard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    Navigator.pop(context);
  }

  Widget _getBody() {
    switch (currentIndex) {
      case 0:
        return const Center(child: StandardCalc());
      case 1:
        return const Center(
          child: Text('Scientific', style: TextStyle(color: textColor)),
        );
      case 2:
        return const Center(
          child: Text('Programmer', style: TextStyle(color: textColor)),
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
              ),
              ListTile(
                leading: const Icon(
                  Icons.currency_bitcoin_outlined,
                  color: textColor,
                ),
                title: const Text(
                  'Bitcoin',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.currency_exchange_outlined,
                  color: textColor,
                ),
                title: const Text(
                  'Currency',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.thermostat,
                  color: textColor,
                ),
                title: const Text(
                  'Temperature',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {},
              ),
              Stack(
                children: [
                  const Divider(),
                  Positioned(
                      child: ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: textColor,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {},
                  )),
                ],
              )
            ],
          ),
        ),
      ),
      body: _getBody(),
    );
  }
}
