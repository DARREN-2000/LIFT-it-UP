// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseModel {

 String get id; String get name; String get description; List<Muscle> get primaryMuscles; List<Muscle> get secondaryMuscles; List<Equipment> get equipment; ExerciseDifficulty get difficulty; ExerciseType get exerciseType; List<String> get images; String? get videoUrl; String? get animationPlaceholder; List<String> get instructions; List<String> get commonMistakes; List<String> get tips; List<String> get alternatives; List<String> get tags;
/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseModelCopyWith<ExerciseModel> get copyWith => _$ExerciseModelCopyWithImpl<ExerciseModel>(this as ExerciseModel, _$identity);

  /// Serializes this ExerciseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.primaryMuscles, primaryMuscles)&&const DeepCollectionEquality().equals(other.secondaryMuscles, secondaryMuscles)&&const DeepCollectionEquality().equals(other.equipment, equipment)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.exerciseType, exerciseType) || other.exerciseType == exerciseType)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.animationPlaceholder, animationPlaceholder) || other.animationPlaceholder == animationPlaceholder)&&const DeepCollectionEquality().equals(other.instructions, instructions)&&const DeepCollectionEquality().equals(other.commonMistakes, commonMistakes)&&const DeepCollectionEquality().equals(other.tips, tips)&&const DeepCollectionEquality().equals(other.alternatives, alternatives)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(primaryMuscles),const DeepCollectionEquality().hash(secondaryMuscles),const DeepCollectionEquality().hash(equipment),difficulty,exerciseType,const DeepCollectionEquality().hash(images),videoUrl,animationPlaceholder,const DeepCollectionEquality().hash(instructions),const DeepCollectionEquality().hash(commonMistakes),const DeepCollectionEquality().hash(tips),const DeepCollectionEquality().hash(alternatives),const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'ExerciseModel(id: $id, name: $name, description: $description, primaryMuscles: $primaryMuscles, secondaryMuscles: $secondaryMuscles, equipment: $equipment, difficulty: $difficulty, exerciseType: $exerciseType, images: $images, videoUrl: $videoUrl, animationPlaceholder: $animationPlaceholder, instructions: $instructions, commonMistakes: $commonMistakes, tips: $tips, alternatives: $alternatives, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $ExerciseModelCopyWith<$Res>  {
  factory $ExerciseModelCopyWith(ExerciseModel value, $Res Function(ExerciseModel) _then) = _$ExerciseModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, List<Muscle> primaryMuscles, List<Muscle> secondaryMuscles, List<Equipment> equipment, ExerciseDifficulty difficulty, ExerciseType exerciseType, List<String> images, String? videoUrl, String? animationPlaceholder, List<String> instructions, List<String> commonMistakes, List<String> tips, List<String> alternatives, List<String> tags
});




}
/// @nodoc
class _$ExerciseModelCopyWithImpl<$Res>
    implements $ExerciseModelCopyWith<$Res> {
  _$ExerciseModelCopyWithImpl(this._self, this._then);

  final ExerciseModel _self;
  final $Res Function(ExerciseModel) _then;

/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? primaryMuscles = null,Object? secondaryMuscles = null,Object? equipment = null,Object? difficulty = null,Object? exerciseType = null,Object? images = null,Object? videoUrl = freezed,Object? animationPlaceholder = freezed,Object? instructions = null,Object? commonMistakes = null,Object? tips = null,Object? alternatives = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,primaryMuscles: null == primaryMuscles ? _self.primaryMuscles : primaryMuscles // ignore: cast_nullable_to_non_nullable
as List<Muscle>,secondaryMuscles: null == secondaryMuscles ? _self.secondaryMuscles : secondaryMuscles // ignore: cast_nullable_to_non_nullable
as List<Muscle>,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<Equipment>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as ExerciseDifficulty,exerciseType: null == exerciseType ? _self.exerciseType : exerciseType // ignore: cast_nullable_to_non_nullable
as ExerciseType,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,animationPlaceholder: freezed == animationPlaceholder ? _self.animationPlaceholder : animationPlaceholder // ignore: cast_nullable_to_non_nullable
as String?,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<String>,commonMistakes: null == commonMistakes ? _self.commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as List<String>,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,alternatives: null == alternatives ? _self.alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseModel].
extension ExerciseModelPatterns on ExerciseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseModel value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  List<Muscle> primaryMuscles,  List<Muscle> secondaryMuscles,  List<Equipment> equipment,  ExerciseDifficulty difficulty,  ExerciseType exerciseType,  List<String> images,  String? videoUrl,  String? animationPlaceholder,  List<String> instructions,  List<String> commonMistakes,  List<String> tips,  List<String> alternatives,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.primaryMuscles,_that.secondaryMuscles,_that.equipment,_that.difficulty,_that.exerciseType,_that.images,_that.videoUrl,_that.animationPlaceholder,_that.instructions,_that.commonMistakes,_that.tips,_that.alternatives,_that.tags);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  List<Muscle> primaryMuscles,  List<Muscle> secondaryMuscles,  List<Equipment> equipment,  ExerciseDifficulty difficulty,  ExerciseType exerciseType,  List<String> images,  String? videoUrl,  String? animationPlaceholder,  List<String> instructions,  List<String> commonMistakes,  List<String> tips,  List<String> alternatives,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _ExerciseModel():
return $default(_that.id,_that.name,_that.description,_that.primaryMuscles,_that.secondaryMuscles,_that.equipment,_that.difficulty,_that.exerciseType,_that.images,_that.videoUrl,_that.animationPlaceholder,_that.instructions,_that.commonMistakes,_that.tips,_that.alternatives,_that.tags);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  List<Muscle> primaryMuscles,  List<Muscle> secondaryMuscles,  List<Equipment> equipment,  ExerciseDifficulty difficulty,  ExerciseType exerciseType,  List<String> images,  String? videoUrl,  String? animationPlaceholder,  List<String> instructions,  List<String> commonMistakes,  List<String> tips,  List<String> alternatives,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.primaryMuscles,_that.secondaryMuscles,_that.equipment,_that.difficulty,_that.exerciseType,_that.images,_that.videoUrl,_that.animationPlaceholder,_that.instructions,_that.commonMistakes,_that.tips,_that.alternatives,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExerciseModel implements ExerciseModel {
  const _ExerciseModel({required this.id, required this.name, required this.description, final  List<Muscle> primaryMuscles = const [], final  List<Muscle> secondaryMuscles = const [], final  List<Equipment> equipment = const [], required this.difficulty, required this.exerciseType, final  List<String> images = const [], this.videoUrl, this.animationPlaceholder, final  List<String> instructions = const [], final  List<String> commonMistakes = const [], final  List<String> tips = const [], final  List<String> alternatives = const [], final  List<String> tags = const []}): _primaryMuscles = primaryMuscles,_secondaryMuscles = secondaryMuscles,_equipment = equipment,_images = images,_instructions = instructions,_commonMistakes = commonMistakes,_tips = tips,_alternatives = alternatives,_tags = tags;
  factory _ExerciseModel.fromJson(Map<String, dynamic> json) => _$ExerciseModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
 final  List<Muscle> _primaryMuscles;
@override@JsonKey() List<Muscle> get primaryMuscles {
  if (_primaryMuscles is EqualUnmodifiableListView) return _primaryMuscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_primaryMuscles);
}

 final  List<Muscle> _secondaryMuscles;
