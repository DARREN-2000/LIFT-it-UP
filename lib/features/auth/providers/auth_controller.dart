import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lift_it_up/features/auth/application/auth_service.dart';
import 'package:lift_it_up/features/auth/providers/auth_providers.dart';

class AuthController extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  AuthService get _authService => ref.read(authServiceProvider);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AsyncValue.loading();
    final result =
        await _authService.signInWithEmailAndPassword(email, password);
    state = result.fold(
      (error) => AsyncValue.error(error, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = const AsyncValue.loading();
    final result = await _authService.createUserWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
    state = result.fold(
      (error) => AsyncValue.error(error, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    final result = await _authService.signInWithGoogle();
    state = result.fold(
      (error) => AsyncValue.error(error, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    final result = await _authService.signInWithApple();
    state = result.fold(
      (error) => AsyncValue.error(error, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final result = await _authService.signOut();
    state = result.fold(
      (error) => AsyncValue.error(error, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    final result = await _authService.sendPasswordResetEmail(email);
    state = result.fold(
      (error) => AsyncValue.error(error, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }

  Future<void> sendEmailVerification() async {
    state = const AsyncValue.loading();
    final result = await _authService.sendEmailVerification();
    state = result.fold(
      (error) => AsyncValue.error(error, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AsyncValue<void>>(() {
  return AuthController();
});
