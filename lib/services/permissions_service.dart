import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class PermissionsService {
  static final PermissionsService _instance = PermissionsService._internal();
  factory PermissionsService() => _instance;
  PermissionsService._internal();

  // Request camera permission
  static Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    
    if (kDebugMode) {
      print('Camera permission status: $status');
    }
    
    return status.isGranted;
  }

  // Request storage permission
  static Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    
    if (kDebugMode) {
      print('Storage permission status: $status');
    }
    
    return status.isGranted;
  }

  // Request notification permission
  static Future<bool> requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    
    if (kDebugMode) {
      print('Notification permission status: $status');
    }
    
    return status.isGranted;
  }

  // Request microphone permission
  static Future<bool> requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    
    if (kDebugMode) {
      print('Microphone permission status: $status');
    }
    
    return status.isGranted;
  }

  // Request location permission
  static Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    
    if (kDebugMode) {
      print('Location permission status: $status');
    }
    
    return status.isGranted;
  }

  // Check if permission is granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    PermissionStatus status = await permission.status;
    return status.isGranted;
  }

  // Check if permission is permanently denied
  static Future<bool> isPermissionPermanentlyDenied(Permission permission) async {
    PermissionStatus status = await permission.status;
    return status.isPermanentlyDenied;
  }

  /// Opens the system app settings page for the user to manage permissions.
  static Future<bool> openSystemAppSettings() async {
    return await openAppSettings();
  }

  // Request multiple permissions
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    
    if (kDebugMode) {
      statuses.forEach((permission, status) {
        print('${permission.toString()}: $status');
      });
    }
    
    return statuses;
  }

  // Request all app permissions
  static Future<Map<Permission, PermissionStatus>> requestAllPermissions() async {
    List<Permission> permissions = [
      Permission.camera,
      Permission.storage,
      Permission.notification,
      Permission.microphone,
      Permission.location,
    ];
    
    return await requestMultiplePermissions(permissions);
  }

  // Check if all required permissions are granted
  static Future<bool> areAllPermissionsGranted() async {
    List<Permission> permissions = [
      Permission.camera,
      Permission.storage,
      Permission.notification,
    ];
    
    for (Permission permission in permissions) {
      if (!await isPermissionGranted(permission)) {
        return false;
      }
    }
    
    return true;
  }

  // Get permission status description
  static String getPermissionStatusDescription(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Granted';
      case PermissionStatus.denied:
        return 'Denied';
      case PermissionStatus.permanentlyDenied:
        return 'Permanently Denied';
      case PermissionStatus.restricted:
        return 'Restricted';
      case PermissionStatus.limited:
        return 'Limited';
      case PermissionStatus.provisional:
        return 'Provisional';
      default:
        return 'Unknown';
    }
  }
} 