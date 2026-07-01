import 'package:flutter/material.dart';
import 'package:lift_it_up/features/exercises/domain/models/exercise_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lift_it_up/features/exercises/providers/exercise_providers.dart';

class BrowsingSections extends ConsumerWidget {
  final TabController tabController;

  const BrowsingSections({super.key, required this.tabController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('By Muscle Group'),
          _buildGrid(
            context: context,
            items: Muscle.values.map((e) => e.name).toList(),
            onTap: (name) {
              final muscle = Muscle.values.firstWhere((e) => e.name == name);
              ref.read(exerciseFiltersProvider.notifier).update(
                  (state) => ExerciseFilters(muscles: [muscle]));
              tabController.animateTo(0); // Switch to 'All' tab
            },
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('By Equipment'),
          _buildGrid(
            context: context,
            items: Equipment.values.map((e) => e.name).toList(),
            onTap: (name) {
              final equipment = Equipment.values.firstWhere((e) => e.name == name);
              ref.read(exerciseFiltersProvider.notifier).update(
                  (state) => ExerciseFilters(equipment: [equipment]));
              tabController.animateTo(0);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGrid({
    required BuildContext context,
    required List<String> items,
    required Function(String) onTap,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => onTap(items[index]),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
            ),
            child: Text(
              items[index].toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
