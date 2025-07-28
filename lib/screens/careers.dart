import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class Job {
  final IconData icon;
  final String title;
  final String description;
  Job({required this.icon, required this.title, required this.description});
}

final List<Job> jobs = [
  Job(icon: Icons.computer, title: 'FullStack Developer - Java', description: 'Develop end-to-end apps with Java, focusing on databases and frameworks.'),
  Job(icon: Icons.memory, title: 'Embedded Systems', description: 'Design embedded apps with hardware-software integration.'),
  Job(icon: Icons.security, title: 'Cyber Security', description: 'Learn security techniques and penetration testing.'),
  Job(icon: Icons.android, title: 'Python Developer', description: 'Build scalable apps with Python for web scraping and ML.'),
  Job(icon: Icons.design_services, title: 'Web Designer', description: 'Create user-friendly web designs with UI/UX tools.'),
  Job(icon: Icons.precision_manufacturing, title: 'Robotics', description: 'Build and program robots for real-world use.'),
  Job(icon: Icons.satellite_alt, title: 'Satellite Communication', description: 'Explore satellite systems and networking.'),
  Job(icon: Icons.cloud, title: 'Cloud Computing', description: 'Work on AWS, Azure, and cloud architecture.'),
  Job(icon: Icons.architecture, title: 'Auto CAD', description: 'Draft 2D/3D models for engineering projects.'),
  Job(icon: Icons.build_circle, title: 'Ultragraphics NX', description: 'Use CAD/CAM/CAE for product design and simulation.'),
];

class CareersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LTAppBar(title: 'Careers & Internships'),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          final List<String> routes = [
            '/home', '/about', '/products', '/services', '/careers', '/contact', '/profile'
          ];
          if (index >= 0 && index < routes.length && index != 4) {
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeroSection(),
          SizedBox(height: 36),
          _buildWhyJoinUs(),
          _buildApplyOptions(context),
          SizedBox(height: 36),
          _buildInternshipsList(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Stack(
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
                'Careers & Internships',
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
                'Unlock your potential with us',
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
    );
  }

  Widget _buildWhyJoinUs() {
    return Center(
      child: Column(
        children: [
          Text('Why Join Us?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue[800])),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Join a dynamic team where innovation meets opportunity. Gain hands-on experience and work on impactful projects.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 28),
          Divider(thickness: 1.2, indent: 60, endIndent: 60, color: Colors.blue[100]),
          SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget _buildApplyOptions(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Discover Opportunities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.blue[900])),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _opportunityCard(context, 'Apply via AICTE', Icons.verified, Colors.amber, () => _showApplyDialog(context, 'AICTE')),
                _opportunityCard(context, 'Apply via APSCHE', Icons.school, Colors.redAccent, () => _showApplyDialog(context, 'APSCHE')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternshipsList(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Our Internships', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.blue[900])),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Explore internships to gain experience and kickstart your career.',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: jobs.map((job) => _jobCard(context, job)).toList(),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _opportunityCard(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color, size: 28),
                radius: 24,
              ),
              SizedBox(width: 16),
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[900])),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: onTap,
                child: Text('Apply'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jobCard(BuildContext context, Job job) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/job/${job.title.toLowerCase().replaceAll(' ', '-')}'),
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
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  child: Icon(job.icon, color: Colors.blue[700], size: 40),
                  radius: 36,
                ),
                SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[900], letterSpacing: 0.5)),
                      SizedBox(height: 8),
                      Text(
                        job.description,
                        style: TextStyle(fontSize: 15, color: Colors.blueGrey[700], height: 1.4),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/job/${job.title.toLowerCase().replaceAll(' ', '-')}'),
                  child: Text('Apply Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showApplyDialog(BuildContext context, String platform) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apply via $platform'),
        content: Text('Please visit our official website or contact HR for the application process.'),
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
