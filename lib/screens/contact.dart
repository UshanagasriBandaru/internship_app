import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart'; // Corrected import for AppBottomNavBar
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LTAppBar(title: 'Contact Us'),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 5, // Index for Contact
        onTap: (index) {
          final List<String> routes = ['/home', '/about', '/products', '/services', '/careers', '/contact', '/profile'];
          if (index >= 0 && index < routes.length && index != 5) { // Do not navigate if already on Contact (index 5)
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
      body: ListView(
        children: [
          // Hero Section
          Stack(
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/company_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 260,
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
                height: 260,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        shadows: [Shadow(blurRadius: 8, color: Colors.black45, offset: Offset(0, 2))],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'We’re here to assist you with any questions!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
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
          SizedBox(height: 36),
          // Get in Touch Section
          Center(
            child: Column(
              children: [
                Text('Get in Touch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue[800])),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Reach out to us, and our team will respond promptly to assist you.',
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
          // Main Content
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.08),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isWide = constraints.maxWidth > 700;
                      return isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left: Map and Contact Info
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Reach Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900])),
                                      SizedBox(height: 16),
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: Colors.blue[50],
                                          border: Border.all(color: Colors.blue[100]!, width: 1),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.map, size: 48, color: Colors.blue[300]),
                                              SizedBox(height: 8),
                                              Text('Map Placeholder', style: TextStyle(color: Colors.blue[400], fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 28),
                                      Text('Contact Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900])),
                                      SizedBox(height: 16),
                                      _contactInfo(context), // Pass context
                                    ],
                                  ),
                                ),
                                SizedBox(width: 40),
                                // Right: Contact Form
                                Expanded(
                                  flex: 3,
                                  child: _contactForm(context), // Pass context
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Reach Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900])),
                                SizedBox(height: 16),
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.blue[50],
                                    border: Border.all(color: Colors.blue[100]!, width: 1),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.map, size: 48, color: Colors.blue[300]),
                                        SizedBox(height: 8),
                                        Text('Map Placeholder', style: TextStyle(color: Colors.blue[400], fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 28),
                                Text('Contact Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[900])),
                                SizedBox(height: 16),
                                _contactInfo(context), // Pass context
                                SizedBox(height: 32),
                                _contactForm(context), // Pass context
                              ],
                            );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  // Add BuildContext context as a parameter
  Widget _contactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contactInfoItem(Icons.location_on, 'Address', '3rd Floor, Varun Motors Building, Vasanth Plaza, near Benz Circle, Vijayawada, AP 520010', context: context), // Pass context
        SizedBox(height: 16),
        _contactInfoItem(Icons.email, 'Email', 'ltsoftwaretechno2019@gmail.com', isEmail: true, context: context), // Pass context and set isEmail
        SizedBox(height: 16),
        _contactInfoItem(Icons.phone, 'Phone', '8247252626 / 8977144333', context: context), // Pass context
        SizedBox(height: 16),
        _contactInfoItem(Icons.phone_android, 'Landline', '0866 - 7963760', context: context), // Pass context
      ],
    );
  }

  // Add BuildContext context as a required parameter
  Widget _contactInfoItem(IconData icon, String label, String value, {bool isEmail = false, required BuildContext context}) {
    return GestureDetector(
      onTap: isEmail
          ? () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: value,
              );
              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not launch email client.')),
                );
              }
            }
          : null,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue[100]!, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(icon, color: Colors.blue[700], size: 20),
              radius: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey[700],
                      decoration: isEmail ? TextDecoration.underline : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add BuildContext context as a parameter
  Widget _contactForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send us a Message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue[900])),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
              ),
              filled: true,
              fillColor: Colors.blue[50],
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            validator: (val) => val == null || val.isEmpty ? 'Please enter your name' : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Your Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
              ),
              filled: true,
              fillColor: Colors.blue[50],
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            validator: (val) => val == null || !val.contains('@') ? 'Please enter a valid email' : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[200]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
              ),
              filled: true,
              fillColor: Colors.blue[50],
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            maxLines: 4,
            validator: (val) => val == null || val.isEmpty ? 'Please enter a message' : null,
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.reset();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Message sent successfully! (Demo only)')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields correctly.')),
                  );
                }
              },
              child: Text('Send Message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}