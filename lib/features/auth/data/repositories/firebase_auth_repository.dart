import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lift_it_up/core/error/app_exception.dart';
import 'package:lift_it_up/features/auth/domain/models/user_model.dart';
import 'package:lift_it_up/features/auth/domain/repositories/auth_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Stream<UserModel?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((user) {
        if (user == null) return null;
        return UserModel.fromFirebaseUser(user);
      });

  @override
  UserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<Either<AppException, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        return left(const AppException('User not found.'));
      }
      return right(UserModel.fromFirebaseUser(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      return left(AppException.fromFirebaseAuthException(e));
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, UserModel>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        return left(const AppException('Failed to create user.'));
      }
      return right(UserModel.fromFirebaseUser(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      return left(AppException.fromFirebaseAuthException(e));
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, UserModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AppException('Google sign in aborted.'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user == null) {
        return left(const AppException('Failed to sign in with Google.'));
      }
      return right(UserModel.fromFirebaseUser(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      return left(AppException.fromFirebaseAuthException(e));
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, UserModel>> signInWithApple() async {
    try {
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final AuthCredential credential = oauthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);

      // Update display name if provided
      if (appleIdCredential.givenName != null || appleIdCredential.familyName != null) {
        final displayName = [appleIdCredential.givenName, appleIdCredential.familyName]
            .where((e) => e != null)
            .join(' ');
        await userCredential.user?.updateDisplayName(displayName);
      }

      if (userCredential.user == null) {
        return left(const AppException('Failed to sign in with Apple.'));
      }
      return right(UserModel.fromFirebaseUser(userCredential.user!));
    } on FirebaseAuthException catch (e) {
      return left(AppException.fromFirebaseAuthException(e));
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(AppException.fromFirebaseAuthException(e));
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return left(const AppException('No user signed in.'));
      }
      await user.sendEmailVerification();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(AppException.fromFirebaseAuthException(e));
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return right(null);
    } catch (e) {
      return left(AppException(e.toString()));
    }
  }
}
