import 'package:calculator/constant/colors.dart';
import 'package:calculator/widget/buttons.dart';
import 'package:flutter/material.dart';

class ProgrammerCalc extends StatefulWidget {
  const ProgrammerCalc({super.key});

  @override
  State<ProgrammerCalc> createState() => _ProgrammerCalcState();
}

class _ProgrammerCalcState extends State<ProgrammerCalc> {
  String _output = '0';
  int _currentNumber = 0;
  String _operation = '';
  int _base = 10;
  List<String> _baseOutputs = List.filled(4, '0');

  void _handleButtonPress(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _clearAll();
          break;
        case '=':
          _calculateResult();
          break;
        case 'AND':
        case 'OR':
        case 'XOR':
        case 'NOT':
        case 'LSH':
        case 'RSH':
          _setOperation(buttonText);
          break;
        case 'HEX':
          _setBase(16);
          break;
        case 'DEC':
          _setBase(10);
          break;
        case 'OCT':
          _setBase(8);
          break;
        case 'BIN':
          _setBase(2);
          break;
        default:
          if (_base == 16 && 'ABCDEF'.contains(buttonText)) {
            _addHexNumber(buttonText);
          } else if (int.tryParse(buttonText) != null) {
            _addNumber(int.parse(buttonText));
          }
      }
    });
  }

  void _clearAll() {
    _output = '0';
    _currentNumber = 0;
    _operation = '';
    _updateBaseOutputs();
  }

  void _setOperation(String op) {
    _operation = op;
    if (op == 'NOT') {
      _calculateResult();
    }
  }

  void _calculateResult() {
    int result;
    switch (_operation) {
      case 'AND':
        result = _currentNumber & int.parse(_output);
        break;
      case 'OR':
        result = _currentNumber | int.parse(_output);
        break;
      case 'XOR':
        result = _currentNumber ^ int.parse(_output);
        break;
      case 'NOT':
        result = ~_currentNumber;
        break;
      case 'LSH':
        result = _currentNumber << int.parse(_output);
        break;
      case 'RSH':
        result = _currentNumber >> int.parse(_output);
        break;
      default:
        result = _currentNumber;
    }
    _currentNumber = result;
    _output = _formatNumber(result);
    _updateBaseOutputs();
    _operation = '';
  }

  void _addNumber(int number) {
    if (_operation.isNotEmpty) {
      _currentNumber = int.parse(_output);
      _output = number.toString();
    } else {
      _output = (_output == '0') ? number.toString() : _output + number.toString();
    }
    _updateBaseOutputs();
  }

  void _addHexNumber(String hexDigit) {
    if (_base == 16) {
      if (_operation.isNotEmpty) {
        _currentNumber = int.parse(_output, radix: 16);
        _output = hexDigit;
      } else {
        _output = (_output == '0') ? hexDigit : _output + hexDigit;
      }
      _updateBaseOutputs();
    }
  }

  void _setBase(int newBase) {
    _base = newBase;
    _output = _formatNumber(_currentNumber);
    _updateBaseOutputs();
  }

  String _formatNumber(int number) {
    switch (_base) {
      case 16:
        return number.toRadixString(16).toUpperCase();
      case 8:
        return number.toRadixString(8);
      case 2:
        return number.toRadixString(2);
      default:
        return number.toString();
    }
  }

  void _updateBaseOutputs() {
    int number = (_output == '0') ? 0 : int.parse(_output, radix: _base);
    _baseOutputs = [
      number.toRadixString(16).toUpperCase(),
      number.toString(),
      number.toRadixString(8),
      number.toRadixString(2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: _buildOutputDisplay(),
            ),
            Expanded(
              flex: 5,
              child: _buildKeypad(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('HEX: ${_baseOutputs[0]}', style: const TextStyle(color: textColor)),
                Text('DEC: ${_baseOutputs[1]}', style: const TextStyle(color: textColor)),
                Text('OCT: ${_baseOutputs[2]}', style: const TextStyle(color: textColor)),
                Text('BIN: ${_baseOutputs[3]}', style: const TextStyle(color: textColor)),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black87,
          child: Text(
            _output,
            style: const TextStyle(fontSize: 48, color: textColor),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildKeypad() {
    final buttons = [
      ['HEX', 'DEC', 'OCT', 'BIN', 'AND'],
      ['D', 'E', 'F', 'C', 'OR'],
      ['A', 'B', '7', '8', '9'],
      ['LSH', 'RSH', '4', '5', '6'],
      ['NOT', 'XOR', '1', '2', '3'],
      ['(', ')', '0', '='],
    ];

    return Column(
      children: buttons.map((row) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: row.map((button) {
              return Expanded(
                child: CalculatorButton(
                  text: button,
                  textColor: _getButtonTextColor(button),
                  bgColor: _getButtonColor(button),
                  textSize: 18,
                  callback: _handleButtonPress,
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Color _getButtonTextColor(String button) {
    if (['HEX', 'DEC', 'OCT', 'BIN'].contains(button)) return bgColor;
    return textColor;
  }

  Color _getButtonColor(String button) {
    if (['HEX', 'DEC', 'OCT', 'BIN'].contains(button)) return faintColor;
    if (['AND', 'OR', 'XOR', 'NOT', 'LSH', 'RSH', '='].contains(button)) return operatorColor;
    return buttonColor;
  }
}