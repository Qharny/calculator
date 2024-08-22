import 'package:calculator/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCalculator extends StatefulWidget {
  const DateCalculator({super.key});

  @override
  State<DateCalculator> createState() => _DateCalculatorState();
}

class _DateCalculatorState extends State<DateCalculator> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String _result = '';

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          _startDateController.text =
              DateFormat('yyyy-MM-dd').format(_startDate!);
        } else {
          _endDate = picked;
          _endDateController.text = DateFormat('yyyy-MM-dd').format(_endDate!);
        }
      });
    }
  }

  void _calculateDateDifference() {
    if (_startDate != null && _endDate != null) {
      final difference = _endDate!.difference(_startDate!);
      setState(() {
        _result = 'Difference: ${difference.inDays} days';
      });
    } else {
      setState(() {
        _result = 'Please select both dates';
      });
    }
  }

  void _addDays() {
    if (_startDate != null && _daysController.text.isNotEmpty) {
      final days = int.tryParse(_daysController.text);
      if (days != null) {
        final newDate = _startDate!.add(Duration(days: days));
        setState(() {
          _result = 'Result: ${DateFormat('yyyy-MM-dd').format(newDate)}';
        });
      } else {
        setState(() {
          _result = 'Please enter a valid number of days';
        });
      }
    } else {
      setState(() {
        _result = 'Please select a start date and enter number of days';
      });
    }
  }

  void _subtractDays() {
    if (_startDate != null && _daysController.text.isNotEmpty) {
      final days = int.tryParse(_daysController.text);
      if (days != null) {
        final newDate = _startDate!.subtract(Duration(days: days));
        setState(() {
          _result = 'Result: ${DateFormat('yyyy-MM-dd').format(newDate)}';
        });
      } else {
        setState(() {
          _result = 'Please enter a valid number of days';
        });
      }
    } else {
      setState(() {
        _result = 'Please select a start date and enter number of days';
      });
    }
  }

  void _getDayOfWeek() {
    if (_startDate != null) {
      final dayOfWeek = DateFormat('EEEE').format(_startDate!);
      setState(() {
        _result = 'Day of the week: $dayOfWeek';
      });
    } else {
      setState(() {
        _result = 'Please select a date';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: faintColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
              readOnly: true,
              onTap: () => _selectDate(context, true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _endDateController,
              decoration: const InputDecoration(labelText: 'End Date'),
              readOnly: true,
              onTap: () => _selectDate(context, false),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateDateDifference,
              child: const Text('Calculate Difference'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _daysController,
              decoration: const InputDecoration(labelText: 'Number of Days'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addDays,
                  child: const Text('Add Days'),
                ),
                ElevatedButton(
                  onPressed: _subtractDays,
                  child: const Text('Subtract Days'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getDayOfWeek,
              child: const Text('Get Day of Week'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
