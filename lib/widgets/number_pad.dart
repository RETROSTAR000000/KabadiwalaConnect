import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(String) onNumberEntered;
  final VoidCallback onDelete;
  final VoidCallback onDone;
  final String currentValue;

  const NumberPad({
    Key? key,
    required this.onNumberEntered,
    required this.onDelete,
    required this.onDone,
    required this.currentValue,
  }) : super(key: key);

  Widget _buildButton(String label, {VoidCallback? onTap, IconData? icon}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, size: 32)
            : Text(label, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          currentValue.isEmpty ? '0 kg' : '$currentValue kg',
          style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['1', '2', '3'].map((n) => _buildButton(n, onTap: () => onNumberEntered(n))).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['4', '5', '6'].map((n) => _buildButton(n, onTap: () => onNumberEntered(n))).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['7', '8', '9'].map((n) => _buildButton(n, onTap: () => onNumberEntered(n))).toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButton('.', onTap: () => onNumberEntered('.')),
            _buildButton('0', onTap: () => onNumberEntered('0')),
            _buildButton('', icon: Icons.backspace, onTap: onDelete),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 250,
          height: 64,
          child: ElevatedButton(
            onPressed: onDone,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            ),
            child: const Text('DONE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
