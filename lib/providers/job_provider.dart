import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_connect/models/job.dart';
import 'package:job_connect/services/job_service.dart';

class JobProvider extends ChangeNotifier {
  final JobService _jobService = JobService();
  List<Job> _jobs = [];
  List<Job> _savedJobs = [];
  bool _isLoading = false;
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;

  List<Job> get jobs => _jobs;
  List<Job> get savedJobs => _savedJobs;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  // Load initial jobs
  Future<void> loadJobs({Map<String, dynamic>? filters}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('jobs')
          .orderBy('postedDate', descending: true)
          .limit(10)
          .get();

      _jobs = snapshot.docs.map((doc) => Job.fromMap(doc.data())).toList();
      _lastDocument = snapshot.docs.last;
      _hasMore = snapshot.docs.length == 10;

      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load more jobs (pagination)
  Future<void> loadMoreJobs() async {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('jobs')
          .orderBy('postedDate', descending: true)
          .startAfterDocument(_lastDocument!)
          .limit(10)
          .get();

      final newJobs =
          snapshot.docs.map((doc) => Job.fromMap(doc.data())).toList();
      _jobs.addAll(newJobs);
      _lastDocument = snapshot.docs.last;
      _hasMore = snapshot.docs.length == 10;

      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load saved jobs for a user
  Future<void> loadSavedJobs(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _savedJobs = await _jobService.getSavedJobs(userId).first;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle save/unsave job
  Future<void> toggleSaveJob(String userId, String jobId) async {
    await _jobService.toggleSaveJob(userId, jobId);
    await loadSavedJobs(userId);
  }

  // Apply for a job
  Future<void> applyForJob(
      String userId, String jobId, Map<String, dynamic> application) async {
    await _jobService.applyForJob(userId, jobId, application);
  }
}
