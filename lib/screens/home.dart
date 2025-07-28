import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showBackToTop = _scrollController.offset > 200;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      appBar: LTAppBar(title: 'Lineysha & Thevan'),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/about');
              break;
            case 2:
              Navigator.pushNamed(context, '/products');
              break;
            case 3:
              Navigator.pushNamed(context, '/services');
              break;
            case 4:
              Navigator.pushNamed(context, '/careers');
              break;
            case 5:
              Navigator.pushNamed(context, '/contact');
              break;
            case 6:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.blue[700],
              child: Icon(Icons.keyboard_arrow_up, color: Colors.white),
              elevation: 4,
            )
          : null,
      body: ListView(
        controller: _scrollController,
        children: [
          Stack(
            children: [
              Container(
                height: 340,
                width: double.infinity,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45),
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    'assets/images/company_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 340,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TRANSFORM YOUR IDEAS INTO POWERFUL DIGITAL EXPERIENCES.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Innovate. Build. Succeed.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'We deliver tailored software solutions for businesses of all sizes.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/contact'),
                      child: Text('Get Started'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Text('Why choose us?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.blue[900])),
                SizedBox(height: 8),
                Text(
                  'Transforming your challenges into innovative, tech-driven solutions for success.',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    _whyCard('💡', 'Innovative Solutions', 'We leverage the latest advancements in technology to offer solutions that drive business growth.'),
                    _whyCard('🏅', 'Expertise and Recognition', 'Our certifications underscore our commitment to quality.'),
                    _whyCard('👩‍💻', 'Tailored Services', 'We deliver customized solutions for each client.'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Text('Our Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.blue[900])),
                SizedBox(height: 8),
                Text('Explore our wide range of services designed to meet diverse business needs.', style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]), textAlign: TextAlign.center),
                SizedBox(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _serviceCard('assets/images/software_dev.png', 'Software Development', 'Custom solutions, web development, mobile apps.', () => Navigator.pushNamed(context, '/services')),
                      _serviceCard('assets/images/integration.png', 'System Integration', 'Enterprise and API integration.', () => Navigator.pushNamed(context, '/services')),
                      _serviceCard('assets/images/consulting.png', 'Consulting Services', 'IT and digital transformation strategies.', () => Navigator.pushNamed(context, '/services')),
                      _serviceCard('assets/images/data.png', 'Data Solutions', 'Data analytics and business intelligence.', () => Navigator.pushNamed(context, '/services')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Text('Our Motto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.blue[900])),
                SizedBox(height: 18),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          '“Pioneering Innovation in Technology”',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'This motto inspires our team to create innovative technology solutions that transform industries.',
                          style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _whyCard(String emoji, String title, String description) {
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(emoji, style: TextStyle(fontSize: 36)),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceCard(String imagePath, String title, String description, VoidCallback onPressed) {
    return Container(
      width: 340,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 80),
                ),
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 8),
                    Text(description, style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: onPressed,
                      child: Text('Learn more'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}