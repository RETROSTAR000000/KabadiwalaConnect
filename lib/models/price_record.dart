import 'package:kabadiwala_connect/models/material_category.dart';

class PriceRecord {
  final String? id;
  final MaterialCategory materialCategory;
  final String? materialSubcategory;
  final String locationCity;
  final String? locationState;
  final double buyingPricePerKg;
  final double? marketRangeLow;
  final double? marketRangeHigh;
  final double? recyclerOfferedPrice;
  final String unit;
  final String? sourceRecyclerId;
  final DateTime priceDate;

  const PriceRecord({
    this.id,
    required this.materialCategory,
    this.materialSubcategory,
    required this.locationCity,
    this.locationState,
    required this.buyingPricePerKg,
    this.marketRangeLow,
    this.marketRangeHigh,
    this.recyclerOfferedPrice,
    required this.unit,
    this.sourceRecyclerId,
    required this.priceDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'materialCategory': materialCategory.name,
      'materialSubcategory': materialSubcategory,
      'locationCity': locationCity,
      'locationState': locationState,
      'buyingPricePerKg': buyingPricePerKg,
      'marketRangeLow': marketRangeLow,
      'marketRangeHigh': marketRangeHigh,
      'recyclerOfferedPrice': recyclerOfferedPrice,
      'unit': unit,
      'sourceRecyclerId': sourceRecyclerId,
      'priceDate': priceDate.toIso8601String(),
    };
  }

  factory PriceRecord.fromMap(Map<String, dynamic> map) {
    return PriceRecord(
      id: map['id'],
      materialCategory: MaterialCategory.fromString(map['materialCategory'] ?? ''),
      materialSubcategory: map['materialSubcategory'],
      locationCity: map['locationCity'] ?? '',
      locationState: map['locationState'],
      buyingPricePerKg: (map['buyingPricePerKg'] ?? 0.0).toDouble(),
      marketRangeLow: map['marketRangeLow']?.toDouble(),
      marketRangeHigh: map['marketRangeHigh']?.toDouble(),
      recyclerOfferedPrice: map['recyclerOfferedPrice']?.toDouble(),
      unit: map['unit'] ?? 'INR/kg',
      sourceRecyclerId: map['sourceRecyclerId'],
      priceDate: map['priceDate'] != null ? DateTime.parse(map['priceDate']) : DateTime.now(),
    );
  }
}
