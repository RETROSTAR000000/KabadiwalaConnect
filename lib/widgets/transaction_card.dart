import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class TransactionCard extends StatelessWidget {
  final MaterialCategory category;
  final double weight;
  final double? value;
  final String status;
  final DateTime date;
  final VoidCallback? onTap;

  const TransactionCard({
    Key? key,
    required this.category,
    required this.weight,
    this.value,
    required this.status,
    required this.date,
    this.onTap,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status) {
      case 'created': return Colors.blue;
      case 'quoted': return Colors.orange;
      case 'accepted': return Colors.green;
      case 'handed_over': return Colors.purple;
      case 'confirmed': return Colors.teal;
      case 'paid': return Colors.green.shade800;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(color: category.color, shape: BoxShape.circle),
                child: Icon(category.icon, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weight}kg ${category.displayName}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(color: _getStatusColor(), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (value != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '₹$value',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
