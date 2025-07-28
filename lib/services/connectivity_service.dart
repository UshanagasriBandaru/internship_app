import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService extends ChangeNotifier {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  bool _isConnected = false;

  ConnectivityResult get connectionStatus => _connectionStatus;
  bool get isConnected => _isConnected;

  Future<void> initialize() async {
    // Check initial connectivity status
    _connectionStatus = await _connectivity.checkConnectivity();
    _updateConnectionStatus(_connectionStatus);

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _updateConnectionStatus(result);
      },
    );
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    _isConnected = result != ConnectivityResult.none;
    
    if (kDebugMode) {
      print('Connectivity changed: $_connectionStatus');
    }
    
    notifyListeners();
  }

  String getConnectionType() {
    switch (_connectionStatus) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.other:
        return 'Other';
      case ConnectivityResult.none:
      default:
        return 'No Connection';
    }
  }

  bool isWifiConnected() {
    return _connectionStatus == ConnectivityResult.wifi;
  }

  bool isMobileConnected() {
    return _connectionStatus == ConnectivityResult.mobile;
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
} 