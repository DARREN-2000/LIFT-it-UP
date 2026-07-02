import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lift_it_up/features/exercises/domain/models/exercise_model.dart';
import 'package:lift_it_up/features/exercises/domain/repositories/exercise_repository.dart';
import 'package:lift_it_up/features/exercises/data/repositories/firestore_exercise_repository.dart';
import 'package:lift_it_up/features/exercises/data/repositories/user_exercise_data_repository.dart';
import 'package:lift_it_up/features/auth/providers/auth_providers.dart';

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return FirestoreExerciseRepository(FirebaseFirestore.instance);
});

final userExerciseDataRepositoryProvider = Provider<UserExerciseDataRepository>((ref) {
  return UserExerciseDataRepository(FirebaseFirestore.instance);
});

// Filters
class ExerciseFilters {
  final String searchQuery;
  final List<Muscle> muscles;
  final List<Equipment> equipment;
  final ExerciseDifficulty? difficulty;
  final ExerciseType? type;

  ExerciseFilters({
    this.searchQuery = '',
    this.muscles = const [],
    this.equipment = const [],
    this.difficulty,
    this.type,
  });

  ExerciseFilters copyWith({
    String? searchQuery,
    List<Muscle>? muscles,
    List<Equipment>? equipment,
    ExerciseDifficulty? difficulty,
    ExerciseType? type,
    bool clearDifficulty = false,
    bool clearType = false,
  }) {
    return ExerciseFilters(
      searchQuery: searchQuery ?? this.searchQuery,
      muscles: muscles ?? this.muscles,
      equipment: equipment ?? this.equipment,
      difficulty: clearDifficulty ? null : (difficulty ?? this.difficulty),
      type: clearType ? null : (type ?? this.type),
    );
  }
}

final exerciseFiltersProvider = StateProvider<ExerciseFilters>((ref) {
  return ExerciseFilters();
});

// Main Exercises List Provider (Supports Pagination and Filtering)
class ExercisesState {
  final List<ExerciseModel> exercises;
  final bool isLoading;
  final String? error;
  final bool hasReachedMax;

  ExercisesState({
    this.exercises = const [],
    this.isLoading = false,
    this.error,
    this.hasReachedMax = false,
  });

