import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';
import '../auth/auth_provider.dart';
import '../theme/theme_provider.dart';
import '../services/cache_service.dart';
import '../services/share_service.dart';
import '../services/permissions_service.dart';
import '../services/analytics_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _autoSyncEnabled = true;
  bool _analyticsEnabled = true;
  Map<String, int> _cacheInfo = {};

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadCacheInfo();
  }

  Future<void> _loadSettings() async {
    try {
      final settings = await CacheService.getCachedAppSettings();
      setState(() {
        _notificationsEnabled = settings['notifications_enabled'] ?? true;
        _autoSyncEnabled = settings['auto_sync_enabled'] ?? true;
        _analyticsEnabled = settings['analytics_enabled'] ?? true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load settings: $e')),
      );
    }
  }

  Future<void> _loadCacheInfo() async {
    try {
      final info = await CacheService.getCacheInfo();
      setState(() {
        _cacheInfo = info;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load cache info: $e')),
      );
    }
  }

  Future<void> _saveSettings() async {
    try {
      final settings = {
        'notifications_enabled': _notificationsEnabled,
        'auto_sync_enabled': _autoSyncEnabled,
        'analytics_enabled': _analyticsEnabled,
      };
      await CacheService.cacheAppSettings(settings);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save settings: $e')),
      );
    }
  }

  Future<void> _clearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache'),
        content: Text('This will clear all cached data. Re-download may occur next use.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await CacheService.clearAllCache();
        await _loadCacheInfo();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cache cleared successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to clear cache: $e')),
        );
      }
    }
  }

  Future<void> _requestPermissions() async {
    try {
      await PermissionsService.requestAllPermissions();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permissions updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update permissions: $e')),
      );
    }
  }

  void _shareApp() {
    try {
      ShareService.shareApp();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share app: $e')),
      );
    }
  }

  void _contactSupport() async {
    final url = Uri.parse('mailto:contact@lineyshathevan.com?subject=LT App Support');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch email');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to contact support: $e')),
      );
    }
  }

  void _openPrivacyPolicy() async {
    final url = Uri.parse('https://lineyshathevan.com/privacy-policy');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch privacy policy');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open privacy policy: $e')),
      );
    }
  }

  void _openTermsOfService() async {
    final url = Uri.parse('https://lineyshathevan.com/terms-of-service');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch terms of service');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open terms of service: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: LTAppBar(title: 'Settings'),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 6, // Should be a unique index for Settings, but using 6 for consistency
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/about');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/products');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/services');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/careers');
              break;
            case 5:
              Navigator.pushReplacementNamed(context, '/contact');
              break;
            case 6:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
      body: ListView(
        children: [
          // Hero Section
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/company_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.7), Colors.black.withOpacity(0.5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Container(
                height: 200,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black45, offset: Offset(0, 2))],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Customize your app experience',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          // Customize Experience Section
          Center(
            child: Column(
              children: [
                Text('Customize Your Experience', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue[800])),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Personalize your app settings to match your preferences.',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 28),
                Divider(thickness: 1.2, indent: 60, endIndent: 60, color: Colors.blue[100]),
                SizedBox(height: 28),
              ],
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Section
                  _buildSectionHeader('Account'),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.08),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[50],
                        child: Icon(Icons.person, color: Colors.blue[700], size: 24),
                        radius: 20,
                      ),
                      title: Text('Profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      subtitle: Text(authProvider.isAuthenticated ? 'Manage your profile' : 'Sign in to access', style: TextStyle(fontSize: 14)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blueGrey[400]),
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                    ),
                  ),
                  if (authProvider.isAuthenticated)
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.08),
                            blurRadius: 16,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: Colors.red[50],
                          child: Icon(Icons.logout, color: Colors.red[700], size: 24),
                          radius: 20,
                        ),
                        title: Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.red[700])),
                        onTap: () async {
                          await authProvider.logout();
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                    ),
                  SizedBox(height: 28),
                  // App Preferences
                  _buildSectionHeader('App Preferences'),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.08),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          Icons.dark_mode,
                          'Dark Mode',
                          'Toggle themes',
                          themeProvider.isDarkMode,
                          (value) => themeProvider.toggleTheme(),
                          Colors.purple[700]!,
                        ),
                        _buildSwitchTile(
                          Icons.notifications,
                          'Notifications',
                          'Receive push notifications',
                          _notificationsEnabled,
                          (value) {
                            setState(() => _notificationsEnabled = value);
                            _saveSettings();
                          },
                          Colors.orange[700]!,
                        ),
                        _buildSwitchTile(
                          Icons.sync,
                          'Auto Sync',
                          'Sync data when online',
                          _autoSyncEnabled,
                          (value) {
                            setState(() => _autoSyncEnabled = value);
                            _saveSettings();
                          },
                          Colors.green[700]!,
                        ),
                        _buildSwitchTile(
                          Icons.analytics,
                          'Analytics',
                          'Enable usage analytics',
                          _analyticsEnabled,
                          (value) {
                            setState(() => _analyticsEnabled = value);
                            _saveSettings();
                            if (value) {
                              AnalyticsService.setUserProperty(name: 'analytics_enabled', value: 'true');
                            } else {
                              AnalyticsService.setUserProperty(name: 'analytics_enabled', value: 'false');
                            }
                          },
                          Colors.blue[700]!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  // Data & Storage
                  _buildSectionHeader('Data & Storage'),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.08),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildListTile(
                          Icons.storage,
                          'Cache Size',
                          '${(_cacheInfo['total'] ?? 0) ~/ 1024} KB',
                          null,
                          Colors.orange[700]!,
                        ),
                        _buildListTile(
                          Icons.delete,
                          'Clear Cache',
                          'Free up storage',
                          _clearCache,
                          Colors.red[700]!,
                        ),
                        _buildListTile(
                          Icons.security,
                          'Permissions',
                          'Manage app permissions',
                          _requestPermissions,
                          Colors.green[700]!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  // Support
                  _buildSectionHeader('Support'),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.08),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildListTile(
                          Icons.share,
                          'Share App',
                          'Share with others',
                          _shareApp,
                          Colors.blue[700]!,
                        ),
                        _buildListTile(
                          Icons.support_agent,
                          'Contact Support',
                          'Get help from our team',
                          _contactSupport,
                          Colors.purple[700]!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  // Legal
                  _buildSectionHeader('Legal'),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.08),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildListTile(
                          Icons.privacy_tip,
                          'Privacy Policy',
                          'Read our policy',
                          _openPrivacyPolicy,
                          Colors.blueGrey[700]!,
                        ),
                        _buildListTile(
                          Icons.article,
                          'Terms of Service',
                          'Read our terms',
                          _openTermsOfService,
                          Colors.blueGrey[700]!,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        secondary: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor, size: 20),
          radius: 18,
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.blueGrey[600])),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue[700],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle, VoidCallback? onTap, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor, size: 20),
          radius: 18,
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.blueGrey[600])),
        trailing: onTap != null ? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blueGrey[400]) : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900]),
      ),
    );
  }
}