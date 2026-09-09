import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class PriceChip extends StatelessWidget {
  final MaterialCategory category;
  final double price;
  final String trend; // 'up', 'down', 'stable'
  final VoidCallback? onTap;

  const PriceChip({
    Key? key,
    required this.category,
    required this.price,
    required this.trend,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData trendIcon;
    Color trendColor;
    
    switch (trend) {
      case 'up':
        trendIcon = Icons.arrow_upward;
        trendColor = Colors.green;
        break;
      case 'down':
        trendIcon = Icons.arrow_downward;
        trendColor = Colors.red;
        break;
      default:
        trendIcon = Icons.horizontal_rule;
        trendColor = Colors.grey;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: category.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(category.icon, size: 24, color: category.color),
            const SizedBox(width: 8),
            Text(
              '₹$price',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Icon(trendIcon, size: 16, color: trendColor),
          ],
        ),
      ),
    );
  }
}
