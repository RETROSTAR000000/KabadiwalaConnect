import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/transaction_record.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class HandoverScreen extends StatelessWidget {
  final TransactionRecord? transaction;

  const HandoverScreen({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Demo fallback if no transaction provided
    final tx = transaction ?? TransactionRecord(
      transactionId: 'tx_demo',
      collectorId: 'coll_123',
      recyclerId: 'rec_456',
      lotId: 'lot_demo',
      createdAt: DateTime.now(),
      transactionStatus: 'Pending Confirmation',
      paymentStatus: 'pending',
      quotedPrice: 1500.0,
      finalPrice: 1500.0,
      materialCategory: MaterialCategory.crt,
      weight: 25.0,
      handoverReference: 'REF-DEMO-1234',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.handoverTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.receipt_long, size: 60, color: Colors.blue),
                  const SizedBox(height: 16),
                  Text('Ref: ${tx.referenceNumber}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  QrImageView(
                    data: tx.referenceNumber.isNotEmpty ? tx.referenceNumber : tx.transactionId,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: tx.transactionStatus.contains('Pending') ? Colors.orange.withValues(alpha: 0.2) : Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tx.transactionStatus,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: tx.transactionStatus.contains('Pending') ? Colors.orange : Colors.green,
                      ),
                    ),
                  ),
                  const Divider(height: 32, thickness: 2),
                  _buildRow('Material', tx.materialCategory?.name ?? 'Mixed E-Waste'),
                  _buildRow('Weight', '${tx.weight ?? 0.0} kg'),
                  _buildRow('Agreed Price', '₹${tx.finalPrice ?? tx.quotedPrice ?? 0.0}'),
                  _buildRow('Date', tx.createdAt.toString().substring(0, 16)),
                  _buildRow('Recycler ID', tx.recyclerId),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.share),
                      label: Text(l10n.shareHandover),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sharing Receipt...'))
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
