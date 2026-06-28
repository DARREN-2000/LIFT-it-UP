import 'package:fpdart/fpdart.dart';
import 'package:lift_it_up/core/error/app_exception.dart';
import 'package:lift_it_up/features/auth/domain/models/user_model.dart';
import 'package:lift_it_up/features/auth/domain/repositories/auth_repository.dart';
import 'package:lift_it_up/features/auth/domain/repositories/user_repository.dart';

class AuthService {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthService({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  Stream<UserModel?> get authStateChanges => _authRepository.authStateChanges;
  UserModel? get currentUser => _authRepository.currentUser;

  Stream<UserModel?> watchCurrentUserProfile() {
    final user = _authRepository.currentUser;
    if (user == null) {
      return Stream.value(null);
    }
    return _userRepository.watchUserProfile(user.id);
  }

  Future<Either<AppException, void>> _handleAuthResult(
      Either<AppException, UserModel> result) async {
    return result.fold(
      (error) => left(error),
      (user) async {
        // Check if user exists in Firestore
        final userProfileResult = await _userRepository.getUserProfile(user.id);

        return userProfileResult.fold(
          (error) async {
            // If user doesn't exist, create it
            if (error.message.contains('not found')) {
              final saveResult = await _userRepository.saveUserProfile(user);
              return saveResult.fold(
                (saveError) => left(saveError),
                (_) => right(null),
              );
            }
            return left(error);
          },
          (existingUser) async {
            // Update last login
            final updatedUser = existingUser.copyWith(
              lastLoginAt: DateTime.now(),
              // Update display name and photo if they changed in provider
              displayName: existingUser.displayName ?? user.displayName,
              photoUrl: existingUser.photoUrl ?? user.photoUrl,
            );
            final updateResult = await _userRepository.updateUserProfile(updatedUser);
            return updateResult.fold(
              (updateError) => left(updateError),
              (_) => right(null),
            );
          },
        );
      },
    );
  }

  Future<Either<AppException, void>> signInWithEmailAndPassword(
      String email, String password) async {
    final result = await _authRepository.signInWithEmailAndPassword(
        email: email, password: password);
    return _handleAuthResult(result);
  }

  Future<Either<AppException, void>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final result = await _authRepository.createUserWithEmailAndPassword(
        email: email, password: password);

    return result.fold(
      (error) => left(error),
      (user) async {
        // Update model with display name and save
        final userWithDisplayName = user.copyWith(displayName: displayName);
        final saveResult = await _userRepository.saveUserProfile(userWithDisplayName);

        return saveResult.fold(
          (saveError) => left(saveError),
          (_) => right(null),
        );
      },
    );
  }

  Future<Either<AppException, void>> signInWithGoogle() async {
    final result = await _authRepository.signInWithGoogle();
    return _handleAuthResult(result);
  }

  Future<Either<AppException, void>> signInWithApple() async {
    final result = await _authRepository.signInWithApple();
    return _handleAuthResult(result);
  }

  Future<Either<AppException, void>> signOut() {
    return _authRepository.signOut();
  }

  Future<Either<AppException, void>> sendPasswordResetEmail(String email) {
    return _authRepository.sendPasswordResetEmail(email: email);
  }

  Future<Either<AppException, void>> sendEmailVerification() {
    return _authRepository.sendEmailVerification();
  }
}
