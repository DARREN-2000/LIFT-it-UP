import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool isEmailVerified;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final bool isOnboardingCompleted;
  final String? username;
  final String? gender;
  final int? age;
  final double? height;
  final double? weight;
  final String? fitnessGoal;
  final String? experienceLevel;
  final int? workoutFrequency;
  final List<String>? availableEquipment;
  final int? preferredWorkoutDuration;
  final List<String>? injuries;
  final double? targetWeight;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.isEmailVerified = false,
    this.createdAt,
    this.lastLoginAt,
    this.isOnboardingCompleted = false,
    this.username,
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.fitnessGoal,
    this.experienceLevel,
    this.workoutFrequency,
    this.availableEquipment,
    this.preferredWorkoutDuration,
    this.injuries,
    this.targetWeight,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isOnboardingCompleted,
    String? username,
    String? gender,
    int? age,
    double? height,
    double? weight,
    String? fitnessGoal,
    String? experienceLevel,
    int? workoutFrequency,
    List<String>? availableEquipment,
    int? preferredWorkoutDuration,
    List<String>? injuries,
    double? targetWeight,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isOnboardingCompleted: isOnboardingCompleted ?? this.isOnboardingCompleted,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      workoutFrequency: workoutFrequency ?? this.workoutFrequency,
      availableEquipment: availableEquipment ?? this.availableEquipment,
      preferredWorkoutDuration: preferredWorkoutDuration ?? this.preferredWorkoutDuration,
      injuries: injuries ?? this.injuries,
      targetWeight: targetWeight ?? this.targetWeight,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'isOnboardingCompleted': isOnboardingCompleted,
      'username': username,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'fitnessGoal': fitnessGoal,
      'experienceLevel': experienceLevel,
      'workoutFrequency': workoutFrequency,
      'availableEquipment': availableEquipment,
      'preferredWorkoutDuration': preferredWorkoutDuration,
      'injuries': injuries,
      'targetWeight': targetWeight,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      username: json['username'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      fitnessGoal: json['fitnessGoal'] as String?,
      experienceLevel: json['experienceLevel'] as String?,
      workoutFrequency: json['workoutFrequency'] as int?,
      availableEquipment: (json['availableEquipment'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferredWorkoutDuration: json['preferredWorkoutDuration'] as int?,
      injuries: (json['injuries'] as List<dynamic>?)?.map((e) => e as String).toList(),
      targetWeight: (json['targetWeight'] as num?)?.toDouble(),
    );
  }

  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      isEmailVerified: firebaseUser.emailVerified ?? false,
      createdAt: firebaseUser.metadata?.creationTime,
      lastLoginAt: firebaseUser.metadata?.lastSignInTime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
        isEmailVerified,
        createdAt,
        lastLoginAt,
        isOnboardingCompleted,
        username,
        gender,
        age,
        height,
        weight,
        fitnessGoal,
        experienceLevel,
        workoutFrequency,
        availableEquipment,
        preferredWorkoutDuration,
        injuries,
        targetWeight,
      ];
}
