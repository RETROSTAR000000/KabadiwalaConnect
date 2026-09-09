import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';

enum MaterialCategory {
  pcb,
  crt,
  lcd,
  cable,
  battery,
  motor,
  mixedPlastic;

  String localizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (loc == null) return name;
    switch (this) {
      case MaterialCategory.pcb:
        return loc.materialPCB;
      case MaterialCategory.crt:
        return loc.materialCRT;
      case MaterialCategory.lcd:
        return loc.materialLCD;
      case MaterialCategory.cable:
        return loc.materialCable;
      case MaterialCategory.battery:
        return loc.materialBattery;
      case MaterialCategory.motor:
        return loc.materialMotor;
      case MaterialCategory.mixedPlastic:
        return loc.materialPlastic;
    }
  }

  String get displayName {
    switch (this) {
      case MaterialCategory.pcb:
        return 'PCB';
      case MaterialCategory.crt:
        return 'CRT';
      case MaterialCategory.lcd:
        return 'LCD';
      case MaterialCategory.cable:
        return 'Cable';
      case MaterialCategory.battery:
        return 'Battery';
      case MaterialCategory.motor:
        return 'Motor';
      case MaterialCategory.mixedPlastic:
        return 'Mixed Plastic';
    }
  }

  IconData get icon {
    switch (this) {
      case MaterialCategory.pcb:
        return Icons.memory;
      case MaterialCategory.crt:
        return Icons.tv;
      case MaterialCategory.lcd:
        return Icons.tablet;
      case MaterialCategory.cable:
        return Icons.cable;
      case MaterialCategory.battery:
        return Icons.battery_full;
      case MaterialCategory.motor:
        return Icons.settings;
      case MaterialCategory.mixedPlastic:
        return Icons.recycling;
    }
  }

  Color get color {
    switch (this) {
      case MaterialCategory.pcb:
        return Colors.green; // Fallback to Colors if AppColors missing, ideally AppColors.pcb
      case MaterialCategory.crt:
        return Colors.brown;
      case MaterialCategory.lcd:
        return Colors.blue;
      case MaterialCategory.cable:
        return Colors.deepOrange;
      case MaterialCategory.battery:
        return Colors.red;
      case MaterialCategory.motor:
        return Colors.blueGrey;
      case MaterialCategory.mixedPlastic:
        return Colors.purple;
    }
  }

  static MaterialCategory fromString(String categoryString) {
    return MaterialCategory.values.firstWhere(
      (e) => e.name == categoryString,
      orElse: () => MaterialCategory.mixedPlastic,
    );
  }
}
