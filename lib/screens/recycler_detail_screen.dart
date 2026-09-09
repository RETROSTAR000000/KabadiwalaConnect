import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/recycler.dart';
import 'package:kabadiwala_connect/services/recycler_service.dart';
import 'package:kabadiwala_connect/services/transaction_service.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/widgets/material_card.dart';
import 'handover_screen.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class RecyclerDetailScreen extends StatefulWidget {
  final String recyclerId;

  const RecyclerDetailScreen({super.key, required this.recyclerId});

  @override
  State<RecyclerDetailScreen> createState() => _RecyclerDetailScreenState();
}

class _RecyclerDetailScreenState extends State<RecyclerDetailScreen> {
  final db = DatabaseHelper();
  late final RecyclerService recyclerService;
  late final TransactionService transactionService;

  Recycler? recycler;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    recyclerService = RecyclerService(db);
    transactionService = TransactionService(db);
    _loadRecycler();
  }

  Future<void> _loadRecycler() async {
    final r = await recyclerService.getRecyclerById(widget.recyclerId);
    if (mounted) {
      setState(() {
        recycler = r;
        isLoading = false;
      });
    }
  }

  Future<void> _selectRecycler() async {
    if (recycler == null) return;
    
    // Create dummy transaction for MVP
    final tx = await transactionService.createTransaction(
      'lot_demo',
      'coll_123',
      recycler!.recyclerId,
      500.0,
      materialCategory: MaterialCategory.pcb,
      weight: 10.0,
    );
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HandoverScreen(transaction: tx))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (recycler == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Recycler not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(recycler!.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(recycler!.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    ),
                    if (recycler!.isAuthorized)
                      const Chip(
                        avatar: Icon(Icons.verified, color: Colors.white),
                        label: Text('Authorized', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.green,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.red),
                  title: Text(recycler!.address ?? 'Local Area'),
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.blue),
                  title: Text(recycler!.phone),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Calling...'))
                      );
                    },
                  ),
                ),
                if (recycler!.authNumber.isNotEmpty)
                  ListTile(
                    leading: const Icon(Icons.assignment_turned_in, color: Colors.purple),
                    title: Text('Auth: ${recycler!.authNumber}'),
                  ),
                ListTile(
                  leading: const Icon(Icons.map, color: Colors.orange),
                  title: Text('Service Radius: ${recycler!.serviceRadiusKm} km'),
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.brown),
                  title: Text(recycler!.pickupAvailable ? 'Pickup Available' : 'No Pickup'),
                ),
                const Divider(),
                const Text('Accepted Materials', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Column(
                  children: (recycler!.acceptedMaterials ?? []).map((rm) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: MaterialCard(
                        category: rm.materialCategory,
                        pricePerKg: rm.offeredRatePerKg,
                        selected: false,
                        onTap: () {},
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: _selectRecycler,
                child: const Text('Select This Recycler', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
