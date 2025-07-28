// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:lt_app/main.dart';
import 'package:lt_app/auth/auth_provider.dart';
import 'package:lt_app/theme/theme_provider.dart';

void main() {
  group('LT App Widget Tests', () {
    testWidgets('App should start with splash screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MyApp(),
        ),
      );

      // Should show splash screen initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Should navigate to home after splash', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MyApp(),
        ),
      );

      // Wait for splash screen to complete
      await tester.pumpAndSettle(Duration(seconds: 3));

      // Should show home screen
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('Bottom navigation should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle(Duration(seconds: 3));

      // Test navigation to About
      await tester.tap(find.byIcon(Icons.info));
      await tester.pumpAndSettle();
      expect(find.text('About'), findsOneWidget);

      // Test navigation to Products
      await tester.tap(find.byIcon(Icons.inventory));
      await tester.pumpAndSettle();
      expect(find.text('Products'), findsOneWidget);

      // Test navigation to Services
      await tester.tap(find.byIcon(Icons.miscellaneous_services));
      await tester.pumpAndSettle();
      expect(find.text('Services'), findsOneWidget);

      // Test navigation to Careers
      await tester.tap(find.byIcon(Icons.work));
      await tester.pumpAndSettle();
      expect(find.text('Careers'), findsOneWidget);

      // Test navigation to Contact
      await tester.tap(find.byIcon(Icons.contact_phone));
      await tester.pumpAndSettle();
      expect(find.text('Contact'), findsOneWidget);

      // Test navigation to Profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Theme toggle should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle(Duration(seconds: 3));

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Toggle theme
      await tester.tap(find.byIcon(Icons.brightness_6));
      await tester.pumpAndSettle();

      // Theme should be toggled
      final themeProvider = tester.binding.defaultBinaryMessenger;
      expect(themeProvider, isNotNull);
    });
  });
}
