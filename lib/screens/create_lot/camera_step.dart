import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/services/classification_service.dart';

class CameraStep extends StatefulWidget {
  final Function(String?, MaterialCategory?) onImageSelected;

  const CameraStep({super.key, required this.onImageSelected});

  @override
  State<CameraStep> createState() => _CameraStepState();
}

class _CameraStepState extends State<CameraStep> {
  String? _imagePath;
  MaterialCategory? _suggestedCategory;
  final ImagePicker _picker = ImagePicker();
  final ClassificationService _classifier = ClassificationService();
  bool _isProcessing = false;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
        _isProcessing = true;
      });

      // Mock classification
      final result = await _classifier.classifyMaterial(image.path);
      
      setState(() {
        _suggestedCategory = result.predictedCategory;
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (_imagePath != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.file(File(_imagePath!), fit: BoxFit.cover),
          ),
          if (_isProcessing)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          if (!_isProcessing && _suggestedCategory != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Chip(
                label: Text('Looks like ${_suggestedCategory!.name}?'),
                avatar: const Icon(Icons.check_circle, color: Colors.green),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retakePhoto ?? 'Retake'),
                onPressed: () => setState(() {
                  _imagePath = null;
                  _suggestedCategory = null;
                }),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: Text(l10n.useThisPhoto ?? 'Use This'),
                onPressed: () => widget.onImageSelected(_imagePath!, _suggestedCategory),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 100,
          icon: const Icon(Icons.camera_alt, color: Colors.blue),
          onPressed: () => _pickImage(ImageSource.camera),
        ),
        Text(l10n.takePhoto ?? 'Take Photo', style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          icon: const Icon(Icons.photo_library),
          label: Text(l10n.chooseFromGallery ?? 'Choose from Gallery'),
          onPressed: () => _pickImage(ImageSource.gallery),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => widget.onImageSelected(null, null),
          child: const Text('बिना फ़ोटो आगे बढ़ें / Skip Photo', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
