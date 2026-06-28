import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lift_it_up/features/auth/application/auth_service.dart';
import 'package:lift_it_up/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:lift_it_up/features/auth/data/repositories/firestore_user_repository.dart';
import 'package:lift_it_up/features/auth/domain/models/user_model.dart';
import 'package:lift_it_up/features/auth/domain/repositories/auth_repository.dart';
import 'package:lift_it_up/features/auth/domain/repositories/user_repository.dart';

// Provide mocks for testing if needed
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  );
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return FirestoreUserRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    authRepository: ref.watch(authRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
  );
});

final authStateChangesProvider = StreamProvider<UserModel?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserProfileProvider = StreamProvider<UserModel?>((ref) {
  return ref.watch(authServiceProvider).watchCurrentUserProfile();
});
