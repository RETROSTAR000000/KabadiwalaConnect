import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/models/price_record.dart';
import 'package:kabadiwala_connect/services/price_service.dart';
import 'package:kabadiwala_connect/services/tts_service.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/widgets/price_chip.dart';

class PriceBoardScreen extends StatefulWidget {
  const PriceBoardScreen({super.key});

  @override
  State<PriceBoardScreen> createState() => _PriceBoardScreenState();
}

class _PriceBoardScreenState extends State<PriceBoardScreen> {
  final db = DatabaseHelper();
  late final PriceService priceService;
  final ttsService = TtsService();

  Map<MaterialCategory, PriceRecord> prices = {};
  Map<MaterialCategory, PriceTrend> trends = {};
  bool isLoading = true;
  String selectedCity = 'Mumbai';
  MaterialCategory? expandedCategory;
  List<PriceRecord> expandedHistory = [];

  final List<String> cities = ['Mumbai', 'Pune', 'Delhi', 'Bangalore'];

  @override
  void initState() {
    super.initState();
    priceService = PriceService(db);
    _loadPrices();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ttsService.speak("Today's prices. Tap any item to hear.");
      }
    });
  }

  Future<void> _loadPrices() async {
    setState(() => isLoading = true);
    final data = await priceService.getAllLatestPrices(selectedCity);
    final newTrends = <MaterialCategory, PriceTrend>{};
    for (var record in data) {
      newTrends[record.materialCategory] = await priceService.getPriceTrend(record.materialCategory, selectedCity);
    }
    
    if (mounted) {
      setState(() {
        prices = {for (var p in data) p.materialCategory: p};
        trends = newTrends;
        isLoading = false;
      });
    }
  }

  Future<void> _expandCategory(MaterialCategory cat) async {
    final history = await priceService.getPriceHistory(cat, selectedCity);
    setState(() {
      if (expandedCategory == cat) {
        expandedCategory = null;
      } else {
        expandedCategory = cat;
        expandedHistory = history;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todayPrices ?? 'Today\'s Prices'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedCity,
                  items: cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedCity = val);
                      _loadPrices(); // Mock reload
                    }
                  },
                ),
                const Spacer(),
                Text('Last Updated: ${DateTime.now().toString().substring(0, 10)}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: MaterialCategory.values.length,
                    itemBuilder: (context, index) {
                      final cat = MaterialCategory.values[index];
                      final record = prices[cat];
                      if (record == null) return const SizedBox.shrink();

                      final isExpanded = expandedCategory == cat;
                      final trend = trends[cat] ?? PriceTrend.stable;

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.category, size: 40),
                              title: Text(cat.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              subtitle: Text('₹${record.buyingPricePerKg}/kg', style: const TextStyle(fontSize: 18, color: Colors.green)),
                              trailing: Icon(
                                trend == PriceTrend.up ? Icons.arrow_upward :
                                trend == PriceTrend.down ? Icons.arrow_downward : Icons.horizontal_rule,
                                color: trend == PriceTrend.up ? Colors.green :
                                       trend == PriceTrend.down ? Colors.red : Colors.grey,
                              ),
                              onTap: () {
                                ttsService.speakPrice(cat.name, record.buyingPricePerKg);
                                _expandCategory(cat);
                              },
                            ),
                            if (isExpanded)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  height: 150,
                                  child: LineChart(
                                    LineChartData(
                                      gridData: FlGridData(show: false),
                                      titlesData: FlTitlesData(show: false),
                                      borderData: FlBorderData(show: true),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: expandedHistory.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.buyingPricePerKg)).toList(),
                                          isCurved: true,
                                          color: Colors.blue,
                                          barWidth: 3,
                                          dotData: FlDotData(show: true),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
