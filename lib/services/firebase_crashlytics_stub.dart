import 'package:flutter/foundation.dart';

// Stub implementation of FirebaseCrashlytics for web platforms
// This file is used when dart.library.io is not available (web)

class FirebaseCrashlytics {
  static FirebaseCrashlytics get instance => FirebaseCrashlytics._();
  
  FirebaseCrashlytics._();
  
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {}
  
  void recordFlutterFatalError(FlutterErrorDetails details) {}
  
  Future<void> recordError(dynamic error, StackTrace? stack, {bool fatal = false}) async {}
  
  Future<void> log(String message) async {}
} 