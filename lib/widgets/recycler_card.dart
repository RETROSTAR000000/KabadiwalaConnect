import 'package:flutter/material.dart';

class RecyclerCard extends StatelessWidget {
  final String name;
  final String distance;
  final double? offeredRate;
  final bool isAuthorized;
  final bool pickupAvailable;
  final VoidCallback? onTap;

  const RecyclerCard({
    Key? key,
    required this.name,
    required this.distance,
    this.offeredRate,
    this.isAuthorized = false,
    this.pickupAvailable = false,
    this.onTap,
  }) : super(key: key);

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
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.factory, size: 40, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(distance, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (isAuthorized)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                            child: const Text('Authorized', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        if (isAuthorized && pickupAvailable) const SizedBox(width: 8),
                        if (pickupAvailable)
                          const Icon(Icons.local_shipping, size: 16, color: Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
              if (offeredRate != null)
                Text(
                  '₹$offeredRate/kg',
                  style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
