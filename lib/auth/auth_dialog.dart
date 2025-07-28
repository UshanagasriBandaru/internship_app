import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import '../widgets/loading_overlay.dart';

class AuthDialog extends StatefulWidget {
  final bool isLogin;
  const AuthDialog({this.isLogin = true});
  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loadingOverlay = Provider.of<LoadingOverlayProvider>(context, listen: false);
    return AlertDialog(
      title: Text(widget.isLogin ? 'Login' : 'Sign Up'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (val) => email = val,
              validator: (val) => val != null && val.contains('@') ? null : 'Enter a valid email',
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (val) => password = val,
              validator: (val) => val != null && val.length >= 6 ? null : 'Min 6 chars',
            ),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(error, style: TextStyle(color: Colors.red)),
              ),
            // Remove the local loading spinner
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
        ElevatedButton(
          onPressed: loading
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                      error = '';
                    });
                    loadingOverlay.show('Please wait...');
                    try {
                      if (widget.isLogin) {
                        await authProvider.login(email, password);
                      } else {
                        await authProvider.signup(email, password);
                      }
                      loadingOverlay.hide();
                      Navigator.pop(context);
                    } catch (e) {
                      loadingOverlay.hide();
                      setState(() {
                        error = e.toString();
                        loading = false;
                      });
                    }
                  }
                },
          child: Text(widget.isLogin ? 'Login' : 'Sign Up'),
        ),
      ],
    );
  }
} 