import 'dart:math';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/models/recycler.dart';

class RankedRecycler {
  final Recycler recycler;
  final double score;
  final double distanceKm;
  final double? offeredRate;
  // Assume RecyclerMaterial is exported from recycler.dart or models
  final dynamic matchedMaterial; 

  RankedRecycler({
    required this.recycler,
    required this.score,
    required this.distanceKm,
    this.offeredRate,
    this.matchedMaterial,
  });
}

class RecyclerService {
  final DatabaseHelper _db;

  RecyclerService(this._db);

  /// Haversine formula to calculate distance between two coordinates in km
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // Math.PI / 180
    final a = 0.5 - cos((lat2 - lat1) * p) / 2 + 
              cos(lat1 * p) * cos(lat2 * p) * 
              (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  Future<List<RankedRecycler>> findRecyclers(MaterialCategory category, double lat, double lng, {double maxDistanceKm = 50}) async {
    final db = await _db.database;
    final res = await db.query('recyclers');
    final allRecyclers = res.map((m) => Recycler.fromMap(m)).toList();

    List<RankedRecycler> ranked = [];
    double maxRate = 1.0; 

    // Find the max rate across all recyclers for scoring normalization
    for (var r in allRecyclers) {
       var matched = _getMaterial(r, category);
       if (matched != null && matched.offeredRatePerKg > maxRate) {
          maxRate = matched.offeredRatePerKg;
       }
    }

    for (var r in allRecyclers) {
      double dist = calculateDistance(lat, lng, r.latitude, r.longitude);
      if (dist > maxDistanceKm) continue;

      bool isActive = r.authorizationStatus == 'active';
      if (!isActive) continue; // authorization_score filter

      var matched = _getMaterial(r, category);
      
      double distScore = max(0.0, 1.0 - (dist / maxDistanceKm));
      double priceScore = (matched != null && maxRate > 0) ? (matched.offeredRatePerKg / maxRate) : 0.0;
      double matchScore = matched != null ? 1.0 : 0.0;
      double authScore = isActive ? 1.0 : 0.0;
      double pickupScore = r.pickupAvailable ? 1.0 : 0.0;
      double ratingScore = 0.8; // MVP Placeholder

      double finalScore = (distScore * 0.25) +
                          (priceScore * 0.30) +
                          (matchScore * 0.20) +
                          (authScore * 0.10) +
                          (pickupScore * 0.10) +
                          (ratingScore * 0.05);

      ranked.add(RankedRecycler(
        recycler: r,
        score: finalScore,
        distanceKm: dist,
        offeredRate: matched?.offeredRatePerKg,
        matchedMaterial: matched,
      ));
    }

    // Sort descending by score
    ranked.sort((a, b) => b.score.compareTo(a.score));
    return ranked;
  }

  Future<Recycler?> getRecyclerById(String id) async {
    final db = await _db.database;
    final res = await db.query('recyclers', where: 'recyclerId = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      final mats = await db.query('recycler_materials', where: 'recyclerId = ?', whereArgs: [id]);
      final materials = mats.map((m) => RecyclerMaterial.fromMap(m)).toList();
      return Recycler.fromMap(res.first, acceptedMaterials: materials);
    }
    return null;
  }

  /// Helper to safely extract matching material from recycler
  dynamic _getMaterial(Recycler recycler, MaterialCategory category) {
    if (recycler.acceptedMaterials == null) return null;
    for (var m in recycler.acceptedMaterials!) {
      if (m.materialCategory == category) return m;
    }
    return null;
  }
}
