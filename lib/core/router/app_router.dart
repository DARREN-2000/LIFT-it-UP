import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lift_it_up/features/navigation/presentation/app_shell.dart';
import 'package:lift_it_up/features/home/presentation/home_screen.dart';
import 'package:lift_it_up/features/settings/presentation/settings_screen.dart';
import 'package:lift_it_up/features/auth/presentation/screens/login_screen.dart';
import 'package:lift_it_up/features/auth/presentation/screens/signup_screen.dart';
import 'package:lift_it_up/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:lift_it_up/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:lift_it_up/features/auth/providers/auth_providers.dart';
import 'package:lift_it_up/core/widgets/error_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isAuth = authState.value != null;
      final isVerified = authState.value?.isEmailVerified ?? false;
      final isGoingToAuth = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';
      final isGoingToVerify = state.matchedLocation == '/verify-email';

      if (authState.isLoading) return null;

      if (!isAuth) {
        if (!isGoingToAuth) return '/login';
        return null;
      }

      if (!isVerified) {
        if (!isGoingToVerify) return '/verify-email';
        return null;
      }

      if (isGoingToAuth || isGoingToVerify) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) => const EmailVerificationScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorView(message: 'Page not found: ${state.uri}'),
  );
});
