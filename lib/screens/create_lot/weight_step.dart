import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/widgets/number_pad.dart';

class WeightStep extends StatefulWidget {
  final Function(double) onWeightEntered;

  const WeightStep({super.key, required this.onWeightEntered});

  @override
  State<WeightStep> createState() => _WeightStepState();
}

class _WeightStepState extends State<WeightStep> {
  String _currentValue = '';

  void _handleNumber(String num) {
    setState(() {
      if (_currentValue == '0' && num != '.') {
        _currentValue = num;
      } else {
        _currentValue += num;
      }
    });
  }

  void _handleDelete() {
    setState(() {
      if (_currentValue.isNotEmpty) {
        _currentValue = _currentValue.substring(0, _currentValue.length - 1);
      }
    });
  }

  void _handleDone() {
    final val = double.tryParse(_currentValue);
    if (val != null && val > 0) {
      widget.onWeightEntered(val);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.weightRequired)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.enterWeight ?? 'Enter Weight', style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 10),
        NumberPad(
          currentValue: _currentValue,
          onNumberEntered: _handleNumber,
          onDelete: _handleDelete,
          onDone: _handleDone,
        ),
      ],
    );
  }
}