  ExercisesState copyWith({
    List<ExerciseModel>? exercises,
    bool? isLoading,
    String? error,
    bool? hasReachedMax,
  }) {
    return ExercisesState(
      exercises: exercises ?? this.exercises,
      isLoading: isLoading ?? this.isLoading,
      error: error, // Can be null to clear
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ExercisesNotifier extends StateNotifier<ExercisesState> {
  final ExerciseRepository _repository;
  final Ref _ref;

  ExercisesNotifier(this._repository, this._ref) : super(ExercisesState()) {
    _ref.listen<ExerciseFilters>(exerciseFiltersProvider, (previous, next) {
      if (previous != next) {
        _fetchExercises(isRefresh: true);
      }
    });
    _fetchExercises(isRefresh: true);
  }

  Future<void> _fetchExercises({bool isRefresh = false}) async {
    if (state.isLoading) return;
    if (!isRefresh && state.hasReachedMax) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final filters = _ref.read(exerciseFiltersProvider);
      final startAfterId = isRefresh || state.exercises.isEmpty ? null : state.exercises.last.id;
      final limit = 20;

      final newExercises = await _repository.getExercises(
        limit: limit,
        startAfterId: startAfterId,
        searchQuery: filters.searchQuery,
        muscles: filters.muscles,
        equipment: filters.equipment,
        difficulty: filters.difficulty,
        type: filters.type,
      );

      if (isRefresh) {
        state = state.copyWith(
          exercises: newExercises,
          isLoading: false,
          hasReachedMax: newExercises.length < limit,
        );
      } else {
        state = state.copyWith(
          exercises: [...state.exercises, ...newExercises],
          isLoading: false,
          hasReachedMax: newExercises.length < limit,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void loadMore() {
    _fetchExercises();
  }

  void refresh() {
      _fetchExercises(isRefresh: true);
  }
}

final exercisesProvider = StateNotifierProvider<ExercisesNotifier, ExercisesState>((ref) {
  final repository = ref.watch(exerciseRepositoryProvider);
  return ExercisesNotifier(repository, ref);
});

// Single Exercise Detail Provider
final exerciseDetailProvider = FutureProvider.family<ExerciseModel?, String>((ref, id) async {
  final repository = ref.watch(exerciseRepositoryProvider);
  return repository.getExerciseById(id);
});

// Favorites Provider
class FavoritesNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final UserExerciseDataRepository _repository;
  final String _userId;

  FavoritesNotifier(this._repository, this._userId) : super(const AsyncLoading()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final ids = await _repository.getFavoriteExerciseIds(_userId);
      state = AsyncData(ids);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleFavorite(String exerciseId) async {
    final currentList = state.valueOrNull ?? [];
    final isCurrentlyFavorite = currentList.contains(exerciseId);

    // Optimistic update
    final newList = List<String>.from(currentList);
    if (isCurrentlyFavorite) {
      newList.remove(exerciseId);
    } else {
      newList.add(exerciseId);
    }
    state = AsyncData(newList);

    try {
      await _repository.toggleFavoriteExercise(_userId, exerciseId, !isCurrentlyFavorite);
    } catch (e) {
      // Revert on error
      state = AsyncData(currentList);
      // Ideally show an error message
    }
  }
}

final favoriteExerciseIdsProvider = StateNotifierProvider<FavoritesNotifier, AsyncValue<List<String>>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return FavoritesNotifier(ref.watch(userExerciseDataRepositoryProvider), ''); // Dummy or empty state
  }
  return FavoritesNotifier(ref.watch(userExerciseDataRepositoryProvider), user.uid);
});

final favoriteExercisesProvider = FutureProvider<List<ExerciseModel>>((ref) async {
  final favoriteIdsAsync = ref.watch(favoriteExerciseIdsProvider);
  final ids = favoriteIdsAsync.valueOrNull ?? [];
  if (ids.isEmpty) return [];

  final repository = ref.watch(exerciseRepositoryProvider);
  return repository.getExercisesByIds(ids);
});

// Recently Viewed Provider
class RecentlyViewedNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final UserExerciseDataRepository _repository;
  final String _userId;

  RecentlyViewedNotifier(this._repository, this._userId) : super(const AsyncLoading()) {
    _loadRecentlyViewed();
  }

  Future<void> _loadRecentlyViewed() async {
    try {
      final ids = await _repository.getRecentlyViewedExerciseIds(_userId);
      state = AsyncData(ids);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addRecentlyViewed(String exerciseId) async {
    final currentList = state.valueOrNull ?? [];

    // Optimistic update
    final newList = List<String>.from(currentList);
    newList.remove(exerciseId);
    newList.insert(0, exerciseId);
    if (newList.length > 20) {
        newList.removeLast();
    }

    state = AsyncData(newList);

    try {
      await _repository.addRecentlyViewedExercise(_userId, exerciseId);
    } catch (e) {
      // Revert on error
      state = AsyncData(currentList);
    }
  }
}

final recentlyViewedIdsProvider = StateNotifierProvider<RecentlyViewedNotifier, AsyncValue<List<String>>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    return RecentlyViewedNotifier(ref.watch(userExerciseDataRepositoryProvider), '');
  }
  return RecentlyViewedNotifier(ref.watch(userExerciseDataRepositoryProvider), user.uid);
});

final recentlyViewedExercisesProvider = FutureProvider<List<ExerciseModel>>((ref) async {
  final recentIdsAsync = ref.watch(recentlyViewedIdsProvider);
  final ids = recentIdsAsync.valueOrNull ?? [];
  if (ids.isEmpty) return [];

  final repository = ref.watch(exerciseRepositoryProvider);
  return repository.getExercisesByIds(ids);
});
