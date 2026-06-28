import 'package:fpdart/fpdart.dart';
import 'package:lift_it_up/core/error/app_exception.dart';
import 'package:lift_it_up/features/auth/domain/models/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel?> get authStateChanges;
  UserModel? get currentUser;

  Future<Either<AppException, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AppException, UserModel>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AppException, UserModel>> signInWithGoogle();
  Future<Either<AppException, UserModel>> signInWithApple();

  Future<Either<AppException, void>> sendPasswordResetEmail({
    required String email,
  });

  Future<Either<AppException, void>> sendEmailVerification();

  Future<Either<AppException, void>> signOut();
}
