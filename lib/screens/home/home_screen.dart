import 'package:flutter/material.dart';
import 'package:job_connect/models/job.dart';
import 'package:job_connect/widgets/job_card.dart';
import 'package:job_connect/widgets/search_bar.dart';
import 'package:job_connect/widgets/filter_bottom_sheet.dart';
import 'package:job_connect/widgets/animated_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Job> _allJobs = [
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

  List<Job> _filteredJobs = [];
  JobFilter _currentFilter = JobFilter(jobTypes: []);

  @override
  void initState() {
    super.initState();
    _filteredJobs = List.from(_allJobs);
  }

  void _handleSearch(String query) {
    setState(() {
      _filteredJobs = _allJobs.where((job) {
        final titleMatch =
            job.title.toLowerCase().contains(query.toLowerCase());
        final companyMatch =
            job.company.toLowerCase().contains(query.toLowerCase());
        final locationMatch =
            job.location.toLowerCase().contains(query.toLowerCase());
        return titleMatch || companyMatch || locationMatch;
      }).toList();
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FilterBottomSheet(
          initialFilter: _currentFilter,
          onApply: (filter) {
            setState(() {
              _currentFilter = filter;
              _applyFilters();
            });
          },
        ),
      ),
    );
  }

  void _applyFilters() {
    setState(() {
      _filteredJobs = _allJobs.where((job) {
        if (_currentFilter.jobTypes.isNotEmpty &&
            !_currentFilter.jobTypes.contains(job.type)) {
          return false;
        }
        if (_currentFilter.location != null &&
            _currentFilter.location!.isNotEmpty &&
            !job.location
                .toLowerCase()
                .contains(_currentFilter.location!.toLowerCase())) {
          return false;
        }
        // Add salary filter logic here if needed
        return true;
      }).toList();
    });
  }

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
                  CustomSearchBar(
                    onSearch: _handleSearch,
                    onFilterTap: _showFilterBottomSheet,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredJobs.length,
                itemBuilder: (context, index) {
                  return AnimatedListItem(
                    index: index,
                    child: JobCard(job: _filteredJobs[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
