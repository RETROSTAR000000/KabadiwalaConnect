import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/transaction_record.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/services/transaction_service.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/widgets/transaction_card.dart';
import 'handover_screen.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  final db = DatabaseHelper();
  late final TransactionService transactionService;

  List<TransactionRecord> transactions = [];
  EarningsSummary? summary;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    transactionService = TransactionService(db);
    _loadData();
  }

  Future<void> _loadData() async {
    final txs = await transactionService.getTransactionsByCollector('coll_123');
    final sum = await transactionService.getEarningsSummary('coll_123');
    
    if (mounted) {
      setState(() {
        transactions = txs;
        summary = sum;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myLedger ?? 'My Ledger'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (summary != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryCard('Total Earnings', '₹${summary!.totalEarnings}', Colors.green),
                        _buildSummaryCard('Pending Dues', '₹${summary!.pendingDues}', Colors.orange),
                        _buildSummaryCard('Sales', '${summary!.completedCount}', Colors.blue),
                      ],
                    ),
                  ),
                const Divider(),
                Expanded(
                  child: transactions.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.account_balance_wallet, size: 80, color: Colors.grey),
                              const SizedBox(height: 16),
                              Text('Start selling to build your earnings!', style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final tx = transactions[index];
                            return TransactionCard(
                              category: tx.materialCategory ?? MaterialCategory.pcb,
                              weight: tx.weight ?? 0.0,
                              value: tx.finalPrice ?? tx.quotedPrice,
                              status: tx.transactionStatus,
                              date: tx.createdAt,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => HandoverScreen(transaction: tx))
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildSummaryCard(String label, String value, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
