import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lift_it_up/firebase_options.dart';
import 'package:lift_it_up/core/error/error_handler.dart';
import 'package:lift_it_up/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ErrorHandler.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
