import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Product {
  final IconData icon;
  final String title;
  final String description;
  final String overview;
  final List<String> features;
  Product({required this.icon, required this.title, required this.description, required this.overview, required this.features});
}

final List<Product> allProducts = [
  Product(
    icon: Icons.local_hospital,
    title: 'Hospital Management System',
    description: 'A comprehensive solution for healthcare administration.',
    overview: 'A comprehensive solution for healthcare administration, integrating patient records, appointments, and billing.',
    features: ['Streamlined operations', 'Improved patient care', 'Efficient workflow management'],
  ),
  Product(
    icon: Icons.shopping_cart,
    title: 'E-commerce Application for Online Grocery Store',
    description: 'An intuitive e-commerce platform for grocery shopping.',
    overview: 'An intuitive e-commerce platform tailored for online grocery shopping.',
    features: ['Easy product search', 'Secure payments', 'Efficient order processing'],
  ),
  Product(
    icon: Icons.school,
    title: 'School Management System',
    description: 'A robust system to enhance educational institution efficiency.',
    overview: 'A robust system designed to enhance the efficiency of educational institutions.',
    features: ['Student record management', 'Attendance and grading', 'Enhanced communication'],
  ),
  Product(
    icon: Icons.train,
    title: 'Electrical Amenities System for South Central Railway',
    description: 'Optimized electrical operations for railway infrastructure.',
    overview: 'An innovative system for South Central Railway to manage electrical infrastructure.',
    features: ['Optimized operations', 'Reliable infrastructure management'],
  ),
  Product(
    icon: Icons.medical_services,
    title: 'Pharma Management System',
    description: 'Optimizes pharmaceutical operations.',
    overview: 'A system to optimize pharmaceutical operations, from inventory to prescriptions.',
    features: ['Efficient inventory control', 'Prescription management', 'Streamlined operations'],
  ),
  Product(
    icon: Icons.receipt_long,
    title: 'Billing Management System',
    description: 'A tool for invoicing, payment tracking, and financial reporting.',
    overview: 'A versatile tool for managing invoicing, payment tracking, and financial reporting.',
    features: ['Revenue and expense management', 'Efficient invoicing', 'Comprehensive reporting'],
  ),
  Product(
    icon: Icons.laptop_chromebook,
    title: 'Learning Management System',
    description: 'An advanced platform for online education.',
    overview: 'An advanced platform for online education and e-learning.',
    features: ['Course management', 'Progress tracking', 'Interactive modules'],
  ),
];

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LTAppBar(title: 'Our Products'),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2, // Index for Products
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/about');
              break;
            case 2:
              // Already on Products, no action needed
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
        padding: EdgeInsets.zero,
        children: [
          // Hero Section
          Stack(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/company_logo.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              Container(
                height: 220,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Our Products',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tailored solutions to address diverse operational challenges.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          // Product Cards
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
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75, // Adjusted for better height
                  ),
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) {
                    final product = allProducts[index];
                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue[50],
                                child: Icon(product.icon, color: Colors.blue[700], size: 28),
                                radius: 24,
                              ),
                              SizedBox(height: 8),
                              Text(
                                product.title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueGrey[900]),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  product.description,
                                  style: TextStyle(fontSize: 12, color: Colors.blueGrey[700]),
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => setState(() => selectedIndex = index),
                                child: Text('Learn More'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
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
          SizedBox(height: 32),
          // Product Details
          if (selectedIndex != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue[50],
                            child: Icon(allProducts[selectedIndex!].icon, color: Colors.blue[700], size: 24),
                            radius: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              allProducts[selectedIndex!].title,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue[900]),
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() => selectedIndex = null),
                            icon: Icon(Icons.close, color: Colors.blueGrey[400]),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Overview:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[800]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        allProducts[selectedIndex!].overview,
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey[700], height: 1.5),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Features:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[800]),
                      ),
                      SizedBox(height: 8),
                      ...allProducts[selectedIndex!].features.map((f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.check_circle, color: Colors.green[600], size: 16),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                f,
                                style: TextStyle(fontSize: 14, color: Colors.blueGrey[700], height: 1.3),
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => setState(() => selectedIndex = null),
                          child: Text('Back to Products'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ],
      ),
    );
  }
}