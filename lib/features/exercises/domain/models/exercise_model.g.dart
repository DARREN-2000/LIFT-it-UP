// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    _ExerciseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      primaryMuscles:
          (json['primaryMuscles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MuscleEnumMap, e))
              .toList() ??
          const [],
      secondaryMuscles:
          (json['secondaryMuscles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MuscleEnumMap, e))
              .toList() ??
          const [],
      equipment:
          (json['equipment'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$EquipmentEnumMap, e))
              .toList() ??
          const [],
      difficulty: $enumDecode(_$ExerciseDifficultyEnumMap, json['difficulty']),
      exerciseType: $enumDecode(_$ExerciseTypeEnumMap, json['exerciseType']),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      videoUrl: json['videoUrl'] as String?,
      animationPlaceholder: json['animationPlaceholder'] as String?,
      instructions:
          (json['instructions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      commonMistakes:
          (json['commonMistakes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tips:
          (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      alternatives:
          (json['alternatives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$ExerciseModelToJson(
  _ExerciseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'primaryMuscles': instance.primaryMuscles
      .map((e) => _$MuscleEnumMap[e]!)
      .toList(),
  'secondaryMuscles': instance.secondaryMuscles
      .map((e) => _$MuscleEnumMap[e]!)
      .toList(),
  'equipment': instance.equipment.map((e) => _$EquipmentEnumMap[e]!).toList(),
  'difficulty': _$ExerciseDifficultyEnumMap[instance.difficulty]!,
  'exerciseType': _$ExerciseTypeEnumMap[instance.exerciseType]!,
  'images': instance.images,
  'videoUrl': instance.videoUrl,
  'animationPlaceholder': instance.animationPlaceholder,
  'instructions': instance.instructions,
  'commonMistakes': instance.commonMistakes,
  'tips': instance.tips,
  'alternatives': instance.alternatives,
  'tags': instance.tags,
};

const _$MuscleEnumMap = {
  Muscle.chest: 'chest',
  Muscle.back: 'back',
  Muscle.shoulders: 'shoulders',
  Muscle.biceps: 'biceps',
  Muscle.triceps: 'triceps',
  Muscle.legs: 'legs',
  Muscle.calves: 'calves',
  Muscle.core: 'core',
  Muscle.glutes: 'glutes',
  Muscle.forearms: 'forearms',
  Muscle.neck: 'neck',
  Muscle.cardio: 'cardio',
  Muscle.fullBody: 'fullBody',
};

const _$EquipmentEnumMap = {
  Equipment.barbell: 'barbell',
  Equipment.dumbbell: 'dumbbell',
  Equipment.kettlebell: 'kettlebell',
  Equipment.machine: 'machine',
  Equipment.cable: 'cable',
  Equipment.bodyweight: 'bodyweight',
  Equipment.bands: 'bands',
  Equipment.medicineBall: 'medicineBall',
  Equipment.stabilityBall: 'stabilityBall',
  Equipment.foamRoller: 'foamRoller',
  Equipment.other: 'other',
  Equipment.none: 'none',
};

const _$ExerciseDifficultyEnumMap = {
  ExerciseDifficulty.beginner: 'beginner',
  ExerciseDifficulty.intermediate: 'intermediate',
  ExerciseDifficulty.advanced: 'advanced',
};

const _$ExerciseTypeEnumMap = {
  ExerciseType.strength: 'strength',
  ExerciseType.cardio: 'cardio',
  ExerciseType.stretching: 'stretching',
  ExerciseType.plyometrics: 'plyometrics',
  ExerciseType.strongman: 'strongman',
  ExerciseType.powerlifting: 'powerlifting',
  ExerciseType.olympicWeightlifting: 'olympicWeightlifting',
};
