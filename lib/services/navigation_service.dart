import 'package:flutter/material.dart';

class NavigationService {
  static void navigateToHome(BuildContext context) {
    // For now, we'll navigate directly to home for testing
    Navigator.pushReplacementNamed(context, '/home');
  }

  static void navigateToAuth(BuildContext context) {
    // Navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}
