import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class MaterialCard extends StatelessWidget {
  final MaterialCategory category;
  final double? pricePerKg;
  final double? weight;
  final bool selected;
  final VoidCallback? onTap;

  const MaterialCard({
    Key? key,
    required this.category,
    this.pricePerKg,
    this.weight,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: selected ? const BorderSide(color: Colors.green, width: 3) : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: category.color,
                  shape: BoxShape.circle,
                ),
                child: Icon(category.icon, size: 40, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.displayName,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (pricePerKg != null)
                      Text(
                        '₹$pricePerKg/kg',
                        style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    if (weight != null)
                      Text(
                        '$weight kg',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
