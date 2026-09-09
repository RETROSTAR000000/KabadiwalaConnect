import 'package:flutter/material.dart';
// Note: Fallback handling is used in case AppLocalizations is not yet generated.
// import 'package:kabadiwala_connect/l10n/app_localizations.dart';

class OfflineBanner extends StatelessWidget {
  final bool isOnline;
  final int pendingSyncCount;

  const OfflineBanner({
    Key? key,
    required this.isOnline,
    this.pendingSyncCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isOnline && pendingSyncCount == 0) {
      return const SizedBox.shrink();
    }

    final isOffline = !isOnline;
    final color = isOffline ? Colors.orange : Colors.green;
    final icon = isOffline ? Icons.wifi_off : Icons.sync;
    
    // In a real app with generated AppLocalizations:
    // final loc = AppLocalizations.of(context);
    // final message = isOffline ? loc!.offlineMessage : loc!.pendingSyncMessage;
    final String message = isOffline 
        ? 'Offline' 
        : 'Syncing $pendingSyncCount items';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: color,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
