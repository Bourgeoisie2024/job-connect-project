import 'package:flutter/material.dart';
import 'package:job_connect/theme/app_theme.dart';
import 'package:job_connect/screens/splash_screen.dart';
import 'package:job_connect/navigation/app_navigation.dart';
import 'package:job_connect/screens/auth/login_screen.dart';
import 'package:job_connect/screens/job/job_details_screen.dart';
import 'package:job_connect/models/job.dart'; // Add this import to define the job found here (final job = settings.arguments as Job;)
import 'package:job_connect/navigation/page_transitions.dart';

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
      // We'll handle navigation in the SplashScreen
      home: const SplashScreen(), // Initial screen of the app
      // After authentication, navigate to AppNavigation
      // Define named routes for cleaner navigation
      // Use onGenerateRoute for dynamic routes like job details
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return FadePageRoute(page: const AppNavigation());
          case '/login':
            return SlidePageRoute(page: const LoginScreen());
          case '/job-details':
            final job = settings.arguments as Job;
            return SlidePageRoute(page: JobDetailsScreen(job: job));
          default:
            return null;
        }
      },
    );
  }
}
