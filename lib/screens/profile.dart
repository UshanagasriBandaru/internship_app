import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <--- NEW: Import for SharedPreferences
import '../widgets/app_bar.dart'; // Assuming this path is correct
import '../widgets/bottom_nav.dart'; // Assuming this path is correct, was app_bottom_nav_bar.dart in errors
import '../auth/auth_provider.dart'; // Assuming this path is correct
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 6;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = authProvider.isAuthenticated;
    final user = isLoggedIn && authProvider.user != null
        ? {
            'name': authProvider.user?.displayName ?? 'Unnamed User',
            'email': authProvider.user?.email ?? '',
            'avatar': authProvider.user?.photoURL,
          }
        : {
            'name': 'Guest User',
            'email': 'guest@example.com',
            'avatar': null,
          };

    return Scaffold(
      appBar: LTAppBar(title: 'Profile'),
      // Assuming AppBottomNavBar is the correct name from bottom_nav.dart
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == _selectedIndex) return;
          setState(() => _selectedIndex = index);
          final routes = ['/home', '/about', '/products', '/services', '/careers', '/contact', '/profile'];
          // Use context.mounted before Navigator operations in async contexts or callbacks
          if (mounted) {
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
      body: ListView(
        children: [
          _buildHeader(user),
          SizedBox(height: 32),
          _buildProfileCard(context, user, isLoggedIn, authProvider),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> user) {
    return Stack(
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/company_logo.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.blueGrey.withOpacity(0.5), BlendMode.darken),
            ),
          ),
        ),
        Container(
          height: 180,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Your Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                user['email'],
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context, Map<String, dynamic> user, bool isLoggedIn, AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(user),
              SizedBox(height: 18),
              Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 6),
              Text(user['email'], style: TextStyle(color: Colors.blueGrey[700], fontSize: 15)),
              SizedBox(height: 28),
              _buildQuickActions(context, isLoggedIn, authProvider),
              SizedBox(height: 32),
              _buildSettingsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(Map<String, dynamic> user) {
    final avatar = user['avatar'];
    if (avatar != null && avatar.toString().isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatar,
          width: 108,
          height: 108,
          fit: BoxFit.cover,
          placeholder: (context, url) => _fallbackAvatar(),
          errorWidget: (context, url, error) => _fallbackAvatar(),
        ),
      );
    } else {
      return _fallbackAvatar();
    }
  }

  Widget _fallbackAvatar() {
    return CircleAvatar(
      radius: 54,
      backgroundColor: Colors.blue[700],
      child: Icon(Icons.person, size: 54, color: Colors.white),
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isLoggedIn, AuthProvider authProvider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 400;
        final logoutLoginAction = _quickAction(
          Icons.logout,
          isLoggedIn ? 'Logout' : 'Login',
          () async { // <--- Made this callback async
            if (isLoggedIn) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn'); // <-- Clear session
              await authProvider.logout(); // Perform Firebase logout

              // Check if the widget is still mounted before navigating
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            } else {
              // If not logged in, just navigate to login
              if (mounted) { // Check context.mounted
                Navigator.pushNamed(context, '/login');
              }
            }
          },
        );

        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _quickAction(Icons.edit, 'Edit Profile', () {}),
              SizedBox(width: 32),
              _quickAction(Icons.lock, 'Change Password', () {}),
              SizedBox(width: 32),
              logoutLoginAction,
            ],
          );
        } else {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _quickAction(Icons.edit, 'Edit Profile', () {}),
                  SizedBox(width: 24),
                  _quickAction(Icons.lock, 'Change Password', () {}),
                ],
              ),
              SizedBox(height: 16),
              logoutLoginAction,
            ],
          );
        }
      },
    );
  }

  Widget _quickAction(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blue[100],
            child: Icon(icon, color: Colors.blue[700], size: 24),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 16),
            _settingsTile(Icons.notifications, 'Notifications', 'Manage preferences', () {
              // Use context.mounted before Navigator operations
              if (mounted) {
                Navigator.pushNamed(context, '/settings#notifications');
              }
            }),
            _settingsTile(Icons.privacy_tip, 'Privacy', 'View policy', () {
              // Use context.mounted before Navigator operations
              if (mounted) {
                Navigator.pushNamed(context, '/settings#privacy');
              }
            }),
            _settingsTile(Icons.help_outline, 'Help & Support', 'Get assistance', () {
              // Use context.mounted before Navigator operations
              if (mounted) {
                Navigator.pushNamed(context, '/settings#help');
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[700]),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
    );
  }
}