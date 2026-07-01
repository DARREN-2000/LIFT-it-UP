import 'package:lift_it_up/features/exercises/domain/models/exercise_model.dart';

abstract class ExerciseRepository {
  Future<List<ExerciseModel>> getExercises({
    int limit = 20,
    String? startAfterId,
    String? searchQuery,
    List<Muscle>? muscles,
    List<Equipment>? equipment,
    ExerciseDifficulty? difficulty,
    ExerciseType? type,
  });

  Future<ExerciseModel?> getExerciseById(String id);

  Future<List<ExerciseModel>> getExercisesByIds(List<String> ids);
}
