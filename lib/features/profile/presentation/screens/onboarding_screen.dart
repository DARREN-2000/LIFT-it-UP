import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lift_it_up/features/auth/providers/auth_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form Fields
  String _name = '';
  String _username = '';
  String _gender = 'Male';
  int _age = 25;
  double _height = 170.0;
  double _weight = 70.0;
  String _fitnessGoal = 'Build Muscle';
  String _experienceLevel = 'Beginner';
  int _workoutFrequency = 3;
  final List<String> _availableEquipment = [];
  int _preferredDuration = 45;
  final List<String> _injuries = [];
  double _targetWeight = 75.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Profile')),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () async {
            if (_currentStep < 3) {
              setState(() {
                _currentStep += 1;
              });
            } else {
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
                    availableEquipment: _availableEquipment,
                    preferredWorkoutDuration: _preferredDuration,
                    injuries: _injuries,
                    targetWeight: _targetWeight,
                    isOnboardingCompleted: true,
                  );

                  final result = await ref.read(userRepositoryProvider).updateUserProfile(updatedUser);
                  result.fold(
                    (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message))),
                    (_) => context.go('/'),
                  );
                }
              }
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: [
            Step(
              title: const Text('Basic Info'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => _name = v ?? '',
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    onSaved: (v) => _username = v ?? '',
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Body Metrics'),
              content: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _gender,
                    items: ['Male', 'Female', 'Other'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (v) => setState(() => _gender = v!),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                    initialValue: _age.toString(),
                    onSaved: (v) => _age = int.tryParse(v ?? '') ?? 25,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    initialValue: _height.toString(),
                    onSaved: (v) => _height = double.tryParse(v ?? '') ?? 170.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    initialValue: _weight.toString(),
                    onSaved: (v) => _weight = double.tryParse(v ?? '') ?? 70.0,
                  ),
                ],
              ),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Fitness Goals'),
              content: Column(
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _fitnessGoal,
                    items: ['Build Muscle', 'Lose Weight', 'Stay Fit'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (v) => setState(() => _fitnessGoal = v!),
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: _experienceLevel,
                    items: ['Beginner', 'Intermediate', 'Advanced'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                    onChanged: (v) => setState(() => _experienceLevel = v!),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Target Weight (kg)'),
                    keyboardType: TextInputType.number,
                    initialValue: _targetWeight.toString(),
                    onSaved: (v) => _targetWeight = double.tryParse(v ?? '') ?? 75.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Workout Frequency (days/week)'),
                    keyboardType: TextInputType.number,
                    initialValue: _workoutFrequency.toString(),
                    onSaved: (v) => _workoutFrequency = int.tryParse(v ?? '') ?? 3,
                  ),
                ],
              ),
              isActive: _currentStep >= 2,
            ),
            Step(
              title: const Text('Preferences & Details'),
              content: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Preferred Duration (mins)'),
                    keyboardType: TextInputType.number,
                    initialValue: _preferredDuration.toString(),
                    onSaved: (v) => _preferredDuration = int.tryParse(v ?? '') ?? 45,
                  ),
                  // Simple placeholders for lists, normally would use checkboxes/multi-select
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Available Equipment (comma separated)'),
                    onSaved: (v) {
                      if (v != null && v.isNotEmpty) {
                        _availableEquipment.addAll(v.split(',').map((e) => e.trim()));
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Injuries (comma separated)'),
                    onSaved: (v) {
                      if (v != null && v.isNotEmpty) {
                        _injuries.addAll(v.split(',').map((e) => e.trim()));
                      }
                    },
                  ),
                ],
              ),
              isActive: _currentStep >= 3,
            ),
          ],
        ),
      ),
    );
  }
}
