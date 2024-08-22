import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double _result = 0.0;
  double _firstNumber = 0.0;
  double _secondNumber = 0.0;
  String _operation = '';
  String _calculatorType = 'normal';
  ThemeData _theme = ThemeData.light();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _calculatorType = prefs.getString('calculatorType') ?? 'normal';
      final themeMode = prefs.getString('themeMode') ?? 'light';
      _theme = themeMode == 'light' ? ThemeData.light() : ThemeData.dark();
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('calculatorType', _calculatorType);
    await prefs.setString('themeMode', _theme == ThemeData.light() ? 'light' : 'dark');
  }

  void _handleNumberInput(String value) {
    setState(() {
      if (_operation.isEmpty) {
        _firstNumber = double.parse('$_firstNumber$value');
      } else {
        _secondNumber = double.parse('$_secondNumber$value');
      }
    });
  }

  void _handleOperationInput(String operation) {
    setState(() {
      _operation = operation;
    });
  }

  void _calculateResult() {
    setState(() {
      switch (_operation) {
        case '+':
          _result = _firstNumber + _secondNumber;
          break;
        case '-':
          _result = _firstNumber - _secondNumber;
          break;
        case '*':
          _result = _firstNumber * _secondNumber;
          break;
        case '/':
          _result = _firstNumber / _secondNumber;
          break;
        default:
          _result = 0.0;
      }
      _firstNumber = 0.0;
      _secondNumber = 0.0;
      _operation = '';
    });
  }

  void _toggleTheme() {
  setState(() {
    _theme = _theme == lightTheme ? darkTheme : lightTheme;
    _saveSettings();
  });
}

  void _switchCalculatorType(String type) {
    setState(() {
      _calculatorType = type;
      _saveSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: _theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
          actions: [
            IconButton(
              icon: Icon(_theme == ThemeData.light() ? Icons.dark_mode : Icons.light_mode),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Normal Calculator'),
                onTap: () => _switchCalculatorType('normal'),
              ),
              ListTile(
                title: const Text('Scientific Calculator'),
                onTap: () => _switchCalculatorType('scientific'),
              ),
              ListTile(
                title: const Text('Programmer Calculator'),
                onTap: () => _switchCalculatorType('programmer'),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_result',
                style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  for (int i = 0; i < 10; i++)
                    ElevatedButton(
                      onPressed: () => _handleNumberInput('$i'),
                      child: Text('$i', style: const TextStyle(fontSize: 24.0)),
                    ),
                  ElevatedButton(
                    onPressed: () => _handleOperationInput('+'),
                    child: const Text('+', style: TextStyle(fontSize: 24.0)),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleOperationInput('-'),
                    child: const Text('-', style: TextStyle(fontSize: 24.0)),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleOperationInput('*'),
                    child: const Text('*', style: TextStyle(fontSize: 24.0)),
                  ),
                  ElevatedButton(
                    onPressed: () => _handleOperationInput('/'),
                    child: const Text('/', style: TextStyle(fontSize: 24.0)),
                  ),
                  ElevatedButton(
                    onPressed: _calculateResult,
                    child: const Text('=', style: TextStyle(fontSize: 24.0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}