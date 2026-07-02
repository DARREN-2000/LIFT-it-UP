import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lift_it_up/features/exercises/domain/models/exercise_model.dart';
import 'package:lift_it_up/features/exercises/providers/exercise_providers.dart';
import 'package:lift_it_up/core/theme/app_colors.dart';

class ExerciseDetailScreen extends ConsumerWidget {
  final String exerciseId;

  const ExerciseDetailScreen({super.key, required this.exerciseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncExercise = ref.watch(exerciseDetailProvider(exerciseId));
    final favoriteIdsAsync = ref.watch(favoriteExerciseIdsProvider);
    final isFavorite = favoriteIdsAsync.valueOrNull?.contains(exerciseId) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: asyncExercise.when(
          data: (exercise) => Text(exercise?.name ?? 'Exercise Not Found'),
          loading: () => const Text('Loading...'),
          error: (_, _) => const Text('Error'),
        ),
        actions: [
          if (asyncExercise.valueOrNull != null)
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              color: isFavorite ? Colors.red : null,
              onPressed: () {
                ref.read(favoriteExerciseIdsProvider.notifier).toggleFavorite(exerciseId);
              },
            ),
        ],
      ),
      body: asyncExercise.when(
        data: (exercise) {
          if (exercise == null) {
            return const Center(child: Text('Exercise not found.'));
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMediaSection(exercise),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTagsSection(exercise),
                      const SizedBox(height: 16),
                      Text('Description', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(exercise.description),
                      const SizedBox(height: 24),
                      _buildMusclesSection(context, exercise),
                      const SizedBox(height: 24),
                      if (exercise.instructions.isNotEmpty) _buildListSection(context, 'Instructions', exercise.instructions, isNumbered: true),
                      if (exercise.commonMistakes.isNotEmpty) _buildListSection(context, 'Common Mistakes', exercise.commonMistakes),
                      if (exercise.tips.isNotEmpty) _buildListSection(context, 'Tips', exercise.tips),
                      if (exercise.alternatives.isNotEmpty) _buildListSection(context, 'Alternatives', exercise.alternatives),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildMediaSection(ExerciseModel exercise) {
    if (exercise.videoUrl != null && exercise.videoUrl!.isNotEmpty) {
      // Placeholder for actual video player implementation
      return Container(
        height: 250,
        color: Colors.black87,
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_outline, color: Colors.white, size: 64),
            SizedBox(height: 8),
            Text('Video Player Placeholder', style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    } else if (exercise.animationPlaceholder != null) {
        return Container(
        height: 250,
        color: AppColors.surface,
        alignment: Alignment.center,
        child: Image.network(
          exercise.animationPlaceholder!,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
        ),
      );
    } else if (exercise.images.isNotEmpty) {
      return SizedBox(
        height: 250,
        child: PageView.builder(
          itemCount: exercise.images.length,
          itemBuilder: (context, index) {
            return Image.network(
              exercise.images[index],
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const Center(child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey)),
            );
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildTagsSection(ExerciseModel exercise) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildChip(exercise.difficulty.name.toUpperCase(), Colors.blue),
        _buildChip(exercise.exerciseType.name.toUpperCase(), Colors.purple),
        if (exercise.equipment.isNotEmpty) _buildChip(exercise.equipment.first.name.toUpperCase(), Colors.orange),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildMusclesSection(BuildContext context, ExerciseModel exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Muscles Targeted', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        if (exercise.primaryMuscles.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Primary: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(exercise.primaryMuscles.map((m) => m.name).join(', '))),
              ],
            ),
          ),
        if (exercise.secondaryMuscles.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Secondary: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(child: Text(exercise.secondaryMuscles.map((m) => m.name).join(', '))),
            ],
          ),
      ],
    );
  }

  Widget _buildListSection(BuildContext context, String title, List<String> items, {bool isNumbered = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...items.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isNumbered ? '${entry.key + 1}. ' : '• ',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Expanded(
                    child: Text(entry.value, style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
