import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:kabadiwala_connect/theme/app_theme.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/database/seed_data.dart';
import 'package:kabadiwala_connect/services/sync_service.dart';
import 'package:kabadiwala_connect/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database and seed data
  final db = DatabaseHelper();
  await db.database; // Ensure database is created
  await SeedData.seedDatabase(db);

  // Initialize sync service for connectivity monitoring
  final syncService = SyncService();
  syncService.startMonitoring();

  runApp(
    KabadiwalaConnectApp(syncService: syncService),
  );
}

/// KabadiwalaConnect — Digital bridge between informal scrap collectors
/// and the formal recycling ecosystem.
///
/// Features:
/// - Offline-first architecture with SQLite
/// - Hindi, Marathi, and English localization
/// - Low-literacy optimized UI with large touch targets
/// - Material classification and price estimation
/// - Recycler matching and handover record generation
class KabadiwalaConnectApp extends StatefulWidget {
  final SyncService syncService;

  const KabadiwalaConnectApp({super.key, required this.syncService});

  @override
  State<KabadiwalaConnectApp> createState() => _KabadiwalaConnectAppState();

  /// Allows changing locale from anywhere in the widget tree
  static void setLocale(BuildContext context, Locale locale) {
    final state = context.findAncestorStateOfType<_KabadiwalaConnectAppState>();
    state?.setLocale(locale);
  }
}

class _KabadiwalaConnectAppState extends State<KabadiwalaConnectApp> {
  Locale _locale = const Locale('hi'); // Default to Hindi for target users

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SyncService>.value(
      value: widget.syncService,
      child: MaterialApp(
        title: 'KabadiwalaConnect',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        locale: _locale,
        supportedLocales: const [
          Locale('en'), // English
          Locale('hi'), // Hindi
          Locale('mr'), // Marathi
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const HomeScreen(),
      ),
    );
  }
}
