import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  static const String _jobsCacheKey = 'cached_jobs';
  static const String _productsCacheKey = 'cached_products';
  static const String _servicesCacheKey = 'cached_services';
  static const String _userProfileCacheKey = 'cached_user_profile';
  static const String _appSettingsCacheKey = 'cached_app_settings';
  static const String _lastSyncKey = 'last_sync_timestamp';

  // Cache jobs data
  static Future<void> cacheJobs(List<Map<String, dynamic>> jobs) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jobsJson = jsonEncode(jobs);
      await prefs.setString(_jobsCacheKey, jobsJson);
      await _updateLastSync();
      if (kDebugMode) {
        print('Jobs cached successfully: ${jobs.length} jobs');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error caching jobs: $e');
      }
    }
  }

  // Get cached jobs
  static Future<List<Map<String, dynamic>>> getCachedJobs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jobsJson = prefs.getString(_jobsCacheKey);
      if (jobsJson != null) {
        final List<dynamic> jobsList = jsonDecode(jobsJson);
        return jobsList.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting cached jobs: $e');
      }
    }
    return [];
  }

  // Cache products data
  static Future<void> cacheProducts(List<Map<String, dynamic>> products) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final productsJson = jsonEncode(products);
      await prefs.setString(_productsCacheKey, productsJson);
      await _updateLastSync();
    } catch (e) {
      if (kDebugMode) {
        print('Error caching products: $e');
      }
    }
  }

  // Get cached products
  static Future<List<Map<String, dynamic>>> getCachedProducts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final productsJson = prefs.getString(_productsCacheKey);
      if (productsJson != null) {
        final List<dynamic> productsList = jsonDecode(productsJson);
        return productsList.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting cached products: $e');
      }
    }
    return [];
  }

  // Cache services data
  static Future<void> cacheServices(List<Map<String, dynamic>> services) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final servicesJson = jsonEncode(services);
      await prefs.setString(_servicesCacheKey, servicesJson);
      await _updateLastSync();
    } catch (e) {
      if (kDebugMode) {
        print('Error caching services: $e');
      }
    }
  }

  // Get cached services
  static Future<List<Map<String, dynamic>>> getCachedServices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final servicesJson = prefs.getString(_servicesCacheKey);
      if (servicesJson != null) {
        final List<dynamic> servicesList = jsonDecode(servicesJson);
        return servicesList.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting cached services: $e');
      }
    }
    return [];
  }

  // Cache user profile
  static Future<void> cacheUserProfile(Map<String, dynamic> profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = jsonEncode(profile);
      await prefs.setString(_userProfileCacheKey, profileJson);
    } catch (e) {
      if (kDebugMode) {
        print('Error caching user profile: $e');
      }
    }
  }

  // Get cached user profile
  static Future<Map<String, dynamic>?> getCachedUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString(_userProfileCacheKey);
      if (profileJson != null) {
        return Map<String, dynamic>.from(jsonDecode(profileJson));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting cached user profile: $e');
      }
    }
    return null;
  }

  // Cache app settings
  static Future<void> cacheAppSettings(Map<String, dynamic> settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = jsonEncode(settings);
      await prefs.setString(_appSettingsCacheKey, settingsJson);
    } catch (e) {
      if (kDebugMode) {
        print('Error caching app settings: $e');
      }
    }
  }

  // Get cached app settings
  static Future<Map<String, dynamic>> getCachedAppSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_appSettingsCacheKey);
      if (settingsJson != null) {
        return Map<String, dynamic>.from(jsonDecode(settingsJson));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting cached app settings: $e');
      }
    }
    return {};
  }

  // Check if cache is stale (older than 24 hours)
  static Future<bool> isCacheStale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastSync = prefs.getInt(_lastSyncKey) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;
      final oneDay = 24 * 60 * 60 * 1000; // 24 hours in milliseconds
      return (now - lastSync) > oneDay;
    } catch (e) {
      return true; // Consider cache stale if error
    }
  }

  // Update last sync timestamp
  static Future<void> _updateLastSync() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_lastSyncKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating last sync: $e');
      }
    }
  }

  // Clear all cache
  static Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_jobsCacheKey);
      await prefs.remove(_productsCacheKey);
      await prefs.remove(_servicesCacheKey);
      await prefs.remove(_userProfileCacheKey);
      await prefs.remove(_appSettingsCacheKey);
      await prefs.remove(_lastSyncKey);
      if (kDebugMode) {
        print('All cache cleared successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing cache: $e');
      }
    }
  }

  // Get cache size info
  static Future<Map<String, int>> getCacheInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jobs = prefs.getString(_jobsCacheKey)?.length ?? 0;
      final products = prefs.getString(_productsCacheKey)?.length ?? 0;
      final services = prefs.getString(_servicesCacheKey)?.length ?? 0;
      final profile = prefs.getString(_userProfileCacheKey)?.length ?? 0;
      final settings = prefs.getString(_appSettingsCacheKey)?.length ?? 0;

      return {
        'jobs': jobs,
        'products': products,
        'services': services,
        'profile': profile,
        'settings': settings,
        'total': jobs + products + services + profile + settings,
      };
    } catch (e) {
      return {'total': 0};
    }
  }
} 