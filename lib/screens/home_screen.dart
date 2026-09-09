import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:kabadiwala_connect/widgets/big_icon_button.dart';
import 'package:kabadiwala_connect/widgets/transaction_card.dart';
import 'package:kabadiwala_connect/widgets/language_selector.dart';
import 'package:kabadiwala_connect/widgets/offline_banner.dart';
import 'package:kabadiwala_connect/services/lot_service.dart';
import 'package:kabadiwala_connect/services/transaction_service.dart';
import 'package:kabadiwala_connect/services/tts_service.dart';
import 'package:kabadiwala_connect/services/sync_service.dart';
import 'package:kabadiwala_connect/services/price_service.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/models/transaction_record.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

import 'create_lot/create_lot_screen.dart';
import 'price_board_screen.dart';
import 'recycler_list_screen.dart';
import 'ledger_screen.dart';
import 'safety_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper();
  late final LotService lotService;
  late final TransactionService transactionService;
  final ttsService = TtsService();
  final syncService = SyncService();
  
  List<TransactionRecord> recentTransactions = [];
  bool isLoading = true;
  String currentLang = 'en';

  @override
  void initState() {
    super.initState();
    final priceService = PriceService(db);
    lotService = LotService(db, priceService);
    transactionService = TransactionService(db);
    
    _loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && AppLocalizations.of(context) != null) {
        ttsService.speak(AppLocalizations.of(context)!.ttsGreeting);
      }
    });
  }

  Future<void> _loadData() async {
    try {
      final txs = await transactionService.getTransactionsByCollector('coll_123');
      if (mounted) {
        setState(() {
          recentTransactions = txs.take(5).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('KabadiwalaConnect'),
        actions: [
          LanguageSelector(
            currentLanguage: currentLang,
            onLanguageChanged: (val) {
              setState(() {
                currentLang = val;
                ttsService.setLanguage(val);
              });
            }
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      BigIconButton(
                        icon: Icons.add_a_photo,
                        label: l10n.newLot,
                        color: Colors.blue,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateLotScreen())),
                      ),
                      BigIconButton(
                        icon: Icons.price_change,
                        label: l10n.todayPrices,
                        color: Colors.orange,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PriceBoardScreen())),
                      ),
                      BigIconButton(
                        icon: Icons.recycling,
                        label: l10n.findRecycler,
                        color: Colors.green,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RecyclerListScreen())),
                      ),
                      BigIconButton(
                        icon: Icons.account_balance_wallet,
                        label: l10n.myLedger,
                        color: Colors.purple,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LedgerScreen())),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.warning, color: Colors.red),
                  label: Text(l10n.safetyGuide),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SafetyScreen())),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(l10n.recentTransactions, style: Theme.of(context).textTheme.titleLarge),
                ),
                Expanded(
                  child: recentTransactions.isEmpty 
                    ? Center(child: Text(l10n.noTransactions))
                    : ListView.builder(
                        itemCount: recentTransactions.length,
                        itemBuilder: (ctx, idx) {
                          final tx = recentTransactions[idx];
                          return TransactionCard(
                            category: tx.materialCategory ?? MaterialCategory.pcb,
                            weight: tx.weight ?? 0.0,
                            value: tx.finalPrice ?? tx.quotedPrice,
                            status: tx.transactionStatus,
                            date: tx.createdAt,
                            onTap: () {}
                          );
                        }
                      )
                ),
                ChangeNotifierProvider.value(
                  value: syncService,
                  child: Consumer<SyncService>(
                    builder: (context, sync, child) {
                      return OfflineBanner(
                        isOnline: sync.isOnline,
                        pendingSyncCount: sync.pendingSyncCount,
                      );
                    }
                  ),
                ),
              ],
            ),
    );
  }
}
