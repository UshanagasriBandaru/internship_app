import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;
  bool _loading = false;

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final email = userCredential.user?.email ?? "";

      // ✅ Allow only specific admin
      if (email != "admin@gmail.com") {
        await FirebaseAuth.instance.signOut();
        setState(() => _error = "Access restricted to admin only.");
        return;
      }

      // ✅ Store session locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // ✅ Navigate
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => _error = 'Login failed. Please check your credentials.');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _forgotPassword() async {
    if (_emailController.text.trim().isEmpty) {
      setState(() => _error = "Please enter your email to reset password.");
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset link sent to your email.")),
      );
    } catch (e) {
      setState(() => _error = "Error sending reset email.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Admin Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _forgotPassword,
                    child: Text('Forgot Password?'),
                  ),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(_error!, style: TextStyle(color: Colors.red)),
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loading ? null : _login,
                  child: _loading ? CircularProgressIndicator(color: Colors.white) : Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void _login() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // <-- Save session

    Navigator.pushReplacementNamed(context, '/home');
  } catch (e) {
    setState(() => _error = 'Login failed. Please check your credentials.');
  }
}

