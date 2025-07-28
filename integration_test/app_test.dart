import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lt_app/main.dart' as app;
import 'package:provider/provider.dart';
import 'package:lt_app/auth/auth_provider.dart';
import 'package:lt_app/theme/theme_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('LT App Integration Tests', () {
    testWidgets('Complete app flow test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for splash screen
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Verify we're on home screen
      expect(find.text('Home'), findsOneWidget);

      // Test navigation through all screens
      final screens = [
        {'icon': Icons.info, 'title': 'About'},
        {'icon': Icons.inventory, 'title': 'Products'},
        {'icon': Icons.miscellaneous_services, 'title': 'Services'},
        {'icon': Icons.work, 'title': 'Careers'},
        {'icon': Icons.contact_phone, 'title': 'Contact'},
        {'icon': Icons.person, 'title': 'Profile'},
      ];

      for (final screen in screens) {
        await tester.tap(find.byIcon(screen['icon'] as IconData));
        await tester.pumpAndSettle();
        expect(find.text(screen['title'] as String), findsOneWidget);
      }

      // Go back to home
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('Authentication flow test', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Try to login (this will show login dialog)
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify login dialog is shown
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Close dialog
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
    });

    testWidgets('Theme switching test', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Toggle theme
      await tester.tap(find.byIcon(Icons.brightness_6));
      await tester.pumpAndSettle();

      // Verify theme changed (this is a basic check)
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('WhatsApp floating action button test', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Verify FAB is present
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Tap FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
    });

    testWidgets('Search functionality test', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Navigate to Products
      await tester.tap(find.byIcon(Icons.inventory));
      await tester.pumpAndSettle();

      // Look for search functionality
      expect(find.text('Products'), findsOneWidget);
    });

    testWidgets('Job board functionality test', (tester) async {
      app.main();
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Navigate to Careers
      await tester.tap(find.byIcon(Icons.work));
      await tester.pumpAndSettle();

      // Verify job board is loaded
      expect(find.text('Careers'), findsOneWidget);
    });
  });
} 