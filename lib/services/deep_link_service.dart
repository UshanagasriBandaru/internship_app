import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  StreamSubscription? _subscription;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Initialize deep linking
  Future<void> initialize() async {
    try {
      // Handle initial link if app was launched from a link
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleLink(initialLink);
      }

      // Listen for incoming links when app is running
      _subscription = uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          _handleLink(uri.toString());
        }
      }, onError: (err) {
        if (kDebugMode) {
          print('Deep link error: $err');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing deep links: $e');
      }
    }
  }

  // Handle incoming links
  void _handleLink(String link) {
    if (kDebugMode) {
      print('Handling deep link: $link');
    }

    final uri = Uri.parse(link);
    final path = uri.path;
    final queryParams = uri.queryParameters;

    switch (path) {
      case '/home':
        _navigateTo('/home');
        break;
      case '/about':
        _navigateTo('/about');
        break;
      case '/products':
        _navigateTo('/products');
        break;
      case '/services':
        _navigateTo('/services');
        break;
      case '/careers':
        _navigateTo('/careers');
        break;
      case '/contact':
        _navigateTo('/contact');
        break;
      case '/profile':
        _navigateTo('/profile');
        break;
      case '/job':
        final jobId = queryParams['id'];
        if (jobId != null) {
          _navigateTo('/careers', arguments: {'jobId': jobId});
        }
        break;
      case '/product':
        final productId = queryParams['id'];
        if (productId != null) {
          _navigateTo('/products', arguments: {'productId': productId});
        }
        break;
      case '/service':
        final serviceId = queryParams['id'];
        if (serviceId != null) {
          _navigateTo('/services', arguments: {'serviceId': serviceId});
        }
        break;
      default:
        if (kDebugMode) {
          print('Unknown deep link path: $path');
        }
    }
  }

  // Navigate to route
  void _navigateTo(String route, {Object? arguments}) {
    final navigator = navigatorKey.currentState;
    if (navigator != null) {
      navigator.pushNamed(route, arguments: arguments);
    }
  }

  // Generate deep link for job
  static String generateJobLink(String jobId) {
    return 'https://lineyshathevan.com/app/job?id=$jobId';
  }

  // Generate deep link for product
  static String generateProductLink(String productId) {
    return 'https://lineyshathevan.com/app/product?id=$productId';
  }

  // Generate deep link for service
  static String generateServiceLink(String serviceId) {
    return 'https://lineyshathevan.com/app/service?id=$serviceId';
  }

  // Generate share link
  static String generateShareLink({
    String? title,
    String? description,
    String? url,
  }) {
    final baseUrl = 'https://lineyshathevan.com/app/share';
    final params = <String, String>{};
    
    if (title != null) params['title'] = title;
    if (description != null) params['description'] = description;
    if (url != null) params['url'] = url;

    final queryString = params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');

    return queryString.isNotEmpty ? '$baseUrl?$queryString' : baseUrl;
  }

  // Dispose resources
  void dispose() {
    _subscription?.cancel();
  }
} 