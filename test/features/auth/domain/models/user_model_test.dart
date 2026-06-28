import 'package:flutter_test/flutter_test.dart';
import 'package:lift_it_up/features/auth/domain/models/user_model.dart';

void main() {
  group('UserModel Serialization', () {
    test('fromJson and toJson should handle all fields correctly', () {
      final now = DateTime.now();

      final json = {
        'id': 'test_id',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'photoUrl': 'http://example.com/photo.jpg',
        'isEmailVerified': true,
        'createdAt': now.toIso8601String(),
        'lastLoginAt': now.toIso8601String(),
        'isOnboardingCompleted': true,
        'username': 'testuser',
        'gender': 'Male',
        'age': 30,
        'height': 180.5,
        'weight': 75.0,
        'fitnessGoal': 'Build Muscle',
        'experienceLevel': 'Intermediate',
        'workoutFrequency': 4,
        'availableEquipment': ['Dumbbells', 'Barbell'],
        'preferredWorkoutDuration': 60,
        'injuries': ['None'],
        'targetWeight': 80.0,
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'test_id');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
      expect(user.photoUrl, 'http://example.com/photo.jpg');
      expect(user.isEmailVerified, true);
      expect(user.createdAt?.toIso8601String(), now.toIso8601String());
      expect(user.lastLoginAt?.toIso8601String(), now.toIso8601String());
      expect(user.isOnboardingCompleted, true);
      expect(user.username, 'testuser');
      expect(user.gender, 'Male');
      expect(user.age, 30);
      expect(user.height, 180.5);
      expect(user.weight, 75.0);
      expect(user.fitnessGoal, 'Build Muscle');
      expect(user.experienceLevel, 'Intermediate');
      expect(user.workoutFrequency, 4);
      expect(user.availableEquipment, ['Dumbbells', 'Barbell']);
      expect(user.preferredWorkoutDuration, 60);
      expect(user.injuries, ['None']);
      expect(user.targetWeight, 80.0);

      final outJson = user.toJson();

      expect(outJson['id'], 'test_id');
      expect(outJson['email'], 'test@example.com');
      expect(outJson['displayName'], 'Test User');
      expect(outJson['isOnboardingCompleted'], true);
      expect(outJson['username'], 'testuser');
    });

    test('default values should be set correctly', () {
      final json = {
        'id': 'test_id',
        'email': 'test@example.com',
      };

      final user = UserModel.fromJson(json);

      expect(user.isOnboardingCompleted, false);
      expect(user.isEmailVerified, false);
      expect(user.username, null);
    });
  });
}
