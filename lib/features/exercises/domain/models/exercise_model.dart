import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_model.freezed.dart';
part 'exercise_model.g.dart';

enum Muscle {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  legs,
  calves,
  core,
  glutes,
  forearms,
  neck,
  cardio,
  fullBody,
}

enum Equipment {
  barbell,
  dumbbell,
  kettlebell,
  machine,
  cable,
  bodyweight,
  bands,
  medicineBall,
  stabilityBall,
  foamRoller,
  other,
  none,
}

enum ExerciseDifficulty {
  beginner,
  intermediate,
  advanced,
}

enum ExerciseType {
  strength,
  cardio,
  stretching,
  plyometrics,
  strongman,
  powerlifting,
  olympicWeightlifting,
}

@freezed
class ExerciseModel with _$ExerciseModel {
  const factory ExerciseModel({
    required String id,
    required String name,
    required String description,
    @Default([]) List<Muscle> primaryMuscles,
    @Default([]) List<Muscle> secondaryMuscles,
    @Default([]) List<Equipment> equipment,
    required ExerciseDifficulty difficulty,
    required ExerciseType exerciseType,
    @Default([]) List<String> images,
    String? videoUrl,
    String? animationPlaceholder,
    @Default([]) List<String> instructions,
    @Default([]) List<String> commonMistakes,
    @Default([]) List<String> tips,
    @Default([]) List<String> alternatives,
    @Default([]) List<String> tags,
  }) = _ExerciseModel;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);
}
