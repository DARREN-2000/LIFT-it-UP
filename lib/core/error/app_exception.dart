import 'package:firebase_auth/firebase_auth.dart';

class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(this.message, {this.code, this.originalError});

  factory AppException.fromFirebaseAuthException(FirebaseAuthException e) {
    String message = 'An authentication error occurred.';
    switch (e.code) {
      case 'invalid-email':
        message = 'The email address is not valid.';
        break;
      case 'user-disabled':
        message = 'This user account has been disabled.';
        break;
      case 'user-not-found':
        message = 'No user found with this email.';
        break;
      case 'wrong-password':
        message = 'Incorrect password.';
        break;
      case 'email-already-in-use':
        message = 'The email address is already in use by another account.';
        break;
      case 'operation-not-allowed':
        message = 'This operation is not allowed.';
        break;
      case 'weak-password':
        message = 'The password is too weak.';
        break;
      default:
        message = e.message ?? message;
    }
    return AppException(message, code: e.code, originalError: e);
  }

  @override
  String toString() => message;
}
