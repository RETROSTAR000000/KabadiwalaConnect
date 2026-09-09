import 'dart:math';
import 'package:kabadiwala_connect/models/material_category.dart';

class CategoryScore {
  final MaterialCategory category;
  final double score;

  CategoryScore({required this.category, required this.score});
}

class ClassificationResult {
  final MaterialCategory predictedCategory;
  final double confidence;
  final List<CategoryScore> allScores;

  ClassificationResult({
    required this.predictedCategory,
    required this.confidence,
    required this.allScores,
  });
}

class ClassificationService {
  // TODO: Add `import 'package:tflite_flutter/tflite_flutter.dart';`
  // TODO: Initialize TFLite interpreter and run inference here.
  
  Future<ClassificationResult> classifyMaterial(String imagePath) async {
    // MVP Heuristic: Randomly classify with a simulated inference delay
    await Future.delayed(const Duration(milliseconds: 800));

    final random = Random();
    final categories = MaterialCategory.values;
    final predicted = categories[random.nextInt(categories.length)];
    final confidence = 0.6 + random.nextDouble() * 0.3; // 0.6 to 0.9

    List<CategoryScore> scores = [];
    double remaining = 1.0 - confidence;
    
    for (var cat in categories) {
      if (cat == predicted) {
        scores.add(CategoryScore(category: cat, score: confidence));
      } else {
        // Distribute remaining randomly
        double score = remaining / (categories.length - 1);
        scores.add(CategoryScore(category: cat, score: score));
      }
    }

    scores.sort((a, b) => b.score.compareTo(a.score));

    return ClassificationResult(
      predictedCategory: predicted,
      confidence: confidence,
      allScores: scores,
    );
  }
}
