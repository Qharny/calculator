import 'package:calculator/constant/colors.dart';
import 'package:calculator/widget/buttons.dart';
import 'package:flutter/material.dart';

class StandardCalc extends StatefulWidget {
  const StandardCalc({super.key});

  @override
  State<StandardCalc> createState() => _StandardCalcState();
}

class _StandardCalcState extends State<StandardCalc>
    with SingleTickerProviderStateMixin {
  String _output = '';
  String _currentNumber = '';
  String _operation = '';
  double _num1 = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

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
      if (buttonText == 'AC') {
        _clearAll();
      } else if (buttonText == '+/-') {
        _toggleSign();
      } else if (buttonText == '%') {
        _calculatePercentage();
      } else if (['+', '-', 'x', '/'].contains(buttonText)) {
        _setOperation(buttonText);
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == '.') {
        _addDecimalPoint();
      } else {
        _addNumber(buttonText);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
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
            Row(
              children: [
                _buildButton('AC', bgColor, faintColor),
                _buildButton('+/-', bgColor, faintColor),
                _buildButton('%', bgColor, faintColor),
                _buildButton('/', textColor, operatorColor),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildButton('7', textColor, buttonColor),
                _buildButton('8', textColor, buttonColor),
                _buildButton('9', textColor, buttonColor),
                _buildButton('x', textColor, operatorColor),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildButton('4', textColor, buttonColor),
                _buildButton('5', textColor, buttonColor),
                _buildButton('6', textColor, buttonColor),
                _buildButton('-', textColor, operatorColor),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildButton('1', textColor, buttonColor),
                _buildButton('2', textColor, buttonColor),
                _buildButton('3', textColor, buttonColor),
                _buildButton('+', textColor, operatorColor),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildButton('0', textColor, buttonColor, flex: 2),
                _buildButton('.', textColor, buttonColor),
                _buildButton('=', textColor, operatorColor),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color textColor, Color bgColor,
      {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: CalculatorButton(
        text: text,
        textColor: textColor,
        bgColor: bgColor,
        textSize: 24,
        callback: _handleButtonPress,
      ),
    );
  }
}
