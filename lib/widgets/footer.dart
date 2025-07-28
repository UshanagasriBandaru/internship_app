import 'package:flutter/material.dart';

class LTAppFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      color: Colors.blueGrey[50],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '© 2024 Lineysha & Thevan Software Technologies',
            style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                child: Text('About Us'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/services'),
                child: Text('Services'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                child: Text('Contact'),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 