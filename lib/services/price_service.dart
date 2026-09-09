import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/models/price_record.dart';

class PriceEstimate {
  final double estimatedValue;
  final double rangeLow;
  final double rangeHigh;
  final double pricePerKg;
  final String condition;

  PriceEstimate({
    required this.estimatedValue,
    required this.rangeLow,
    required this.rangeHigh,
    required this.pricePerKg,
    required this.condition,
  });
}

enum PriceTrend { up, down, stable }

class PriceService {
  final DatabaseHelper _db;

  PriceService(this._db);

  Future<PriceRecord?> getLatestPrice(MaterialCategory category, String city) async {
    final db = await _db.database;
    final res = await db.query(
      'price_history',
      where: 'materialCategory = ? AND locationCity = ?',
      whereArgs: [category.name, city], 
      orderBy: 'priceDate DESC',
      limit: 1,
    );
    
    if (res.isNotEmpty) {
      return PriceRecord.fromMap(res.first);
    }
    return null;
  }

  Future<List<PriceRecord>> getAllLatestPrices(String city) async {
    final List<PriceRecord> latest = [];
    for (var cat in MaterialCategory.values) {
      final p = await getLatestPrice(cat, city);
      if (p != null) latest.add(p);
    }
    return latest;
  }

  Future<PriceEstimate> estimateValue(MaterialCategory category, double weightKg, String condition, String city) async {
    final latestPrice = await getLatestPrice(category, city);
    double basePrice = latestPrice?.buyingPricePerKg ?? 0.0;
    
    // Fallback if no price found in DB for MVP
    if (basePrice == 0.0) {
       basePrice = 25.0;
    }

    double conditionFactor = 1.0;
    if (condition.toLowerCase() == 'broken') conditionFactor = 0.7;
    if (condition.toLowerCase() == 'mixed') conditionFactor = 0.5;

    double finalPricePerKg = basePrice * conditionFactor;
    double estimated = finalPricePerKg * weightKg;

    return PriceEstimate(
      estimatedValue: estimated,
      rangeLow: estimated * 0.9,
      rangeHigh: estimated * 1.1,
      pricePerKg: finalPricePerKg,
      condition: condition,
    );
  }

  Future<List<PriceRecord>> getPriceHistory(MaterialCategory category, String city, {int days = 30}) async {
    final db = await _db.database;
    final cutoff = DateTime.now().subtract(Duration(days: days)).toIso8601String();
    final res = await db.query(
      'price_history',
      where: 'materialCategory = ? AND locationCity = ? AND priceDate >= ?',
      whereArgs: [category.name, city, cutoff],
      orderBy: 'priceDate ASC',
    );
    return res.map((m) => PriceRecord.fromMap(m)).toList();
  }

  Future<PriceTrend> getPriceTrend(MaterialCategory category, String city) async {
    final db = await _db.database;
    final latest = await getLatestPrice(category, city);
    if (latest == null) return PriceTrend.stable;

    final sevenDaysAgoStr = DateTime.now().subtract(const Duration(days: 7)).toIso8601String();
    final res = await db.query(
      'price_history',
      where: 'materialCategory = ? AND locationCity = ? AND priceDate <= ?',
      whereArgs: [category.name, city, sevenDaysAgoStr],
      orderBy: 'priceDate DESC',
      limit: 1,
    );

    if (res.isEmpty) return PriceTrend.stable;

    final oldPriceRecord = PriceRecord.fromMap(res.first);
    final oldPrice = oldPriceRecord.buyingPricePerKg;
    final currentPrice = latest.buyingPricePerKg;

    if (oldPrice == 0) return PriceTrend.stable;

    double diffPercent = ((currentPrice - oldPrice) / oldPrice) * 100;
    if (diffPercent > 5.0) return PriceTrend.up;
    if (diffPercent < -5.0) return PriceTrend.down;
    
    return PriceTrend.stable;
  }
}
