import 'package:calculator/constant/colors.dart';
import 'package:calculator/screen/calcs/scientic.dart';
import 'package:calculator/screen/calcs/standard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context);
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return const Center(child: StandardCalc());
      case 1:
        return const Center(
          child: ScientificCalc(),
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: textColor),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          'Calculator',
          style: TextStyle(color: textColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        backgroundColor: bgColor,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const DrawerHeader(
              child: Center(
                child: Icon(Icons.calculate_outlined, color: textColor),
              ),
            ),
            const Text(
              'Calculator',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            _buildDrawerItem(Icons.calculate_outlined, 'Standard', 0),
            _buildDrawerItem(Icons.science_outlined, 'Scientific', 1),
            _buildDrawerItem(Icons.code, 'Programmer', 2),
            _buildDrawerItem(Icons.date_range, 'Date Calculator', 3),
            const Divider(color: textColor),
            const SizedBox(height: 10),
            const Text(
              'Converter',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            _buildDrawerItem(Icons.currency_bitcoin_outlined, 'Bitcoin', 4),
            _buildDrawerItem(Icons.currency_exchange_outlined, 'Currency', 5),
            _buildDrawerItem(Icons.thermostat, 'Temperature', 6),
            const Divider(color: textColor),
            _buildDrawerItem(Icons.settings, 'Settings', 7),
          ],
        ),
      ),
      body: _getBody(),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(title, style: const TextStyle(color: textColor)),
      onTap: () => _onItemTapped(index),
    );
  }
}
