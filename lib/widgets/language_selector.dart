import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String currentLanguage; // 'en', 'hi', 'mr'
  final Function(String) onLanguageChanged;

  const LanguageSelector({
    Key? key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  Widget _buildLangButton(String code, String label) {
    final isSelected = currentLanguage == code;
    return Expanded(
      child: GestureDetector(
        onTap: () => onLanguageChanged(code),
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLangButton('en', 'English'),
        _buildLangButton('hi', 'हिंदी'),
        _buildLangButton('mr', 'मराठी'),
      ],
    );
  }
}
