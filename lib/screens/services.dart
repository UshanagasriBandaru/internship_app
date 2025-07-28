import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class Service {
  final IconData icon;
  final String title;
  final String description;
  Service({required this.icon, required this.title, required this.description});
}

final List<Service> services = [
  Service(icon: Icons.code, title: 'Software Development', description: 'Custom solutions, web development, mobile apps, and integrations.'),
  Service(icon: Icons.device_hub, title: 'System Integration', description: 'Enterprise and API integration for streamlined operations.'),
  Service(icon: Icons.support_agent, title: 'Consulting Services', description: 'IT consulting and digital transformation strategies.'),
  Service(icon: Icons.analytics, title: 'Data Solutions', description: 'Data analytics, management, and business intelligence.'),
  Service(icon: Icons.cloud, title: 'Cloud Services', description: 'Cloud computing, migration, and security solutions.'),
  Service(icon: Icons.security, title: 'Cybersecurity', description: 'Security assessments, threat detection, and access control.'),
  Service(icon: Icons.precision_manufacturing, title: 'Robotics & Automation', description: 'RPA and custom robotics solutions.'),
  Service(icon: Icons.memory, title: 'Machine Learning & AI', description: 'ML models and AI for decision-making and efficiency.'),
  Service(icon: Icons.forum, title: 'Communication Solutions', description: 'Unified communication and collaboration tools.'),
  Service(icon: Icons.campaign, title: 'Digital Marketing', description: 'SEO, social media, and content marketing services.'),
  Service(icon: Icons.design_services, title: 'User Experience & UI Design', description: 'Intuitive UX and visually appealing UI design.'),
  Service(icon: Icons.settings_ethernet, title: 'IT Infrastructure Management', description: 'Network management and server optimization.'),
];

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      appBar: LTAppBar(title: 'Our Services'),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 3, // Index for Services
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
              // Already on Services, no action needed
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
                      'Our Services',
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
                      'Innovative technology solutions for your business',
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
          // Why Choose Us Section
          Center(
            child: Column(
              children: [
                Text('Why Choose Us?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue[800])),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'We blend technical expertise with a client-first approach to deliver innovative solutions that drive value. Our commitment to quality ensures your success.',
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
          // Services Grid Section
          Center(
            child: Column(
              children: [
                Text('Our Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.blue[900])),
                SizedBox(height: 10),
                Text('Explore our diverse services tailored to meet your business needs.', style: TextStyle(fontSize: 15, color: Colors.blueGrey[700]), textAlign: TextAlign.center),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      if (constraints.maxWidth > 1200) crossAxisCount = 4;
                      else if (constraints.maxWidth > 900) crossAxisCount = 3;
                      else if (constraints.maxWidth > 600) crossAxisCount = 2;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 1.5, // Adjusted for better proportion
                        ),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/service/${service.title.toLowerCase().replaceAll(' ', '-')}'),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
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
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue[50],
                                      child: Icon(service.icon, color: Colors.blue[700], size: 36),
                                      radius: 30,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      service.title,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[900], letterSpacing: 0.5),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      service.description,
                                      style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}