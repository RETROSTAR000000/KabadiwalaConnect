import 'package:flutter/material.dart';
import 'package:kabadiwala_connect/l10n/app_localizations.dart';
import 'package:kabadiwala_connect/models/material_category.dart';
import 'package:kabadiwala_connect/widgets/material_card.dart';

class CategoryStep extends StatefulWidget {
  final MaterialCategory? initialCategory;
  final Function(MaterialCategory, String) onCategorySelected;

  const CategoryStep({super.key, this.initialCategory, required this.onCategorySelected});

  @override
  State<CategoryStep> createState() => _CategoryStepState();
}

class _CategoryStepState extends State<CategoryStep> {
  MaterialCategory? _selectedCategory;
  String _condition = 'Intact';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(l10n.selectCategory, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: MaterialCategory.values.length,
            itemBuilder: (context, index) {
              final cat = MaterialCategory.values[index];
              final isSelected = _selectedCategory == cat;
              return MaterialCard(
                category: cat,
                selected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedCategory = cat;
                  });
                },
              );
            },
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(l10n.condition ?? 'Condition', style: const TextStyle(fontSize: 20)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildConditionBtn('Intact', Icons.check_circle_outline),
            _buildConditionBtn('Broken', Icons.broken_image),
            _buildConditionBtn('Mixed', Icons.category),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _selectedCategory != null ? () {
            widget.onCategorySelected(_selectedCategory!, _condition);
          } : null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(l10n.next ?? 'Next', style: const TextStyle(fontSize: 20)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildConditionBtn(String cond, IconData icon) {
    final isSelected = _condition == cond;
    return InkWell(
      onTap: () => setState(() => _condition = cond),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(color: isSelected ? Colors.green : Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: isSelected ? Colors.green : Colors.grey),
            const SizedBox(height: 8),
            Text(cond, style: TextStyle(color: isSelected ? Colors.green : Colors.grey, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
