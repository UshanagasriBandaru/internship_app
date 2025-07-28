import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:upgrader/upgrader.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/auth_provider.dart' as local_auth;
import 'theme/theme_provider.dart';
import 'screens/splash.dart';
import 'screens/home.dart';
import 'screens/about.dart';
import 'screens/products.dart';
import 'screens/services.dart';
import 'screens/careers.dart';
import 'screens/contact.dart';
import 'screens/profile.dart';
import 'screens/settings.dart';
import 'services/notification_service.dart';
import 'services/analytics_service.dart';
import 'services/connectivity_service.dart';
import 'services/permissions_service.dart';
import 'services/update_service.dart';
import 'widgets/loading_overlay.dart';
import 'package:lt_app/widgets/bottom_nav.dart'; // Adjust path as needed
import 'package:lt_app/screens/login.dart'; // ADD THIS IMPORT for the LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Corrected to use DefaultFirebaseOptions
  );

  // Initialize services
  await _initializeServices();

  runApp(MyApp());
}

Future<void> _initializeServices() async {
  try {
    await AnalyticsService.initialize();
    await NotificationService.initialize();
    // Removed direct initialization of ConnectivityService here,
    // it will be initialized within the ChangeNotifierProvider.
    await PermissionsService.requestNotificationPermission();
    print('All services initialized successfully at 11:15 AM IST, July 25, 2025'); // Updated time
  } catch (e) {
    print('Error initializing services: $e');
    // Navigate to error screen if services fail
  }
}

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 64),
            SizedBox(height: 18),
            Text('404 - Page Not Found', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('The page you are looking for does not exist.'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    AboutScreen(),
    ProductsScreen(),
    ServicesScreen(),
    CareersScreen(),
    ContactScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Removed conditional navigation using Navigator.pushReplacementNamed
          // as the body is already updated by setState.
          // if (index != 0) Navigator.pushReplacementNamed(context, ['/home', '/about', '/products', '/services', '/careers', '/contact', '/profile'][index]);
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => local_auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider( // Initialize ConnectivityService here
          create: (context) {
            final connectivityService = ConnectivityService();
            connectivityService.initialize(); // Call initialize on the instance
            return connectivityService;
          }
        ),
        ChangeNotifierProvider(create: (_) => LoadingOverlayProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return LoadingOverlay(
            child: MaterialApp(
              title: 'Lineysha & Thevan Software Technologies',
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              home: SplashScreen(),
              routes: {
                '/home': (context) => MainScreen(),
                '/about': (context) => AboutScreen(),
                '/products': (context) => ProductsScreen(),
                '/services': (context) => ServicesScreen(),
                '/careers': (context) => CareersScreen(),
                '/contact': (context) => ContactScreen(),
                '/profile': (context) => ProfileScreen(),
                '/settings': (context) => SettingsScreen(),
                '/login': (context) => LoginScreen(), // ADDED LOGIN SCREEN ROUTE
              },
              debugShowCheckedModeBanner: false,
              onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) => NotFoundScreen()),
              builder: (context, child) {
                return UpgradeAlert(
                  upgrader: UpdateService.getAppUpgrader(),
                  child: child!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    Future.delayed(Duration(seconds: 3), () {
      final authProvider = Provider.of<local_auth.AuthProvider>(context, listen: false);
      Navigator.pushReplacementNamed(context, authProvider.isAuthenticated ? '/home' : '/login');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.business,
                  size: 60,
                  color: Colors.blue[700],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Lineysha & Thevan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Software Technologies',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool get isAdmin {
  final email = FirebaseAuth.instance.currentUser?.email;
  return email == 'admin@LT.com' || email == 'ushanagasribandaru@gmail.com';
}