import 'package:flutter/material.dart';

class SafetyCard extends StatelessWidget {
  final bool isDangerous;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onListenTap;

  const SafetyCard({
    Key? key,
    required this.isDangerous,
    required this.icon,
    required this.title,
    required this.description,
    this.onListenTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isDangerous ? Colors.red : Colors.green;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(color: color, width: 4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              if (onListenTap != null)
                IconButton(
                  icon: const Icon(Icons.volume_up, size: 32),
                  onPressed: onListenTap,
                  color: Colors.blueGrey,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
