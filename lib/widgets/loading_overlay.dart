import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ ADD THIS

class LoadingOverlayProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _message;

  bool get isLoading => _isLoading;
  String? get message => _message;

  void show([String? message]) {
    _isLoading = true;
    _message = message;
    notifyListeners();
  }

  void hide() {
    _isLoading = false;
    _message = null;
    notifyListeners();
  }
}

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  const LoadingOverlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<LoadingOverlayProvider>(
          builder: (context, loading, _) {
            if (!loading.isLoading) return SizedBox.shrink();
            return Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    if (loading.message != null) ...[
                      SizedBox(height: 16),
                      Text(
                        loading.message!,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
