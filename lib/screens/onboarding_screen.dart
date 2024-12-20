// Onboarding screen to introduce app features to new users
import 'package:flutter/material.dart';
import 'package:job_connect/theme/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:job_connect/screens/auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding content
  final List<Map<String, String>> _pages = [
    {
      'title': 'Find Your Dream Job',
      'description':
          'Discover thousands of job opportunities with all the information you need.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Easy Application',
      'description':
          'Apply to jobs with just a few taps and track your applications in real-time.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Get Hired',
      'description':
          'Connect with top employers and take the next step in your career journey.',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _navigateToLogin(),
                child: const Text('Skip'),
              ),
            ),
            // Onboarding content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) => OnboardingPage(
                  title: _pages[index]['title']!,
                  description: _pages[index]['description']!,
                  image: _pages[index]['image']!,
                ),
              ),
            ),
            // Navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppTheme.primaryColor,
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                    ),
                  ),
                  // Next/Get Started button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        _navigateToLogin();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin() {
    // TODO: Implement navigation to login screen
    // Will be implemented when we create the auth screens
    // Now we have created the auth screens for login_screen, signup_screen and forgot_password_screen files
    // Now we need to update the OnboardingScreen to navigate to the LoginScreen when the user taps "Get Started" or "Skip":
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

// Individual onboarding page widget
class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Image.asset(
            image,
            height: 280,
          ),
          const SizedBox(height: 40),
          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
