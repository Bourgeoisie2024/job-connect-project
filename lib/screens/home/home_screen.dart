// Home screen with job listings and search
import 'package:flutter/material.dart';
import 'package:job_connect/models/job.dart';
import 'package:job_connect/widgets/job_card.dart';
import 'package:job_connect/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Temporary data - will be replaced with Firebase
  final List<Job> _jobs = [
    Job(
      id: '1',
      title: 'Senior Flutter Developer',
      company: 'Google',
      location: 'Mountain View, CA',
      salary: '\$120,000 - \$150,000',
      type: 'Full-time',
      description: 'We are looking for an experienced Flutter developer...',
      logoUrl: 'https://logo.clearbit.com/google.com',
      requirements: [
        'Bachelor\'s degree in Computer Science',
        '5+ years of Flutter experience',
        'Strong problem-solving skills'
      ],
      postedDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    // Add more sample jobs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, User!',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Find your dream job',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          'https://ui-avatars.com/api/?name=User&background=random',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const CustomSearchBar(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _jobs.length,
                itemBuilder: (context, index) {
                  return JobCard(job: _jobs[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
