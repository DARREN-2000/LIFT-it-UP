import 'package:flutter/foundation.dart';
import 'package:lift_it_up/core/logging/app_logger.dart';

class ErrorHandler {
  static void init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.e('FlutterError caught', details.exception, details.stack);
      if (kReleaseMode) {
        // Send to Crashlytics or similar service here
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.e('PlatformError caught', error, stack);
      if (kReleaseMode) {
        // Send to Crashlytics or similar service here
      }
      return true;
    };
  }
}
