import 'package:kabadiwala_connect/models/material_category.dart';

class Lot {
  final String lotId;
  final String collectorId;
  final MaterialCategory materialCategory;
  final String? materialSubcategory;
  final String? materialDescription;
  final double approximateWeightKg;
  final double estimatedValue;
  final String condition;
  final String? sourceType;
  final String? imagePath;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;
  final String status;
  final String syncStatus;

  const Lot({
    required this.lotId,
    required this.collectorId,
    required this.materialCategory,
    this.materialSubcategory,
    this.materialDescription,
    required this.approximateWeightKg,
    required this.estimatedValue,
    required this.condition,
    this.sourceType,
    this.imagePath,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.status,
    required this.syncStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'lotId': lotId,
      'collectorId': collectorId,
      'materialCategory': materialCategory.name,
      'materialSubcategory': materialSubcategory,
      'materialDescription': materialDescription,
      'approximateWeightKg': approximateWeightKg,
      'estimatedValue': estimatedValue,
      'condition': condition,
      'sourceType': sourceType,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'syncStatus': syncStatus,
    };
  }

  factory Lot.fromMap(Map<String, dynamic> map) {
    return Lot(
      lotId: map['lotId'] ?? '',
      collectorId: map['collectorId'] ?? '',
      materialCategory: MaterialCategory.fromString(map['materialCategory'] ?? ''),
      materialSubcategory: map['materialSubcategory'],
      materialDescription: map['materialDescription'],
      approximateWeightKg: (map['approximateWeightKg'] ?? 0.0).toDouble(),
      estimatedValue: (map['estimatedValue'] ?? 0.0).toDouble(),
      condition: map['condition'] ?? 'mixed',
      sourceType: map['sourceType'],
      imagePath: map['imagePath'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      status: map['status'] ?? 'created',
      syncStatus: map['syncStatus'] ?? 'pending_sync',
    );
  }

  Lot copyWith({
    String? lotId,
    String? collectorId,
    MaterialCategory? materialCategory,
    String? materialSubcategory,
    String? materialDescription,
    double? approximateWeightKg,
    double? estimatedValue,
    String? condition,
    String? sourceType,
    String? imagePath,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    String? status,
    String? syncStatus,
  }) {
    return Lot(
      lotId: lotId ?? this.lotId,
      collectorId: collectorId ?? this.collectorId,
      materialCategory: materialCategory ?? this.materialCategory,
      materialSubcategory: materialSubcategory ?? this.materialSubcategory,
      materialDescription: materialDescription ?? this.materialDescription,
      approximateWeightKg: approximateWeightKg ?? this.approximateWeightKg,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      condition: condition ?? this.condition,
      sourceType: sourceType ?? this.sourceType,
      imagePath: imagePath ?? this.imagePath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}
