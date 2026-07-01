import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lift_it_up/features/exercises/providers/exercise_providers.dart';
import 'package:lift_it_up/features/exercises/presentation/widgets/exercise_card.dart';
import 'package:lift_it_up/features/exercises/presentation/widgets/skeleton_exercise_card.dart';
import 'package:lift_it_up/features/exercises/presentation/widgets/exercise_search_bar.dart';
import 'package:lift_it_up/features/exercises/presentation/widgets/exercise_filters_bottom_sheet.dart';
import 'package:lift_it_up/features/exercises/presentation/widgets/browsing_sections.dart';

class ExercisesScreen extends ConsumerStatefulWidget {
  const ExercisesScreen({super.key});

  @override
  ConsumerState<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends ConsumerState<ExercisesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(exercisesProvider.notifier).loadMore();
    }
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => const ExerciseFiltersBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Favorites'),
            Tab(text: 'Recent'),
            Tab(text: 'Browse'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllExercisesTab(),
          _buildFavoritesTab(),
          _buildRecentTab(),
          BrowsingSections(tabController: _tabController),
        ],
      ),
    );
  }

  Widget _buildAllExercisesTab() {
    final state = ref.watch(exercisesProvider);

    return Column(
      children: [
        ExerciseSearchBar(onFilterTap: _showFilters),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              ref.read(exercisesProvider.notifier).refresh();
            },
            child: state.exercises.isEmpty && state.isLoading
                ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (_, _) => const SkeletonExerciseCard(),
                  )
                : state.exercises.isEmpty
                    ? _buildEmptyState('No exercises found.')
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: state.exercises.length + (state.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.exercises.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          final exercise = state.exercises[index];
                          return ExerciseCard(
                            exercise: exercise,
                            onTap: () {
                              ref.read(recentlyViewedIdsProvider.notifier).addRecentlyViewed(exercise.id);
                              context.push('/exercises/${exercise.id}');
                            },
                          );
                        },
                      ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesTab() {
    final asyncExercises = ref.watch(favoriteExercisesProvider);

    return asyncExercises.when(
      data: (exercises) {
        if (exercises.isEmpty) return _buildEmptyState('No favorites yet.');
        return ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return ExerciseCard(
              exercise: exercise,
              onTap: () => context.push('/exercises/${exercise.id}'),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildRecentTab() {
    final asyncExercises = ref.watch(recentlyViewedExercisesProvider);

    return asyncExercises.when(
      data: (exercises) {
        if (exercises.isEmpty) return _buildEmptyState('No recently viewed exercises.');
        return ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return ExerciseCard(
              exercise: exercise,
              onTap: () => context.push('/exercises/${exercise.id}'),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fitness_center, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
