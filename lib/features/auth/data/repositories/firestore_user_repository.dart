import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lift_it_up/core/error/app_exception.dart';
import 'package:lift_it_up/features/auth/domain/models/user_model.dart';
import 'package:lift_it_up/features/auth/domain/repositories/user_repository.dart';

class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _firestore;

  FirestoreUserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  @override
  Future<Either<AppException, UserModel>> getUserProfile(String userId) async {
    try {
      final doc = await _users.doc(userId).get();
      if (!doc.exists || doc.data() == null) {
        return left(const AppException('User profile not found.'));
      }
      return right(UserModel.fromJson(doc.data()!));
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> saveUserProfile(UserModel user) async {
    try {
      await _users.doc(user.id).set(user.toJson());
      return right(null);
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> updateUserProfile(UserModel user) async {
    try {
      await _users.doc(user.id).update(user.toJson());
      return right(null);
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Stream<UserModel?> watchUserProfile(String userId) {
    return _users.doc(userId).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      return UserModel.fromJson(snapshot.data()!);
    });
  }
}
