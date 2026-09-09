import 'package:kabadiwala_connect/models/material_category.dart';

class TransactionRecord {
  final String transactionId;
  final String lotId;
  final String collectorId;
  final String recyclerId;
  final double? quotedPrice;
  final double? finalPrice;
  final String? paymentMethod; // 'cash', 'upi', 'bank_transfer'
  final String paymentStatus; // 'pending', 'paid'
  final double? handoverLatitude;
  final double? handoverLongitude;
  final DateTime? handoverTime;
  final String? handoverReference; // Unique ref like KWC-2024-0115-A7B3
  final String? recyclerConfirmation;
  final String transactionStatus; // 'created','quoted','accepted','handed_over','confirmed','paid'
  final DateTime createdAt;
  final MaterialCategory? materialCategory;
  final double? weight;

  String get id => transactionId;
  String get status => transactionStatus;
  DateTime get date => createdAt;
  double get agreedPrice => finalPrice ?? quotedPrice ?? 0.0;
  String get referenceNumber => handoverReference ?? '';

  const TransactionRecord({
    required this.transactionId,
    required this.lotId,
    required this.collectorId,
    required this.recyclerId,
    this.quotedPrice,
    this.finalPrice,
    this.paymentMethod,
    required this.paymentStatus,
    this.handoverLatitude,
    this.handoverLongitude,
    this.handoverTime,
    this.handoverReference,
    this.recyclerConfirmation,
    required this.transactionStatus,
    required this.createdAt,
    this.materialCategory,
    this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'transactionId': transactionId,
      'lotId': lotId,
      'collectorId': collectorId,
      'recyclerId': recyclerId,
      'quotedPrice': quotedPrice,
      'finalPrice': finalPrice,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'handoverLatitude': handoverLatitude,
      'handoverLongitude': handoverLongitude,
      'handoverTime': handoverTime?.toIso8601String(),
      'handoverReference': handoverReference,
      'recyclerConfirmation': recyclerConfirmation,
      'transactionStatus': transactionStatus,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TransactionRecord.fromMap(Map<String, dynamic> map) {
    return TransactionRecord(
      transactionId: map['transactionId'] ?? '',
      lotId: map['lotId'] ?? '',
      collectorId: map['collectorId'] ?? '',
      recyclerId: map['recyclerId'] ?? '',
      quotedPrice: map['quotedPrice']?.toDouble(),
      finalPrice: map['finalPrice']?.toDouble(),
      paymentMethod: map['paymentMethod'],
      paymentStatus: map['paymentStatus'] ?? 'pending',
      handoverLatitude: map['handoverLatitude']?.toDouble(),
      handoverLongitude: map['handoverLongitude']?.toDouble(),
      handoverTime: map['handoverTime'] != null ? DateTime.parse(map['handoverTime']) : null,
      handoverReference: map['handoverReference'],
      recyclerConfirmation: map['recyclerConfirmation'],
      transactionStatus: map['transactionStatus'] ?? 'created',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : DateTime.now(),
      materialCategory: map['materialCategory'] != null ? MaterialCategory.fromString(map['materialCategory']) : null,
      weight: map['weight']?.toDouble(),
    );
  }

  TransactionRecord copyWith({
    String? transactionId,
    String? lotId,
    String? collectorId,
    String? recyclerId,
    double? quotedPrice,
    double? finalPrice,
    String? paymentMethod,
    String? paymentStatus,
    double? handoverLatitude,
    double? handoverLongitude,
    DateTime? handoverTime,
    String? handoverReference,
    String? recyclerConfirmation,
    String? transactionStatus,
    DateTime? createdAt,
    MaterialCategory? materialCategory,
    double? weight,
  }) {
    return TransactionRecord(
      transactionId: transactionId ?? this.transactionId,
      lotId: lotId ?? this.lotId,
      collectorId: collectorId ?? this.collectorId,
      recyclerId: recyclerId ?? this.recyclerId,
      quotedPrice: quotedPrice ?? this.quotedPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      handoverLatitude: handoverLatitude ?? this.handoverLatitude,
      handoverLongitude: handoverLongitude ?? this.handoverLongitude,
      handoverTime: handoverTime ?? this.handoverTime,
      handoverReference: handoverReference ?? this.handoverReference,
      recyclerConfirmation: recyclerConfirmation ?? this.recyclerConfirmation,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      createdAt: createdAt ?? this.createdAt,
      materialCategory: materialCategory ?? this.materialCategory,
      weight: weight ?? this.weight,
    );
  }
}
