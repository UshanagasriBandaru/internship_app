import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// Conditional import for Crashlytics
import 'firebase_crashlytics_stub.dart' if (dart.library.io) 'package:firebase_crashlytics/firebase_crashlytics.dart' as crashlytics;

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  // Only initialize Crashlytics on non-web platforms
  static crashlytics.FirebaseCrashlytics? get _crashlytics {
    if (kIsWeb) return null;
    try {
      return crashlytics.FirebaseCrashlytics.instance;
    } catch (e) {
      return null;
    }
  }

  static Future<void> initialize() async {
    if (!kIsWeb) {
      try {
        final crashlyticsInstance = _crashlytics;
        if (crashlyticsInstance != null) {
          await crashlyticsInstance.setCrashlyticsCollectionEnabled(!kDebugMode);
          // Only assign on non-web
          FlutterError.onError = crashlyticsInstance.recordFlutterFatalError;
          PlatformDispatcher.instance.onError = (error, stack) {
            crashlyticsInstance.recordError(error, stack, fatal: true);
            return true;
          };
        }
      } catch (e) {
        print('Crashlytics initialization failed: $e');
      }
    }
  }

  // Screen tracking
  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }

  // User properties
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  static Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  // Custom events
  static Future<void> logLogin({String? method}) async {
    await _analytics.logLogin(loginMethod: method);
  }

  static Future<void> logSignUp({String? method}) async {
    await _analytics.logSignUp(signUpMethod: method ?? '');
  }

  static Future<void> logJobApplication({
    required String jobTitle,
    required String jobId,
  }) async {
    await _analytics.logEvent(
      name: 'job_application',
      parameters: {
        'job_title': jobTitle,
        'job_id': jobId,
      },
    );
  }

  static Future<void> logContactForm({
    required String contactMethod,
  }) async {
    await _analytics.logEvent(
      name: 'contact_form_submitted',
      parameters: {
        'contact_method': contactMethod,
      },
    );
  }

  static Future<void> logProductView({
    required String productName,
    required String productId,
  }) async {
    await _analytics.logEvent(
      name: 'product_view',
      parameters: {
        'product_name': productName,
        'product_id': productId,
      },
    );
  }

  static Future<void> logServiceView({
    required String serviceName,
    required String serviceId,
  }) async {
    await _analytics.logEvent(
      name: 'service_view',
      parameters: {
        'service_name': serviceName,
        'service_id': serviceId,
      },
    );
  }

  // Error tracking
  static Future<void> logError(
    dynamic error,
    StackTrace? stackTrace, {
    bool fatal = false,
  }) async {
    if (!kIsWeb) {
      try {
        final crashlyticsInstance = _crashlytics;
        if (crashlyticsInstance != null) {
          await crashlyticsInstance.recordError(error, stackTrace, fatal: fatal);
        }
      } catch (e) {
        print('Error logging failed: $e');
      }
    }
  }

  static Future<void> log(String message) async {
    if (!kIsWeb) {
      try {
        final crashlyticsInstance = _crashlytics;
        if (crashlyticsInstance != null) {
          await crashlyticsInstance.log(message);
        }
      } catch (e) {
        print('Log failed: $e');
      }
    }
  }

  // App lifecycle events
  static Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  static Future<void> logSearch({required String searchTerm}) async {
    await _analytics.logSearch(searchTerm: searchTerm);
  }

  // Navigation events
  static Future<void> logNavigation({
    required String from,
    required String to,
  }) async {
    await _analytics.logEvent(
      name: 'navigation',
      parameters: {
        'from_screen': from,
        'to_screen': to,
      },
    );
  }
} 