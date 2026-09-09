class Collector {
  final String collectorId;
  final String preferredLanguage; // 'en', 'hi', 'mr'
  final String operatingArea;
  final double totalEarnings;
  final DateTime createdAt;

  const Collector({
    required this.collectorId,
    required this.preferredLanguage,
    required this.operatingArea,
    required this.totalEarnings,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'collectorId': collectorId,
      'preferredLanguage': preferredLanguage,
      'operatingArea': operatingArea,
      'totalEarnings': totalEarnings,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Collector.fromMap(Map<String, dynamic> map) {
    return Collector(
      collectorId: map['collectorId'] ?? '',
      preferredLanguage: map['preferredLanguage'] ?? 'en',
      operatingArea: map['operatingArea'] ?? '',
      totalEarnings: (map['totalEarnings'] ?? 0.0).toDouble(),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }
}
