import 'package:calculator/constant/colors.dart';
import 'package:calculator/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ScientificCalc extends StatefulWidget {
  const ScientificCalc({super.key});

  @override
  State<ScientificCalc> createState() => _ScientificCalcState();
}

class _ScientificCalcState extends State<ScientificCalc>
    with SingleTickerProviderStateMixin {
  String _output = '';
  String _currentNumber = '';
  String _operation = '';
  double _num1 = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRadianMode = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleButtonPress(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'AC':
          _clearAll();
          break;
        case '+/-':
          _toggleSign();
          break;
        case '%':
          _calculatePercentage();
          break;
        case '=':
          _calculateResult();
          break;
        case '.':
          _addDecimalPoint();
          break;
        case 'sin':
        case 'cos':
        case 'tan':
        case 'log':
        case 'ln':
        case '√':
        case 'x²':
        case 'x³':
        case '10ˣ':
        case 'eˣ':
        case 'x!':
          _performUnaryOperation(buttonText);
          break;
        case 'π':
          _addPi();
          break;
        case 'e':
          _addE();
          break;
        case 'Rad':
        case 'Deg':
          _toggleAngleMode();
          break;
        default:
          if (['+', '-', 'x', '/', '^'].contains(buttonText)) {
            _setOperation(buttonText);
          } else {
            _addNumber(buttonText);
          }
      }
    });
  }

  void _clearAll() {
    _output = '';
    _currentNumber = '';
    _operation = '';
    _num1 = 0;
  }

  void _toggleSign() {
    if (_currentNumber.isNotEmpty) {
      if (_currentNumber.startsWith('-')) {
        _currentNumber = _currentNumber.substring(1);
      } else {
        _currentNumber = '-$_currentNumber';
      }
      _updateOutput();
    }
  }

  void _calculatePercentage() {
    if (_currentNumber.isNotEmpty) {
      double number = double.parse(_currentNumber);
      _currentNumber = (number / 100).toString();
      _updateOutput();
    }
  }

  void _setOperation(String op) {
    if (_currentNumber.isNotEmpty) {
      _num1 = double.parse(_currentNumber);
      _operation = op;
      _currentNumber = '';
      _updateOutput();
    }
  }

  void _calculateResult() {
    if (_currentNumber.isNotEmpty && _operation.isNotEmpty) {
      double num2 = double.parse(_currentNumber);
      double result;
      switch (_operation) {
        case '+':
          result = _num1 + num2;
          break;
        case '-':
          result = _num1 - num2;
          break;
        case 'x':
          result = _num1 * num2;
          break;
        case '/':
          result = _num1 / num2;
          break;
        case '^':
          result = pow(_num1, num2).toDouble();
          break;
        default:
          return;
      }
      _controller.forward(from: 0.0).then((_) {
        setState(() {
          _output = result.toString();
          _currentNumber = result.toString();
          _operation = '';
          _num1 = result;
        });
      });
    }
  }

  void _addDecimalPoint() {
    if (!_currentNumber.contains('.')) {
      _currentNumber += '.';
      _updateOutput();
    }
  }

  void _addNumber(String number) {
    _currentNumber += number;
    _updateOutput();
  }

  void _updateOutput() {
    _output = '$_num1 $_operation $_currentNumber'.trim();
  }

  void _performUnaryOperation(String operation) {
    if (_currentNumber.isNotEmpty) {
      double number = double.parse(_currentNumber);
      double result;
      switch (operation) {
        case 'sin':
          result = _isRadianMode ? sin(number) : sin(number * pi / 180);
          break;
        case 'cos':
          result = _isRadianMode ? cos(number) : cos(number * pi / 180);
          break;
        case 'tan':
          result = _isRadianMode ? tan(number) : tan(number * pi / 180);
          break;
        case 'log':
          result = log(number) / ln10;
          break;
        case 'ln':
          result = log(number);
          break;
        case '√':
          result = sqrt(number);
          break;
        case 'x²':
          result = number * number;
          break;
        case 'x³':
          result = number * number * number;
          break;
        case '10ˣ':
          result = pow(10, number).toDouble();
          break;
        case 'eˣ':
          result = exp(number);
          break;
        case 'x!':
          result = _factorial(number);
          break;
        default:
          return;
      }
      _currentNumber = result.toString();
      _updateOutput();
    }
  }

  double _factorial(double n) {
    if (n <= 1) return 1;
    return n * _factorial(n - 1);
  }

  void _addPi() {
    _currentNumber = pi.toString();
    _updateOutput();
  }

  void _addE() {
    _currentNumber = e.toString();
    _updateOutput();
  }

  void _toggleAngleMode() {
    _isRadianMode = !_isRadianMode;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex:
                  2, // Increase this value to give more space to the output display
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_animation.value * 0.1),
                      child: Opacity(
                        opacity: 1.0 - _animation.value * 0.5,
                        child: Text(
                          _output,
                          style:
                              const TextStyle(fontSize: 50, color: textColor),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex:
                  5, // Adjust this value to change the space allocated for buttons
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildButtonRows(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildButtonRows() {
    final buttons = [
      ['sin', 'cos', 'tan', 'AC', '+/-', '%', '/'],
      ['log', 'ln', '√', '7', '8', '9', 'x'],
      ['x²', 'x³', '^', '4', '5', '6', '-'],
      ['10ˣ', 'eˣ', 'x!', '1', '2', '3', '+'],
      ['π', 'e', _isRadianMode ? 'Rad' : 'Deg', '0', '.', '='],
    ];

    return buttons.map((row) {
      return Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 4), // Adjust vertical spacing
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Evenly space buttons
          children: row.map((button) {
            return _buildButton(
              button,
              _getButtonTextColor(button),
              _getButtonColor(button),
              flex: button == '0' ? 2 : 1,
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  Color _getButtonTextColor(String button) {
    if (['AC', '+/-', '%'].contains(button)) return bgColor;
    return textColor;
  }

  Color _getButtonColor(String button) {
    if (['AC', '+/-', '%'].contains(button)) return faintColor;
    if (['+', '-', 'x', '/', '=', '^'].contains(button)) return operatorColor;
    return buttonColor;
  }

  Widget _buildButton(String text, Color textColor, Color bgColor,
      {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: CalculatorButton(
        text: text,
        textColor: textColor,
        bgColor: bgColor,
        textSize: 18, // Adjust this value to change text size
        callback: _handleButtonPress,
        width: 90, // Adjust this value to change button width
        height: 70, // Adjust this value to change button height
      ),
    );
  }
}
