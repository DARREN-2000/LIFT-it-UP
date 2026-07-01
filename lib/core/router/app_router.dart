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
import 'package:lift_it_up/features/profile/presentation/screens/onboarding_screen.dart';
import 'package:lift_it_up/features/profile/presentation/screens/profile_screen.dart';
import 'package:lift_it_up/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:lift_it_up/features/auth/providers/auth_providers.dart';
import 'package:lift_it_up/core/widgets/error_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final userProfile = ref.watch(currentUserProfileProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isAuth = authState.value != null;
      final isVerified = authState.value?.isEmailVerified ?? false;
      final isOnboardingCompleted = userProfile.value?.isOnboardingCompleted ?? false;

      final isGoingToAuth = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';
      final isGoingToVerify = state.matchedLocation == '/verify-email';
      final isGoingToOnboarding = state.matchedLocation == '/onboarding';

      if (authState.isLoading) return null;

      if (!isAuth) {
        if (!isGoingToAuth) return '/login';
        return null;
      }

      if (!isVerified) {
        if (!isGoingToVerify) return '/verify-email';
        return null;
      }

      // If user profile is still loading, do not redirect to prevent premature navigation
      if (userProfile.isLoading && !userProfile.hasValue) return null;

      if (!isOnboardingCompleted) {
        if (!isGoingToOnboarding) return '/onboarding';
        return null;
      }

      if (isGoingToAuth || isGoingToVerify || isGoingToOnboarding) {
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
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
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
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) => const EditProfileScreen(),
                  ),
                ],
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
