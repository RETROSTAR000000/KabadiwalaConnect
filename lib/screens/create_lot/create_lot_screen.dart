import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/models/lot.dart';
import 'camera_step.dart';
import 'category_step.dart';
import 'weight_step.dart';
import 'summary_step.dart';

class CreateLotScreen extends StatefulWidget {
  const CreateLotScreen({super.key});

  @override
  State<CreateLotScreen> createState() => _CreateLotScreenState();
}

class _CreateLotScreenState extends State<CreateLotScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  String? imagePath;
  MaterialCategory? selectedCategory;
  double? weight;
  String? condition;
  double? estimatedValue;

  void _nextStep() {
    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newLot),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentStep == index ? Colors.green : Colors.grey,
                ),
              );
            }),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                CameraStep(
                  onImageSelected: (path, category) {
                    setState(() {
                      imagePath = path;
                      if (category != null) {
                        selectedCategory = category;
                      }
                    });
                    _nextStep();
                  },
                ),
                CategoryStep(
                  initialCategory: selectedCategory,
                  onCategorySelected: (cat, cond) {
                    setState(() {
                      selectedCategory = cat;
                      condition = cond;
                    });
                    _nextStep();
                  },
                ),
                WeightStep(
                  onWeightEntered: (w) {
                    setState(() {
                      weight = w;
                    });
                    _nextStep();
                  },
                ),
                SummaryStep(
                  imagePath: imagePath,
                  category: selectedCategory,
                  weight: weight,
                  condition: condition,
                  onSaved: () {
                    // Handled in summary step
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
