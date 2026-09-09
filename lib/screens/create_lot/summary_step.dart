import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/services/price_service.dart';
import 'package:kabadiwala_connect/services/lot_service.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/services/tts_service.dart';
import '../recycler_list_screen.dart';

class SummaryStep extends StatefulWidget {
  final String? imagePath;
  final MaterialCategory? category;
  final double? weight;
  final String? condition;
  final VoidCallback onSaved;

  const SummaryStep({
    Key? key,
    this.imagePath,
    this.category,
    this.weight,
    this.condition,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<SummaryStep> createState() => _SummaryStepState();
}

class _SummaryStepState extends State<SummaryStep> {
  final db = DatabaseHelper();
  late final PriceService priceService;
  late final LotService lotService;
  final ttsService = TtsService();

  double? estValue;
  double? lowValue;
  double? highValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    priceService = PriceService(db);
    lotService = LotService(db, priceService);
    _estimateValue();
  }

  @override
  void didUpdateWidget(covariant SummaryStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.category != widget.category ||
        oldWidget.weight != widget.weight ||
        oldWidget.condition != widget.condition) {
      _estimateValue();
    }
  }

  Future<void> _estimateValue() async {
    if (widget.category != null && widget.weight != null) {
      final estimate = await priceService.estimateValue(
        widget.category!,
        widget.weight!,
        widget.condition ?? 'Intact',
        'Mumbai',
      );
      if (mounted) {
        setState(() {
          estValue = estimate.estimatedValue;
          lowValue = estimate.rangeLow;
          highValue = estimate.rangeHigh;
          isLoading = false;
        });
        try {
          await ttsService.speak('Estimated value is ${estValue?.toInt()} rupees');
        } catch (_) {}
      }
    } else {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _saveLot() async {
    if (widget.category == null || widget.weight == null) return;
    
    await lotService.createLot(
      category: widget.category!,
      weight: widget.weight!,
      condition: widget.condition ?? 'Intact',
      imagePath: widget.imagePath,
    );

    widget.onSaved();

    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('Lot Saved!'),
          content: const Text('Find Recycler now?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const RecyclerListScreen())
                );
              },
              child: const Text('Find Recycler'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(l10n.lotCreated, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          if (widget.imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(widget.imagePath!), height: 150, width: double.infinity, fit: BoxFit.cover),
            ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Material: ${widget.category?.name ?? 'Unknown'}', style: const TextStyle(fontSize: 18)),
                      Icon(Icons.category, color: Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Weight: ${widget.weight ?? 0} kg', style: const TextStyle(fontSize: 18)),
                      const Icon(Icons.scale, color: Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Condition: ${widget.condition ?? 'Unknown'}', style: const TextStyle(fontSize: 18)),
                      const Icon(Icons.info, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Column(
              children: [
                Text(
                  'Estimated: ₹${estValue?.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Text(
                  'Market: ₹${lowValue?.toStringAsFixed(2)} - ₹${highValue?.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(16),
              ),
              icon: const Icon(Icons.save),
              label: Text(l10n.saveLot ?? 'Save Lot', style: const TextStyle(fontSize: 24, color: Colors.white)),
              onPressed: _saveLot,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
