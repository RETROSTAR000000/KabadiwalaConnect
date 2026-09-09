import 'dart:math';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/models/transaction_record.dart';
import 'package:kabadiwala_connect/models/traceability_record.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class EarningsSummary {
  final double totalEarnings;
  final double pendingDues;
  final int completedCount;
  final int pendingCount;

  EarningsSummary({
    required this.totalEarnings,
    required this.pendingDues,
    required this.completedCount,
    required this.pendingCount,
  });
}

class TransactionService {
  final DatabaseHelper _db;

  TransactionService(this._db);

  String generateHandoverReference() {
    final now = DateTime.now();
    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final rand = Random().nextInt(0xFFFF).toRadixString(16).toUpperCase().padLeft(4, '0');
    return 'KWC-$year-$month$day-$rand';
  }

  Future<TransactionRecord> createTransaction(
    String lotId,
    String collectorId,
    String recyclerId,
    double quotedPrice, {
    MaterialCategory? materialCategory,
    double? weight,
  }) async {
    final db = await _db.database;
    final id = '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(99999)}';
    
    final tr = TransactionRecord(
      transactionId: id,
      lotId: lotId,
      collectorId: collectorId,
      recyclerId: recyclerId,
      quotedPrice: quotedPrice,
      paymentStatus: 'pending',
      transactionStatus: 'initiated',
      createdAt: DateTime.now(),
      materialCategory: materialCategory,
      weight: weight,
      handoverReference: generateHandoverReference(),
    );

    await db.insert('transactions', tr.toMap());
    return tr;
  }

  Future<TransactionRecord> updateTransaction(String transactionId, Map<String, dynamic> fields) async {
    final db = await _db.database;
    await db.update('transactions', fields, where: 'transactionId = ?', whereArgs: [transactionId]);
    final updated = await getTransactionById(transactionId);
    return updated!;
  }

  Future<Map<String, dynamic>> completeHandover(String transactionId, double lat, double lng, String photoPath) async {
    final db = await _db.database;
    
    final ref = generateHandoverReference();
    await updateTransaction(transactionId, {
      'status': 'handed_over',
      'handoverRef': ref,
      'handoverDate': DateTime.now().toIso8601String()
    });

    final traceId = '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(99999)}';
    final trace = TraceabilityRecord(
      recordId: traceId,
      transactionId: transactionId,
      lotId: 'default',
      handoverReferenceNumber: ref,
      verifiedWeight: 0.0,
      recyclerConfirmed: false,
      subsequentStatus: 'pending',
      timestamp: DateTime.now(),
    );
    await db.insert('traceability_records', trace.toMap());

    final tx = await getTransactionById(transactionId);
    return {'transaction': tx, 'traceability': trace};
  }

  Future<TransactionRecord> confirmPayment(String transactionId, double finalPrice, String paymentMethod) async {
    return await updateTransaction(transactionId, {
      'status': 'completed',
      'finalPrice': finalPrice,
      'paymentMethod': paymentMethod,
      'paymentDate': DateTime.now().toIso8601String(),
    });
  }

  Future<List<TransactionRecord>> getTransactionsByCollector(String collectorId) async {
    final db = await _db.database;
    final res = await db.query('transactions', where: 'collectorId = ?', whereArgs: [collectorId]);
    return res.map((m) => TransactionRecord.fromMap(m)).toList();
  }

  Future<TransactionRecord?> getTransactionById(String id) async {
    final db = await _db.database;
    final res = await db.query('transactions', where: 'transactionId = ?', whereArgs: [id]);
    if (res.isNotEmpty) return TransactionRecord.fromMap(res.first);
    return null;
  }

  Future<EarningsSummary> getEarningsSummary(String collectorId) async {
    final txs = await getTransactionsByCollector(collectorId);
    double total = 0.0;
    double pending = 0.0;
    int compCount = 0;
    int pendCount = 0;

    for (var t in txs) {
      if (t.transactionStatus == 'completed') {
        total += (t.finalPrice ?? t.quotedPrice ?? 0.0);
        compCount++;
      } else {
        pending += (t.quotedPrice ?? 0.0);
        pendCount++;
      }
    }

    return EarningsSummary(
      totalEarnings: total,
      pendingDues: pending,
      completedCount: compCount,
      pendingCount: pendCount,
    );
  }
}
