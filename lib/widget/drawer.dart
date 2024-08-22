import 'package:calculator/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            const Stack(
              children: [
                Divider(),
                Positioned(
                  top: 50,
                    bottom: 0,
                    child: SizedBox(
                      height: 40,
                      child: ListTile(
                        leading: Icon(Icons.settings, color: textColor),
                        title: Text(
                          'Settings',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
