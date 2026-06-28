import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lift_it_up/features/auth/providers/auth_providers.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _username;
  String? _gender;
  int? _age;
  double? _height;
  double? _weight;
  String? _fitnessGoal;
  String? _experienceLevel;
  int? _workoutFrequency;
  double? _targetWeight;

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final user = ref.read(currentUserProfileProvider).value;
      if (user != null) {
        _name = user.displayName;
        _username = user.username;
        _gender = user.gender ?? 'Male';
        _age = user.age ?? 25;
        _height = user.height ?? 170.0;
        _weight = user.weight ?? 70.0;
        _fitnessGoal = user.fitnessGoal ?? 'Build Muscle';
        _experienceLevel = user.experienceLevel ?? 'Beginner';
        _workoutFrequency = user.workoutFrequency ?? 3;
        _targetWeight = user.targetWeight ?? 75.0;
      }
      _isInitialized = true;
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final currentUser = ref.read(currentUserProfileProvider).value;

      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(
          displayName: _name,
          username: _username,
          gender: _gender,
          age: _age,
          height: _height,
          weight: _weight,
          fitnessGoal: _fitnessGoal,
          experienceLevel: _experienceLevel,
          workoutFrequency: _workoutFrequency,
          targetWeight: _targetWeight,
        );

        final result = await ref.read(userRepositoryProvider).updateUserProfile(updatedUser);

        result.fold(
          (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message))),
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
            context.pop();
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: userAsync.isLoading ? null : _saveProfile,
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No user data available'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Basic Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => _name = v,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _username,
                    decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => _username = v,
                  ),
                  const SizedBox(height: 24),
                  const Text('Body Metrics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _gender,
                    decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
                    items: ['Male', 'Female', 'Other'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (v) => setState(() => _gender = v),
                    onSaved: (v) => _gender = v,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _age?.toString(),
                          decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          onSaved: (v) => _age = int.tryParse(v ?? ''),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: _height?.toString(),
                          decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          onSaved: (v) => _height = double.tryParse(v ?? ''),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _weight?.toString(),
                          decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          onSaved: (v) => _weight = double.tryParse(v ?? ''),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: _targetWeight?.toString(),
                          decoration: const InputDecoration(labelText: 'Target (kg)', border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          onSaved: (v) => _targetWeight = double.tryParse(v ?? ''),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Fitness Goals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _fitnessGoal,
                    decoration: const InputDecoration(labelText: 'Primary Goal', border: OutlineInputBorder()),
                    items: ['Build Muscle', 'Lose Weight', 'Stay Fit'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (v) => setState(() => _fitnessGoal = v),
                    onSaved: (v) => _fitnessGoal = v,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _experienceLevel,
                    decoration: const InputDecoration(labelText: 'Experience Level', border: OutlineInputBorder()),
                    items: ['Beginner', 'Intermediate', 'Advanced'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (v) => setState(() => _experienceLevel = v),
                    onSaved: (v) => _experienceLevel = v,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _workoutFrequency?.toString(),
                    decoration: const InputDecoration(labelText: 'Workout Frequency (days/week)', border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    onSaved: (v) => _workoutFrequency = int.tryParse(v ?? ''),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
