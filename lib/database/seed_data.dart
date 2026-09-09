import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:kabadiwala_connect/database/database_helper.dart';
import 'package:kabadiwala_connect/models/collector.dart';
import 'package:kabadiwala_connect/models/lot.dart';
import 'package:kabadiwala_connect/models/recycler.dart';
import 'package:kabadiwala_connect/models/price_record.dart';
import 'package:kabadiwala_connect/models/transaction_record.dart';
import 'package:kabadiwala_connect/models/safety_content.dart';
import 'package:kabadiwala_connect/models/material_category.dart';

class SeedData {
  static Future<void> seedDatabase(DatabaseHelper dbHelper, [Database? db]) async {
    final targetDb = db ?? await dbHelper.database;
    var uuid = const Uuid();
    final now = DateTime.now();

    // 1. Seed Collector
    final defaultCollector = Collector(
      collectorId: 'collector-001',
      preferredLanguage: 'hi',
      operatingArea: 'Mumbai',
      totalEarnings: 4500.0,
      createdAt: now.subtract(const Duration(days: 30)),
    );
    await dbHelper.insertCollector(defaultCollector, db: db);

    // 2. Seed Recyclers
    final recyclers = [
      Recycler(
        recyclerId: uuid.v4(),
        facilityName: 'EcoRecycle Mumbai',
        latitude: 19.0760,
        longitude: 72.8777,
        address: 'Kurla West, Mumbai',
        authorizationNumber: 'MPCB-EWASTE-1001',
        authorizationStatus: 'active',
        contactPhone: '9876543210',
        pickupAvailable: true,
        serviceRadiusKm: 50.0,
        authorizationExpiry: now.add(const Duration(days: 365)),
        acceptedMaterials: [],
      ),
      Recycler(
        recyclerId: uuid.v4(),
        facilityName: 'GreenEarth Pune',
        latitude: 18.5204,
        longitude: 73.8567,
        address: 'Hinjewadi, Pune',
        authorizationNumber: 'MPCB-EWASTE-1002',
        authorizationStatus: 'active',
        contactPhone: '9876543211',
        pickupAvailable: true,
        serviceRadiusKm: 40.0,
        authorizationExpiry: now.add(const Duration(days: 180)),
        acceptedMaterials: [],
      ),
      Recycler(
        recyclerId: uuid.v4(),
        facilityName: 'Delhi E-Waste Mgmt',
        latitude: 28.7041,
        longitude: 77.1025,
        address: 'Okhla Industrial Area, Delhi',
        authorizationNumber: 'DPCC-EWASTE-2001',
        authorizationStatus: 'active',
        contactPhone: '9876543212',
        pickupAvailable: true,
        serviceRadiusKm: 100.0,
        authorizationExpiry: now.add(const Duration(days: 300)),
        acceptedMaterials: [],
      ),
      Recycler(
        recyclerId: uuid.v4(),
        facilityName: 'TechScrap Bangalore',
        latitude: 12.9716,
        longitude: 77.5946,
        address: 'Peenya, Bangalore',
        authorizationNumber: 'KSPCB-EWASTE-3001',
        authorizationStatus: 'active',
        contactPhone: '9876543213',
        pickupAvailable: false,
        serviceRadiusKm: 20.0,
        authorizationExpiry: now.add(const Duration(days: 120)),
        acceptedMaterials: [],
      ),
      Recycler(
        recyclerId: uuid.v4(),
        facilityName: 'Kolkata Recyclers',
        latitude: 22.5726,
        longitude: 88.3639,
        address: 'Salt Lake, Kolkata',
        authorizationNumber: 'WBPCB-EWASTE-4001',
        authorizationStatus: 'active',
        contactPhone: '9876543214',
        pickupAvailable: true,
        serviceRadiusKm: 60.0,
        authorizationExpiry: now.add(const Duration(days: 200)),
        acceptedMaterials: [],
      ),
    ];

    for (var r in recyclers) {
      await dbHelper.insertRecycler(r, db: db);
      // Insert RecyclerMaterials
      final rates = {
        MaterialCategory.pcb: 250.0,
        MaterialCategory.crt: 12.0,
        MaterialCategory.lcd: 35.0,
        MaterialCategory.cable: 400.0,
        MaterialCategory.battery: 100.0,
        MaterialCategory.motor: 60.0,
        MaterialCategory.mixedPlastic: 15.0,
      };
      for (var entry in rates.entries) {
        await targetDb.insert(
            'recycler_materials',
            RecyclerMaterial(
              id: uuid.v4(),
              recyclerId: r.recyclerId,
              materialCategory: entry.key,
              offeredRatePerKg: entry.value,
              rateUpdatedAt: now,
            ).toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    // 3. Seed Price History
    final cities = ['Mumbai', 'Pune', 'Delhi', 'Bangalore', 'Kolkata'];
    final basePrices = {
      MaterialCategory.pcb: 200.0,
      MaterialCategory.crt: 10.0,
      MaterialCategory.lcd: 30.0,
      MaterialCategory.cable: 400.0,
      MaterialCategory.battery: 80.0,
      MaterialCategory.motor: 50.0,
      MaterialCategory.mixedPlastic: 15.0,
    };

    for (var category in MaterialCategory.values) {
      for (var city in cities) {
        // Create 2 price records per category/city for some history
        for (int i = 0; i < 2; i++) {
          double basePrice = basePrices[category]!;
          double price = basePrice + (city.length * i) - 5; // Slight variation
          await dbHelper.insertPriceRecord(
            PriceRecord(
              id: uuid.v4(),
              materialCategory: category,
              locationCity: city,
              buyingPricePerKg: price,
              marketRangeLow: price - 10,
              marketRangeHigh: price + 20,
              unit: 'INR/kg',
              priceDate: now.subtract(Duration(days: i * 7)),
            ),
            db: db,
          );
        }
      }
    }

    // 4. Seed Safety Content
    final safetyItems = [
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'burning',
        isDangerous: true,
        titleHi: 'तारों को न जलाएं',
        titleMr: 'केबल्स जाळू नका',
        titleEn: 'Do NOT burn cables',
        descriptionHi: 'तारों को जलाने से जहरीला धुआं निकलता है जो फेफड़ों को नुकसान पहुंचाता है।',
        descriptionMr: 'केबल जाळल्याने विषारी धूर बाहेर पडतो ज्यामुळे फुफ्फुसांना हानी पोहोचते.',
        descriptionEn: 'Burning cables releases toxic fumes that damage lungs.',
        icon: Icons.fireplace,
        relatedCategory: MaterialCategory.cable,
      ),
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'battery_puncture',
        isDangerous: true,
        titleHi: 'बैटरी को न तोड़ें',
        titleMr: 'बॅटरी फोडू नका',
        titleEn: 'Do NOT break batteries',
        descriptionHi: 'लीथियम-आयन बैटरी को तोड़ने से आग लग सकती है।',
        descriptionMr: 'लिथियम-आयन बॅटरी फोडल्यास आग लागू शकते.',
        descriptionEn: 'Breaking Li-ion batteries can cause severe fires.',
        icon: Icons.battery_alert,
        relatedCategory: MaterialCategory.battery,
      ),
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'crt_breaking',
        isDangerous: true,
        titleHi: 'CRT मॉनिटर न तोड़ें',
        titleMr: 'CRT मॉनिटर फोडू नका',
        titleEn: 'Do NOT break CRT monitors',
        descriptionHi: 'CRT में जहरीला सीसा (Lead) होता है। इसे साबुत बेचें।',
        descriptionMr: 'CRT मध्ये विषारी शिसे (Lead) असते. ते पूर्णपणे विका.',
        descriptionEn: 'CRT contains toxic lead. Sell intact.',
        icon: Icons.tv_off,
        relatedCategory: MaterialCategory.crt,
      ),
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'acid',
        isDangerous: true,
        titleHi: 'एसिड से सावधान',
        titleMr: 'ऍसिडपासून सावधगिरी बाळगा',
        titleEn: 'Beware of Acid',
        descriptionHi: 'पीसीबी और बैटरी से निकलने वाला तरल त्वचा जला सकता है।',
        descriptionMr: 'PCB आणि बॅटरीतून गळणारा द्रव त्वचा जाळू शकतो.',
        descriptionEn: 'Liquids from PCBs and batteries can cause severe skin burns.',
        icon: Icons.science,
      ),
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'general',
        isDangerous: false,
        titleHi: 'दस्ताने पहनें',
        titleMr: 'हातमोजे घाला',
        titleEn: 'Wear Gloves',
        descriptionHi: 'ई-कचरा संभालते समय हमेशा दस्ताने पहनें।',
        descriptionMr: 'ई-कचरा हाताळताना नेहमी हातमोजे घाला.',
        descriptionEn: 'Always wear gloves when handling e-waste.',
        icon: Icons.pan_tool,
      ),
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'general',
        isDangerous: false,
        titleHi: 'हाथ धोएं',
        titleMr: 'हात धुवा',
        titleEn: 'Wash Hands',
        descriptionHi: 'काम के बाद साबुन से हाथ अच्छी तरह धोएं।',
        descriptionMr: 'कामानंतर साबणाने हात चांगले धुवा.',
        descriptionEn: 'Wash hands thoroughly with soap after work.',
        icon: Icons.clean_hands,
      ),
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'general',
        isDangerous: false,
        titleHi: 'छाया में रखें',
        titleMr: 'सावलीत ठेवा',
        titleEn: 'Store in Shade',
        descriptionHi: 'ई-कचरा (खासकर बैटरी) को धूप से बचाएं।',
        descriptionMr: 'ई-कचरा (विशेषत: बॅटरी) उन्हापासून वाचवा.',
        descriptionEn: 'Keep e-waste (especially batteries) away from direct sunlight.',
        icon: Icons.wb_shade,
      ),
      SafetyContent(
        contentId: uuid.v4(),
        hazardType: 'general',
        isDangerous: false,
        titleHi: 'अलग-अलग रखें',
        titleMr: 'वेगळे ठेवा',
        titleEn: 'Keep Separated',
        descriptionHi: 'अलग-अलग प्रकार के कचरे को अलग रखें, इससे ज्यादा पैसे मिलेंगे।',
        descriptionMr: 'वेगवेगळ्या प्रकारचा कचरा वेगळा ठेवा, यामुळे जास्त पैसे मिळतील.',
        descriptionEn: 'Sort different types of waste to get better prices.',
        icon: Icons.category,
      ),
    ];

    for (var item in safetyItems) {
      await dbHelper.insertSafetyContent(item, db: db);
    }

    // 5. Seed Lots and Transactions
    final lots = [
      Lot(
        lotId: uuid.v4(),
        collectorId: defaultCollector.collectorId,
        materialCategory: MaterialCategory.pcb,
        approximateWeightKg: 5.5,
        estimatedValue: 1200.0,
        condition: 'intact',
        createdAt: now.subtract(const Duration(days: 5)),
        status: 'handed_over',
        syncStatus: 'synced',
      ),
      Lot(
        lotId: uuid.v4(),
        collectorId: defaultCollector.collectorId,
        materialCategory: MaterialCategory.cable,
        approximateWeightKg: 10.0,
        estimatedValue: 3500.0,
        condition: 'mixed',
        createdAt: now.subtract(const Duration(days: 10)),
        status: 'handed_over',
        syncStatus: 'synced',
      ),
      Lot(
        lotId: uuid.v4(),
        collectorId: defaultCollector.collectorId,
        materialCategory: MaterialCategory.lcd,
        approximateWeightKg: 15.0,
        estimatedValue: 450.0,
        condition: 'broken',
        createdAt: now.subtract(const Duration(days: 1)),
        status: 'created',
        syncStatus: 'pending_sync',
      ),
    ];

    for (int i = 0; i < lots.length; i++) {
      await dbHelper.insertLot(lots[i], db: db);

      if (lots[i].status == 'handed_over') {
        final tx = TransactionRecord(
          transactionId: uuid.v4(),
          lotId: lots[i].lotId,
          collectorId: defaultCollector.collectorId,
          recyclerId: recyclers[0].recyclerId,
          quotedPrice: lots[i].estimatedValue,
          finalPrice: lots[i].estimatedValue,
          paymentMethod: 'cash',
          paymentStatus: 'paid',
          handoverTime: lots[i].createdAt.add(const Duration(days: 1)),
          handoverReference: 'KWC-2026-0909-${i}A7B3',
          transactionStatus: 'paid',
          createdAt: lots[i].createdAt,
        );
        await dbHelper.insertTransaction(tx, db: db);
      }
    }
  }
}
