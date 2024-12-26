import 'package:flutter/material.dart';
import 'package:job_connect/models/job.dart';
import 'package:job_connect/widgets/job_card.dart';
import 'package:job_connect/widgets/search_bar.dart';
import 'package:job_connect/widgets/filter_bottom_sheet.dart';
import 'package:job_connect/widgets/animated_list_item.dart';
import 'package:provider/provider.dart';
import 'package:job_connect/providers/job_provider.dart';
import 'package:job_connect/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  JobFilter _currentFilter = JobFilter(jobTypes: []);

  @override
  void initState() {
    super.initState();
    _loadJobs();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadJobs() async {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    await jobProvider.loadJobs();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      if (!jobProvider.isLoading && jobProvider.hasMore) {
        jobProvider.loadMoreJobs();
      }
    }
  }

  void _handleSearch(String query) {
    // Implement search functionality
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
              _loadJobs(); // Reload jobs with new filters
            });
          },
        ),
      ),
    );
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
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${authProvider.user?.displayName ?? 'User'}!',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Find your dream job',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            authProvider.user?.photoURL ??
                                'https://ui-avatars.com/api/?name=${authProvider.user?.displayName ?? 'User'}&background=random',
                          ),
                        ),
                      ],
                    ),
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
              child: Consumer<JobProvider>(
                builder: (context, jobProvider, _) {
                  if (jobProvider.isLoading && jobProvider.jobs.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (jobProvider.jobs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.work_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No jobs found',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        jobProvider.jobs.length + (jobProvider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == jobProvider.jobs.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return AnimatedListItem(
                        index: index,
                        child: JobCard(
                          job: jobProvider.jobs[index],
                          onSave: () {
                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            jobProvider.toggleSaveJob(
                              authProvider.user!.uid,
                              jobProvider.jobs[index].id,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