@override@JsonKey() List<Muscle> get secondaryMuscles {
  if (_secondaryMuscles is EqualUnmodifiableListView) return _secondaryMuscles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryMuscles);
}

 final  List<Equipment> _equipment;
@override@JsonKey() List<Equipment> get equipment {
  if (_equipment is EqualUnmodifiableListView) return _equipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipment);
}

@override final  ExerciseDifficulty difficulty;
@override final  ExerciseType exerciseType;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  String? videoUrl;
@override final  String? animationPlaceholder;
 final  List<String> _instructions;
@override@JsonKey() List<String> get instructions {
  if (_instructions is EqualUnmodifiableListView) return _instructions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_instructions);
}

 final  List<String> _commonMistakes;
@override@JsonKey() List<String> get commonMistakes {
  if (_commonMistakes is EqualUnmodifiableListView) return _commonMistakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_commonMistakes);
}

 final  List<String> _tips;
@override@JsonKey() List<String> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

 final  List<String> _alternatives;
@override@JsonKey() List<String> get alternatives {
  if (_alternatives is EqualUnmodifiableListView) return _alternatives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_alternatives);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseModelCopyWith<_ExerciseModel> get copyWith => __$ExerciseModelCopyWithImpl<_ExerciseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExerciseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._primaryMuscles, _primaryMuscles)&&const DeepCollectionEquality().equals(other._secondaryMuscles, _secondaryMuscles)&&const DeepCollectionEquality().equals(other._equipment, _equipment)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.exerciseType, exerciseType) || other.exerciseType == exerciseType)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.animationPlaceholder, animationPlaceholder) || other.animationPlaceholder == animationPlaceholder)&&const DeepCollectionEquality().equals(other._instructions, _instructions)&&const DeepCollectionEquality().equals(other._commonMistakes, _commonMistakes)&&const DeepCollectionEquality().equals(other._tips, _tips)&&const DeepCollectionEquality().equals(other._alternatives, _alternatives)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_primaryMuscles),const DeepCollectionEquality().hash(_secondaryMuscles),const DeepCollectionEquality().hash(_equipment),difficulty,exerciseType,const DeepCollectionEquality().hash(_images),videoUrl,animationPlaceholder,const DeepCollectionEquality().hash(_instructions),const DeepCollectionEquality().hash(_commonMistakes),const DeepCollectionEquality().hash(_tips),const DeepCollectionEquality().hash(_alternatives),const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'ExerciseModel(id: $id, name: $name, description: $description, primaryMuscles: $primaryMuscles, secondaryMuscles: $secondaryMuscles, equipment: $equipment, difficulty: $difficulty, exerciseType: $exerciseType, images: $images, videoUrl: $videoUrl, animationPlaceholder: $animationPlaceholder, instructions: $instructions, commonMistakes: $commonMistakes, tips: $tips, alternatives: $alternatives, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$ExerciseModelCopyWith<$Res> implements $ExerciseModelCopyWith<$Res> {
  factory _$ExerciseModelCopyWith(_ExerciseModel value, $Res Function(_ExerciseModel) _then) = __$ExerciseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, List<Muscle> primaryMuscles, List<Muscle> secondaryMuscles, List<Equipment> equipment, ExerciseDifficulty difficulty, ExerciseType exerciseType, List<String> images, String? videoUrl, String? animationPlaceholder, List<String> instructions, List<String> commonMistakes, List<String> tips, List<String> alternatives, List<String> tags
});




}
/// @nodoc
class __$ExerciseModelCopyWithImpl<$Res>
    implements _$ExerciseModelCopyWith<$Res> {
  __$ExerciseModelCopyWithImpl(this._self, this._then);

  final _ExerciseModel _self;
  final $Res Function(_ExerciseModel) _then;

/// Create a copy of ExerciseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? primaryMuscles = null,Object? secondaryMuscles = null,Object? equipment = null,Object? difficulty = null,Object? exerciseType = null,Object? images = null,Object? videoUrl = freezed,Object? animationPlaceholder = freezed,Object? instructions = null,Object? commonMistakes = null,Object? tips = null,Object? alternatives = null,Object? tags = null,}) {
  return _then(_ExerciseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,primaryMuscles: null == primaryMuscles ? _self._primaryMuscles : primaryMuscles // ignore: cast_nullable_to_non_nullable
as List<Muscle>,secondaryMuscles: null == secondaryMuscles ? _self._secondaryMuscles : secondaryMuscles // ignore: cast_nullable_to_non_nullable
as List<Muscle>,equipment: null == equipment ? _self._equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<Equipment>,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as ExerciseDifficulty,exerciseType: null == exerciseType ? _self.exerciseType : exerciseType // ignore: cast_nullable_to_non_nullable
as ExerciseType,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,animationPlaceholder: freezed == animationPlaceholder ? _self.animationPlaceholder : animationPlaceholder // ignore: cast_nullable_to_non_nullable
as String?,instructions: null == instructions ? _self._instructions : instructions // ignore: cast_nullable_to_non_nullable
as List<String>,commonMistakes: null == commonMistakes ? _self._commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as List<String>,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,alternatives: null == alternatives ? _self._alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
