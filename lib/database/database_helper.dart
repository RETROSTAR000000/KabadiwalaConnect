import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:kabadiwala_connect/models/collector.dart';
import 'package:kabadiwala_connect/models/lot.dart';
import 'package:kabadiwala_connect/models/recycler.dart';
import 'package:kabadiwala_connect/models/price_record.dart';
import 'package:kabadiwala_connect/models/transaction_record.dart';
import 'package:kabadiwala_connect/models/traceability_record.dart';
import 'package:kabadiwala_connect/models/safety_content.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/database/seed_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'kabadiwala_connect.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE collectors(
        collectorId TEXT PRIMARY KEY,
        preferredLanguage TEXT,
        operatingArea TEXT,
        totalEarnings REAL,
        createdAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE lots(
        lotId TEXT PRIMARY KEY,
        collectorId TEXT,
        materialCategory TEXT,
        materialSubcategory TEXT,
        materialDescription TEXT,
        approximateWeightKg REAL,
        estimatedValue REAL,
        condition TEXT,
        sourceType TEXT,
        imagePath TEXT,
        latitude REAL,
        longitude REAL,
        createdAt TEXT,
        status TEXT,
        syncStatus TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE recyclers(
        recyclerId TEXT PRIMARY KEY,
        facilityName TEXT,
        latitude REAL,
        longitude REAL,
        address TEXT,
        authorizationNumber TEXT,
        authorizationStatus TEXT,
        contactPhone TEXT,
        contactEmail TEXT,
        pickupAvailable INTEGER,
        serviceRadiusKm REAL,
        authorizationExpiry TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE recycler_materials(
        id TEXT PRIMARY KEY,
        recyclerId TEXT,
        materialCategory TEXT,
        offeredRatePerKg REAL,
        rateUpdatedAt TEXT,
        FOREIGN KEY (recyclerId) REFERENCES recyclers(recyclerId)
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        transactionId TEXT PRIMARY KEY,
        lotId TEXT,
        collectorId TEXT,
        recyclerId TEXT,
        quotedPrice REAL,
        finalPrice REAL,
        paymentMethod TEXT,
        paymentStatus TEXT,
        handoverLatitude REAL,
        handoverLongitude REAL,
        handoverTime TEXT,
        handoverReference TEXT,
        recyclerConfirmation TEXT,
        transactionStatus TEXT,
        createdAt TEXT,
        FOREIGN KEY (lotId) REFERENCES lots(lotId)
      )
    ''');

    await db.execute('''
      CREATE TABLE price_history(
        id TEXT PRIMARY KEY,
        materialCategory TEXT,
        materialSubcategory TEXT,
        locationCity TEXT,
        locationState TEXT,
        buyingPricePerKg REAL,
        marketRangeLow REAL,
        marketRangeHigh REAL,
        recyclerOfferedPrice REAL,
        unit TEXT,
        sourceRecyclerId TEXT,
        priceDate TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE traceability_records(
        recordId TEXT PRIMARY KEY,
        lotId TEXT,
        transactionId TEXT,
        handoverReferenceNumber TEXT,
        photographsHash TEXT,
        verifiedWeight REAL,
        timestamp TEXT,
        latitude REAL,
        longitude REAL,
        recyclerConfirmed INTEGER,
        subsequentStatus TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE safety_content(
        contentId TEXT PRIMARY KEY,
        relatedCategory TEXT,
        hazardType TEXT,
        isDangerous INTEGER,
        titleHi TEXT,
        titleMr TEXT,
        titleEn TEXT,
        descriptionHi TEXT,
        descriptionMr TEXT,
        descriptionEn TEXT,
        iconCodePoint INTEGER,
        iconFontFamily TEXT,
        iconFontPackage TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE sync_queue(
        id TEXT PRIMARY KEY,
        entityType TEXT,
        entityId TEXT,
        action TEXT,
        payload TEXT,
        createdAt TEXT,
        status TEXT,
        retryCount INTEGER
      )
    ''');

    // Seed database with initial data
    await SeedData.seedDatabase(this, db);
  }

  // Collector Methods
  Future<void> insertCollector(Collector collector, {Database? db}) async {
    final targetDb = db ?? await database;
    await targetDb.insert('collectors', collector.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Collector?> getCollector(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('collectors', where: 'collectorId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Collector.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateCollector(Collector collector) async {
    final db = await database;
    await db.update('collectors', collector.toMap(), where: 'collectorId = ?', whereArgs: [collector.collectorId]);
  }

  // Lot Methods
  Future<void> insertLot(Lot lot, {Database? db}) async {
    final targetDb = db ?? await database;
    await targetDb.insert('lots', lot.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Lot>> getLots() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('lots', orderBy: 'createdAt DESC');
    return List.generate(maps.length, (i) => Lot.fromMap(maps[i]));
  }

  Future<Lot?> getLotById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('lots', where: 'lotId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Lot.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateLotStatus(String lotId, String status) async {
    final db = await database;
    await db.update('lots', {'status': status}, where: 'lotId = ?', whereArgs: [lotId]);
  }

  // Transaction Methods
  Future<void> insertTransaction(TransactionRecord transaction, {Database? db}) async {
    final targetDb = db ?? await database;
    await targetDb.insert('transactions', transaction.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TransactionRecord>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions', orderBy: 'createdAt DESC');
    return List.generate(maps.length, (i) => TransactionRecord.fromMap(maps[i]));
  }

  Future<List<TransactionRecord>> getTransactionsByCollector(String collectorId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions', where: 'collectorId = ?', whereArgs: [collectorId], orderBy: 'createdAt DESC');
    return List.generate(maps.length, (i) => TransactionRecord.fromMap(maps[i]));
  }

  // Recycler Methods
  Future<void> insertRecycler(Recycler recycler, {Database? db}) async {
    final targetDb = db ?? await database;
    await targetDb.insert('recyclers', recycler.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    if (recycler.acceptedMaterials != null) {
      for (var rm in recycler.acceptedMaterials!) {
        await targetDb.insert('recycler_materials', rm.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  Future<List<Recycler>> getRecyclers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recyclers');
    List<Recycler> recyclers = [];
    for (var map in maps) {
      final List<Map<String, dynamic>> rmMap = await db.query('recycler_materials', where: 'recyclerId = ?', whereArgs: [map['recyclerId']]);
      List<RecyclerMaterial> acceptedMaterials = rmMap.map((rm) => RecyclerMaterial.fromMap(rm)).toList();
      recyclers.add(Recycler.fromMap(map, acceptedMaterials: acceptedMaterials));
    }
    return recyclers;
  }

  Future<Recycler?> getRecyclerById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recyclers', where: 'recyclerId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      final List<Map<String, dynamic>> rmMap = await db.query('recycler_materials', where: 'recyclerId = ?', whereArgs: [id]);
      List<RecyclerMaterial> acceptedMaterials = rmMap.map((rm) => RecyclerMaterial.fromMap(rm)).toList();
      return Recycler.fromMap(maps.first, acceptedMaterials: acceptedMaterials);
    }
    return null;
  }

  Future<List<RecyclerMaterial>> getRecyclerMaterials(String recyclerId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recycler_materials', where: 'recyclerId = ?', whereArgs: [recyclerId]);
    return List.generate(maps.length, (i) => RecyclerMaterial.fromMap(maps[i]));
  }

  // Price Methods
  Future<void> insertPriceRecord(PriceRecord record, {Database? db}) async {
    final targetDb = db ?? await database;
    await targetDb.insert('price_history', record.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PriceRecord>> getPriceHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('price_history', orderBy: 'priceDate DESC');
    return List.generate(maps.length, (i) => PriceRecord.fromMap(maps[i]));
  }

  Future<List<PriceRecord>> getPricesForCategory(MaterialCategory category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('price_history', where: 'materialCategory = ?', whereArgs: [category.name], orderBy: 'priceDate DESC');
    return List.generate(maps.length, (i) => PriceRecord.fromMap(maps[i]));
  }

  Future<List<PriceRecord>> getLatestPrices() async {
    final db = await database;
    // Group by category, city and get the latest (this is a simplified approach, could use custom SQL for exact latest per category)
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT * FROM price_history
      WHERE id IN (
        SELECT id FROM price_history 
        GROUP BY materialCategory
        HAVING max(priceDate)
      )
    ''');
    return List.generate(maps.length, (i) => PriceRecord.fromMap(maps[i]));
  }

  // Traceability Methods
  Future<void> insertTraceabilityRecord(TraceabilityRecord record, {Database? db}) async {
    final targetDb = db ?? await database;
    await targetDb.insert('traceability_records', record.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Safety Content Methods
  Future<void> insertSafetyContent(SafetyContent content, {Database? db}) async {
    final targetDb = db ?? await database;
    await targetDb.insert('safety_content', content.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SafetyContent>> getSafetyContent() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('safety_content');
    return List.generate(maps.length, (i) => SafetyContent.fromMap(maps[i]));
  }
}
