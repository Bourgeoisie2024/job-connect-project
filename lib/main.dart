// Main entry point for the JobConnect application
import 'package:flutter/material.dart';
import 'package:job_connect/theme/app_theme.dart';
import 'package:job_connect/screens/splash_screen.dart';

void main() {
  runApp(const JobConnectApp());
}

class JobConnectApp extends StatelessWidget {
  const JobConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobConnect',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: const SplashScreen(), // Initial screen of the app
    );
  }
}
