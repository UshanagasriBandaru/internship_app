import 'package:upgrader/upgrader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class UpdateService {
  static final UpdateService _instance = UpdateService._internal();
  factory UpdateService() => _instance;
  UpdateService._internal();

  static const String _lastUpdateCheckKey = 'last_update_check';
  static const String _updateDismissedKey = 'update_dismissed';

  // Check if update check is needed (once per day)
  static Future<bool> shouldCheckForUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCheck = prefs.getInt(_lastUpdateCheckKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    final oneDay = 24 * 60 * 60 * 1000; // 24 hours in milliseconds

    return (now - lastCheck) > oneDay;
  }

  // Mark update check as completed
  static Future<void> markUpdateCheckCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastUpdateCheckKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Check if update was dismissed
  static Future<bool> wasUpdateDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_updateDismissedKey) ?? false;
  }

  // Mark update as dismissed
  static Future<void> markUpdateDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_updateDismissedKey, true);
  }

  // Reset update dismissed status
  static Future<void> resetUpdateDismissed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_updateDismissedKey);
  }

  // Get app version info
  static Upgrader getAppUpgrader() {
    return Upgrader();
  }

  // Custom update dialog configuration
  static Upgrader getCustomAppUpgrader({
    String? title,
    String? body,
    String? updateButtonLabel,
    String? ignoreButtonLabel,
    String? laterButtonLabel,
  }) {
    return Upgrader();
  }

  // Check for critical updates (force update)
  static Upgrader getCriticalAppUpgrader() {
    return Upgrader();
  }
} 