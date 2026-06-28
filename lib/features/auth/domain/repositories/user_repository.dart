import 'package:fpdart/fpdart.dart';
import 'package:lift_it_up/core/error/app_exception.dart';
import 'package:lift_it_up/features/auth/domain/models/user_model.dart';

abstract class UserRepository {
  Future<Either<AppException, UserModel>> getUserProfile(String userId);
  Future<Either<AppException, void>> saveUserProfile(UserModel user);
  Future<Either<AppException, void>> updateUserProfile(UserModel user);
  Stream<UserModel?> watchUserProfile(String userId);
}
