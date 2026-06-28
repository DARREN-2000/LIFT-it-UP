import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lift_it_up/features/auth/providers/auth_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/profile/edit'),
          ),
        ],
      ),
      body: userProfileAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No user data available'));
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                        child: user.photoUrl == null ? const Icon(Icons.person, size: 50) : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.displayName ?? 'No Name',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '@${user.username ?? 'user'}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 24),
                    _buildSectionTitle(context, 'Profile Statistics'),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(context, 'Weight', '${user.weight ?? '-'} kg'),
                            _buildStatItem(context, 'Target', '${user.targetWeight ?? '-'} kg'),
                            _buildStatItem(context, 'Height', '${user.height ?? '-'} cm'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(context, 'Workout Summary'),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: Text('Goal: ${user.fitnessGoal ?? '-'}'),
                        subtitle: Text('Level: ${user.experienceLevel ?? '-'} • ${user.workoutFrequency ?? 0} days/week'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(context, 'Achievements'),
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text('Coming soon!'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(context, 'Settings'),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text('App Settings'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.go('/settings'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout, color: Colors.red),
                            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                            onTap: () {
                              ref.read(authServiceProvider).signOut();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
