import 'package:kabadiwala_connect/models/material_category.dart';

class RecyclerMaterial {
  final String? id;
  final String recyclerId;
  final MaterialCategory materialCategory;
  final double offeredRatePerKg;
  final DateTime? rateUpdatedAt;

  const RecyclerMaterial({
    this.id,
    required this.recyclerId,
    required this.materialCategory,
    required this.offeredRatePerKg,
    this.rateUpdatedAt,
  });

  MaterialCategory get category => materialCategory;
  double get offeredPrice => offeredRatePerKg;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recyclerId': recyclerId,
      'materialCategory': materialCategory.name,
      'offeredRatePerKg': offeredRatePerKg,
      'rateUpdatedAt': rateUpdatedAt?.toIso8601String(),
    };
  }

  factory RecyclerMaterial.fromMap(Map<String, dynamic> map) {
    return RecyclerMaterial(
      id: map['id'],
      recyclerId: map['recyclerId'] ?? '',
      materialCategory: MaterialCategory.fromString(map['materialCategory'] ?? ''),
      offeredRatePerKg: (map['offeredRatePerKg'] ?? 0.0).toDouble(),
      rateUpdatedAt: map['rateUpdatedAt'] != null ? DateTime.parse(map['rateUpdatedAt']) : null,
    );
  }
}

class Recycler {
  final String recyclerId;
  final String facilityName;
  final double latitude;
  final double longitude;
  final String? address;
  final String authorizationNumber;
  final String authorizationStatus; // 'active', 'expired'
  final String contactPhone;
  final String? contactEmail;
  final bool pickupAvailable;
  final double serviceRadiusKm;
  final DateTime? authorizationExpiry;
  final List<RecyclerMaterial>? acceptedMaterials;

  const Recycler({
    required this.recyclerId,
    required this.facilityName,
    required this.latitude,
    required this.longitude,
    this.address,
    required this.authorizationNumber,
    required this.authorizationStatus,
    required this.contactPhone,
    this.contactEmail,
    required this.pickupAvailable,
    required this.serviceRadiusKm,
    this.authorizationExpiry,
    this.acceptedMaterials,
  });

  String get id => recyclerId;
  String get name => facilityName;
  bool get isAuthorized => authorizationStatus == 'active';
  String get phone => contactPhone;
  String get authNumber => authorizationNumber;

  Map<String, dynamic> toMap() {
    return {
      'recyclerId': recyclerId,
      'facilityName': facilityName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'authorizationNumber': authorizationNumber,
      'authorizationStatus': authorizationStatus,
      'contactPhone': contactPhone,
      'contactEmail': contactEmail,
      'pickupAvailable': pickupAvailable ? 1 : 0,
      'serviceRadiusKm': serviceRadiusKm,
      'authorizationExpiry': authorizationExpiry?.toIso8601String(),
    };
  }

  factory Recycler.fromMap(Map<String, dynamic> map, {List<RecyclerMaterial>? acceptedMaterials}) {
    return Recycler(
      recyclerId: map['recyclerId'] ?? '',
      facilityName: map['facilityName'] ?? '',
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      address: map['address'],
      authorizationNumber: map['authorizationNumber'] ?? '',
      authorizationStatus: map['authorizationStatus'] ?? 'active',
      contactPhone: map['contactPhone'] ?? '',
      contactEmail: map['contactEmail'],
      pickupAvailable: (map['pickupAvailable'] == 1 || map['pickupAvailable'] == true),
      serviceRadiusKm: (map['serviceRadiusKm'] ?? 0.0).toDouble(),
      authorizationExpiry: map['authorizationExpiry'] != null ? DateTime.parse(map['authorizationExpiry']) : null,
      acceptedMaterials: acceptedMaterials,
    );
  }
}
