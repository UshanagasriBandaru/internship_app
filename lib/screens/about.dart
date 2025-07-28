import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      appBar: LTAppBar(title: 'About Us'),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1, // Index for About
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              // Already on About, no action needed
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
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/company_logo.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7),
                      BlendMode.darken,
                    ),
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
                      'About Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Welcome to Lineysha & Thevan Software Technologies',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 36),
          // Three Cards Section
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: [
                  _aboutCard(
                    'Who Are We',
                    'Lineysha & Thevan Software Technologies, established in 2000, is a pioneering force in software and hardware solutions. With over two decades of experience, we deliver cutting-edge technology across industries.',
                  ),
                  _aboutCard(
                    'Why Choose Us',
                    'Partner with us for innovation, excellence, and customer satisfaction. We tailor solutions to exceed your expectations.',
                  ),
                  _aboutCard(
                    'Our Commitment',
                    'We uphold integrity, transparency, and deliver measurable value to our clients with technological excellence.',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          // Vision & Mission
          Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.remove_red_eye, color: Colors.blue[900]),
                            SizedBox(width: 8),
                            Text('Our Vision', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('To transcend IT and non-IT boundaries, becoming a pioneering technology leader.'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.flag, color: Colors.green[700]),
                            SizedBox(width: 8),
                            Text('Our Mission', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('To deliver customer-centric, cost-competitive IT and non-IT solutions including web development, mobile apps, and more.'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          // Team/Leadership Section
          Center(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Text('Our Leadership', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.blue[900])),
                  SizedBox(height: 24),
                  Wrap(
                    spacing: 32,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: [
                      _teamCard(
                        'assets/images/founder_placeholder.png',
                        'Vemu Samson',
                        'Founder & CEO',
                        () => _showTeamDetails(context, 'Vemu Samson', 'Founder & CEO with 20+ years in tech innovation.'),
                      ),
                      _teamCard(
                        'assets/images/manager_placeholder.png',
                        'Vemu Hepsiba Sravani',
                        'Managing Director',
                        () => _showTeamDetails(context, 'Vemu Hepsiba Sravani', 'Managing Director overseeing strategic growth.'),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  Text(
                    'We foster innovation and learning, offering internship programs to bridge academics and industry.',
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey[800]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Navigate to internships page or show info
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Internship details coming soon!')),
                      );
                    },
                    child: Text('Internship Program Page', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[800], decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          // Call to Action
          Card(
            color: Colors.blue[900],
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text('Ready to Transform Your Business?', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  SizedBox(height: 12),
                  Text('Contact us today to discuss your project!', style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.center),
                  SizedBox(height: 18),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/contact'),
                    icon: Icon(Icons.chat),
                    label: Text('Contact Us'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutCard(String title, String description) {
    return SizedBox(
      width: 340,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blueGrey[900],
                  letterSpacing: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Text(
                description,
                style: TextStyle(fontSize: 15, color: Colors.blueGrey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamCard(String imagePath, String name, String role, VoidCallback onTap) {
    return SizedBox(
      width: 260,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 120),
                  ),
                ),
                SizedBox(height: 16),
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 6),
                Text(role, style: TextStyle(fontSize: 15, color: Colors.blueGrey[700])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTeamDetails(BuildContext context, String name, String details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(name),
        content: Text(details),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}