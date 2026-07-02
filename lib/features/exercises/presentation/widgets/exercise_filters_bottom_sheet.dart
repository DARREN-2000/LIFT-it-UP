import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lift_it_up/features/exercises/domain/models/exercise_model.dart';
import 'package:lift_it_up/features/exercises/providers/exercise_providers.dart';

class ExerciseFiltersBottomSheet extends ConsumerStatefulWidget {
  const ExerciseFiltersBottomSheet({super.key});

  @override
  ConsumerState<ExerciseFiltersBottomSheet> createState() => _ExerciseFiltersBottomSheetState();
}

class _ExerciseFiltersBottomSheetState extends ConsumerState<ExerciseFiltersBottomSheet> {
  late ExerciseFilters _currentFilters;

  @override
  void initState() {
    super.initState();
    _currentFilters = ref.read(exerciseFiltersProvider);
  }

  void _applyFilters() {
    ref.read(exerciseFiltersProvider.notifier).state = _currentFilters;
    Navigator.pop(context);
  }

  void _clearFilters() {
    setState(() {
      _currentFilters = ExerciseFilters(searchQuery: _currentFilters.searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filters', style: Theme.of(context).textTheme.titleLarge),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear All'),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: [
                _buildSectionTitle('Muscle Group'),
                _buildWrapFilter<Muscle>(
                  items: Muscle.values,
                  selectedItems: _currentFilters.muscles,
                  onSelected: (item, selected) {
                    setState(() {
                      if (selected) {
                        _currentFilters = _currentFilters.copyWith(muscles: [..._currentFilters.muscles, item]);
                      } else {
                        _currentFilters = _currentFilters.copyWith(
                            muscles: _currentFilters.muscles.where((m) => m != item).toList());
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Equipment'),
                _buildWrapFilter<Equipment>(
                  items: Equipment.values,
                  selectedItems: _currentFilters.equipment,
                  onSelected: (item, selected) {
                    setState(() {
                      if (selected) {
                        _currentFilters = _currentFilters.copyWith(equipment: [..._currentFilters.equipment, item]);
                      } else {
                        _currentFilters = _currentFilters.copyWith(
                            equipment: _currentFilters.equipment.where((e) => e != item).toList());
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildSectionTitle('Difficulty'),
                _buildWrapFilterSingle<ExerciseDifficulty>(
                  items: ExerciseDifficulty.values,
                  selectedItem: _currentFilters.difficulty,
                  onSelected: (item) {
                    setState(() {
                      if (_currentFilters.difficulty == item) {
                        _currentFilters = _currentFilters.copyWith(clearDifficulty: true);
                      } else {
                        _currentFilters = _currentFilters.copyWith(difficulty: item);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _applyFilters,
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildWrapFilter<T extends Enum>({
    required List<T> items,
    required List<T> selectedItems,
    required Function(T, bool) onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return FilterChip(
          label: Text(item.name),
          selected: isSelected,
          onSelected: (selected) => onSelected(item, selected),
        );
      }).toList(),
    );
  }

  Widget _buildWrapFilterSingle<T extends Enum>({
    required List<T> items,
    required T? selectedItem,
    required Function(T) onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItem == item;
        return ChoiceChip(
          label: Text(item.name),
          selected: isSelected,
          onSelected: (_) => onSelected(item),
        );
      }).toList(),
    );
  }
}
