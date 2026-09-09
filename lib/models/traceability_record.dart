class TraceabilityRecord {
  final String recordId;
  final String lotId;
  final String? transactionId;
  final String handoverReferenceNumber;
  final String? photographsHash;
  final double verifiedWeight;
  final DateTime timestamp;
  final double? latitude;
  final double? longitude;
  final bool recyclerConfirmed;
  final String subsequentStatus;

  const TraceabilityRecord({
    required this.recordId,
    required this.lotId,
    this.transactionId,
    required this.handoverReferenceNumber,
    this.photographsHash,
    required this.verifiedWeight,
    required this.timestamp,
    this.latitude,
    this.longitude,
    required this.recyclerConfirmed,
    required this.subsequentStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'recordId': recordId,
      'lotId': lotId,
      'transactionId': transactionId,
      'handoverReferenceNumber': handoverReferenceNumber,
      'photographsHash': photographsHash,
      'verifiedWeight': verifiedWeight,
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'recyclerConfirmed': recyclerConfirmed ? 1 : 0,
      'subsequentStatus': subsequentStatus,
    };
  }

  factory TraceabilityRecord.fromMap(Map<String, dynamic> map) {
    return TraceabilityRecord(
      recordId: map['recordId'] ?? '',
      lotId: map['lotId'] ?? '',
      transactionId: map['transactionId'],
      handoverReferenceNumber: map['handoverReferenceNumber'] ?? '',
      photographsHash: map['photographsHash'],
      verifiedWeight: (map['verifiedWeight'] ?? 0.0).toDouble(),
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      recyclerConfirmed: (map['recyclerConfirmed'] == 1 || map['recyclerConfirmed'] == true),
      subsequentStatus: map['subsequentStatus'] ?? '',
    );
  }
}
