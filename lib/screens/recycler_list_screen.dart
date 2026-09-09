import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/models/recycler.dart';
import 'package:kabadiwala_connect/services/recycler_service.dart';
import 'package:kabadiwala_connect/services/tts_service.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/widgets/recycler_card.dart';
import 'recycler_detail_screen.dart';

class RecyclerListScreen extends StatefulWidget {
  const RecyclerListScreen({super.key});

  @override
  State<RecyclerListScreen> createState() => _RecyclerListScreenState();
}

class _RecyclerListScreenState extends State<RecyclerListScreen> {
  final db = DatabaseHelper();
  late final RecyclerService recyclerService;
  final ttsService = TtsService();

  List<RankedRecycler> recyclers = [];
  bool isLoading = true;
  MaterialCategory? filterCategory;

  @override
  void initState() {
    super.initState();
    recyclerService = RecyclerService(db);
    _loadRecyclers();
  }

  Future<void> _loadRecyclers() async {
    setState(() => isLoading = true);
    // Location: Mumbai/Pune area
    final list = await recyclerService.findRecyclers(
      filterCategory ?? MaterialCategory.pcb,
      19.0760,
      72.8777,
    );
    
    if (mounted) {
      setState(() {
        recyclers = list;
        isLoading = false;
      });
      if (list.isNotEmpty) {
        ttsService.speak('Found ${list.length} recyclers near you');
      } else {
        ttsService.speak('No recyclers found');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.findRecycler ?? 'Find Recycler'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: MaterialCategory.values.map((cat) {
                final isSelected = filterCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(cat.name),
                    selected: isSelected,
                    onSelected: (val) {
                      setState(() {
                        filterCategory = val ? cat : null;
                      });
                      _loadRecyclers();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : recyclers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off, size: 100, color: Colors.grey),
                            const SizedBox(height: 16),
                            Text(l10n.noRecyclersFound ?? 'No recyclers found', style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: recyclers.length,
                        itemBuilder: (context, index) {
                          final rr = recyclers[index];
                          return RecyclerCard(
                            name: rr.recycler.facilityName,
                            distance: '${rr.distanceKm.toStringAsFixed(1)} km',
                            offeredRate: rr.offeredRate,
                            isAuthorized: rr.recycler.isAuthorized,
                            pickupAvailable: rr.recycler.pickupAvailable,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RecyclerDetailScreen(recyclerId: rr.recycler.recyclerId)
                                )
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
}
