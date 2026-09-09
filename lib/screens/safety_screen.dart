import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/widgets/safety_card.dart';
import 'package:kabadiwala_connect/services/tts_service.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ttsService = TtsService();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.safetyGuide ?? 'Safety Guide'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Dangerous Practices - DO NOT DO THIS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
          const SizedBox(height: 10),
          SafetyCard(
            isDangerous: true,
            icon: Icons.local_fire_department,
            title: 'Don\'t Burn Cables',
            description: 'Burning cables releases toxic fumes that cause lung cancer.',
            onListenTap: () => ttsService.speak('Don\'t burn cables. It releases toxic fumes.'),
          ),
          SafetyCard(
            isDangerous: true,
            icon: Icons.battery_alert,
            title: 'Don\'t Open Batteries',
            description: 'Lead-acid batteries contain acid that causes severe burns.',
            onListenTap: () => ttsService.speak('Don\'t open batteries. The acid causes burns.'),
          ),
          SafetyCard(
            isDangerous: true,
            icon: Icons.tv_off,
            title: 'Don\'t Break CRTs',
            description: 'Old TVs and monitors contain toxic lead glass.',
            onListenTap: () => ttsService.speak('Don\'t break old TVs or monitors.'),
          ),
          SafetyCard(
            isDangerous: true,
            icon: Icons.science,
            title: 'Don\'t Use Acid on PCBs',
            description: 'Acid washing circuit boards is highly hazardous without protective gear.',
            onListenTap: () => ttsService.speak('Don\'t use acid on circuit boards.'),
          ),
          
          const Divider(height: 40, thickness: 2),
          const Text('Safe Practices - DO THIS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          const SizedBox(height: 10),
          
          SafetyCard(
            isDangerous: false,
            icon: Icons.back_hand,
            title: 'Wear Gloves',
            description: 'Always wear thick gloves when handling sharp metals or glass.',
            onListenTap: () => ttsService.speak('Always wear thick gloves.'),
          ),
          SafetyCard(
            isDangerous: false,
            icon: Icons.masks,
            title: 'Wear a Mask',
            description: 'Wear a mask when breaking dust-producing electronics.',
            onListenTap: () => ttsService.speak('Wear a mask to protect your lungs.'),
          ),
          SafetyCard(
            isDangerous: false,
            icon: Icons.wash,
            title: 'Wash Hands',
            description: 'Wash hands thoroughly with soap before eating.',
            onListenTap: () => ttsService.speak('Wash your hands thoroughly with soap.'),
          ),
          SafetyCard(
            isDangerous: false,
            icon: Icons.child_care,
            title: 'Keep Away from Children',
            description: 'Never let children play near e-waste dismantling areas.',
            onListenTap: () => ttsService.speak('Keep e-waste away from children.'),
          ),
        ],
      ),
    );
  }
}
