import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/widgets/language_selector.dart';
import 'package:kabadiwala_connect/services/tts_service.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String currentLang = 'en';
  final ttsService = TtsService();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const ListTile(
            leading: Icon(Icons.person, size: 40),
            title: Text('Collector ID: coll_123', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('KabadiwalaConnect Agent'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language / भाषा'),
            trailing: LanguageSelector(
              currentLanguage: currentLang,
              onLanguageChanged: (val) {
                setState(() {
                  currentLang = val;
                  ttsService.setLanguage(val);
                });
              },
            ),
          ),
          const ListTile(
            leading: Icon(Icons.map),
            title: Text('Operating Area'),
            trailing: Text('Mumbai Central'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('App Version'),
            trailing: Text('1.0.0 (MVP)'),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('About'),
            subtitle: Text('KabadiwalaConnect - SIH E-Waste Platform'),
          ),
        ],
      ),
    );
  }
}
