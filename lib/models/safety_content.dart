import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class SafetyContent {
  final String contentId;
  final MaterialCategory? relatedCategory;
  final String hazardType; // 'burning', 'acid', 'battery_puncture', 'crt_breaking', 'general'
  final bool isDangerous; // true=warning (red), false=safe practice (green)
  final String titleHi;
  final String titleMr;
  final String titleEn;
  final String descriptionHi;
  final String descriptionMr;
  final String descriptionEn;
  final IconData icon;

  const SafetyContent({
    required this.contentId,
    this.relatedCategory,
    required this.hazardType,
    required this.isDangerous,
    required this.titleHi,
    required this.titleMr,
    required this.titleEn,
    required this.descriptionHi,
    required this.descriptionMr,
    required this.descriptionEn,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'contentId': contentId,
      'relatedCategory': relatedCategory?.name,
      'hazardType': hazardType,
      'isDangerous': isDangerous ? 1 : 0,
      'titleHi': titleHi,
      'titleMr': titleMr,
      'titleEn': titleEn,
      'descriptionHi': descriptionHi,
      'descriptionMr': descriptionMr,
      'descriptionEn': descriptionEn,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'iconFontPackage': icon.fontPackage,
    };
  }

  factory SafetyContent.fromMap(Map<String, dynamic> map) {
    return SafetyContent(
      contentId: map['contentId'] ?? '',
      relatedCategory: map['relatedCategory'] != null ? MaterialCategory.fromString(map['relatedCategory']) : null,
      hazardType: map['hazardType'] ?? 'general',
      isDangerous: (map['isDangerous'] == 1 || map['isDangerous'] == true),
      titleHi: map['titleHi'] ?? '',
      titleMr: map['titleMr'] ?? '',
      titleEn: map['titleEn'] ?? '',
      descriptionHi: map['descriptionHi'] ?? '',
      descriptionMr: map['descriptionMr'] ?? '',
      descriptionEn: map['descriptionEn'] ?? '',
      // ignore: non_const_argument_for_const_parameter
      icon: IconData(
        map['iconCodePoint'] ?? Icons.warning.codePoint,
        fontFamily: map['iconFontFamily'] ?? 'MaterialIcons',
        fontPackage: map['iconFontPackage'],
      ),
    );
  }
}
