import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'analytics_service.dart';

class ErrorService {
  static final ErrorService _instance = ErrorService._internal();
  factory ErrorService() => _instance;
  ErrorService._internal();

  // Show error dialog
  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
            if (actionText != null && onAction != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onAction();
                },
                child: Text(actionText),
              ),
          ],
        );
      },
    );
  }

  // Show error snackbar
  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: duration,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Handle network errors
  static Future<void> handleNetworkError(
    BuildContext context,
    dynamic error,
    VoidCallback? retryAction,
  ) async {
    // Log error to analytics
    await AnalyticsService.logError(error, StackTrace.current);

    // Check connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    
    if (connectivityResult == ConnectivityResult.none) {
      showErrorDialog(
        context,
        title: 'No Internet Connection',
        message: 'Please check your internet connection and try again.',
        actionText: 'Retry',
        onAction: retryAction,
      );
    } else {
      showErrorDialog(
        context,
        title: 'Network Error',
        message: 'Unable to connect to the server. Please try again later.',
        actionText: 'Retry',
        onAction: retryAction,
      );
    }
  }

  // Handle authentication errors
  static Future<void> handleAuthError(
    BuildContext context,
    dynamic error,
  ) async {
    await AnalyticsService.logError(error, StackTrace.current);

    String message = 'Authentication failed. Please try again.';
    
    if (error.toString().contains('user-not-found')) {
      message = 'User not found. Please check your email and try again.';
    } else if (error.toString().contains('wrong-password')) {
      message = 'Incorrect password. Please try again.';
    } else if (error.toString().contains('email-already-in-use')) {
      message = 'An account with this email already exists.';
    } else if (error.toString().contains('weak-password')) {
      message = 'Password is too weak. Please choose a stronger password.';
    } else if (error.toString().contains('invalid-email')) {
      message = 'Invalid email address. Please check your email format.';
    }

    showErrorSnackBar(context, message: message);
  }

  // Handle Firestore errors
  static Future<void> handleFirestoreError(
    BuildContext context,
    dynamic error,
    VoidCallback? retryAction,
  ) async {
    await AnalyticsService.logError(error, StackTrace.current);

    String message = 'Unable to load data. Please try again.';
    
    if (error.toString().contains('permission-denied')) {
      message = 'You don\'t have permission to access this data.';
    } else if (error.toString().contains('not-found')) {
      message = 'The requested data was not found.';
    } else if (error.toString().contains('unavailable')) {
      message = 'Service temporarily unavailable. Please try again later.';
    }

    showErrorDialog(
      context,
      title: 'Data Error',
      message: message,
      actionText: 'Retry',
      onAction: retryAction,
    );
  }

  // Handle storage errors
  static Future<void> handleStorageError(
    BuildContext context,
    dynamic error,
    VoidCallback? retryAction,
  ) async {
    await AnalyticsService.logError(error, StackTrace.current);

    String message = 'Unable to upload file. Please try again.';
    
    if (error.toString().contains('unauthorized')) {
      message = 'You don\'t have permission to upload files.';
    } else if (error.toString().contains('quota-exceeded')) {
      message = 'Storage quota exceeded. Please contact support.';
    }

    showErrorDialog(
      context,
      title: 'Upload Error',
      message: message,
      actionText: 'Retry',
      onAction: retryAction,
    );
  }

  // Handle general errors
  static Future<void> handleGeneralError(
    BuildContext context,
    dynamic error,
    VoidCallback? retryAction,
  ) async {
    await AnalyticsService.logError(error, StackTrace.current);

    showErrorDialog(
      context,
      title: 'Error',
      message: 'Something went wrong. Please try again.',
      actionText: 'Retry',
      onAction: retryAction,
    );
  }

  // Retry mechanism with exponential backoff
  static Future<T?> retryWithBackoff<T>({
    required Future<T> Function() operation,
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    Duration delay = initialDelay;

    while (attempts < maxAttempts) {
      try {
        return await operation();
      } catch (error) {
        attempts++;
        
        if (attempts >= maxAttempts) {
          rethrow;
        }

        // Wait before retrying with exponential backoff
        await Future.delayed(delay);
        delay = Duration(milliseconds: delay.inMilliseconds * 2);
      }
    }
    
    return null;
  }

  // Get user-friendly error message
  static String getUserFriendlyMessage(dynamic error) {
    String errorString = error.toString().toLowerCase();
    
    if (errorString.contains('network')) {
      return 'Network connection error. Please check your internet connection.';
    } else if (errorString.contains('timeout')) {
      return 'Request timed out. Please try again.';
    } else if (errorString.contains('permission')) {
      return 'Permission denied. Please check your account permissions.';
    } else if (errorString.contains('not found')) {
      return 'The requested resource was not found.';
    } else if (errorString.contains('unauthorized')) {
      return 'You are not authorized to perform this action.';
    } else if (errorString.contains('server')) {
      return 'Server error. Please try again later.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
} 