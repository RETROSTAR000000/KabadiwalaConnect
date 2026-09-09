import 'dart:math';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/models/lot.dart';
// Note: Relative import or package import based on your setup.
import 'package:kabadiwala_connect/services/price_service.dart';

class LotService {
  final DatabaseHelper _db;
  final PriceService _priceService;

  LotService(this._db, this._priceService);

  String _generateUuid() {
    return '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(999999)}';
  }

  Future<Lot> createLot({
    required MaterialCategory category,
    required double weight,
    required String condition,
    String? imagePath,
    double lat = 19.0760,
    double lng = 72.8777,
    String collectorId = 'coll_123',
    String city = 'Mumbai',
  }) async {
    // Auto-estimate the value using PriceService
    final est = await _priceService.estimateValue(category, weight, condition, city);
    
    final lot = Lot(
      lotId: _generateUuid(),
      collectorId: collectorId,
      materialCategory: category,
      materialSubcategory: 'Mixed',
      materialDescription: 'Collected lot',
      approximateWeightKg: weight,
      estimatedValue: est.estimatedValue,
      condition: condition,
      sourceType: 'general',
      imagePath: imagePath,
      latitude: lat,
      longitude: lng,
      createdAt: DateTime.now(),
      status: 'pending',
      syncStatus: 'pending_sync',
    );

    final db = await _db.database;
    await db.insert('lots', lot.toMap());
    return lot;
  }

  Future<List<Lot>> getLots(String collectorId) async {
    final db = await _db.database;
    final res = await db.query('lots', where: 'collectorId = ?', whereArgs: [collectorId]);
    return res.map((m) => Lot.fromMap(m)).toList();
  }

  Future<Lot?> getLotById(String id) async {
    final db = await _db.database;
    final res = await db.query('lots', where: 'lotId = ?', whereArgs: [id]);
    if (res.isNotEmpty) return Lot.fromMap(res.first);
    return null;
  }

  Future<void> updateLotStatus(String id, String status) async {
    final db = await _db.database;
    await db.update('lots', {'status': status}, where: 'lotId = ?', whereArgs: [id]);
  }

  Future<void> deleteLot(String id) async {
    final db = await _db.database;
    await db.delete('lots', where: 'lotId = ?', whereArgs: [id]);
  }

  Future<List<Lot>> getRecentLots(String collectorId, {int limit = 5}) async {
    final db = await _db.database;
    final res = await db.query(
      'lots',
      where: 'collectorId = ?',
      whereArgs: [collectorId],
      orderBy: 'createdAt DESC',
      limit: limit,
    );
    return res.map((m) => Lot.fromMap(m)).toList();
  }
}
