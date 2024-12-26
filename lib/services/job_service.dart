import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_connect/models/job.dart';

class JobService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all jobs with pagination
  Stream<List<Job>> getJobs({
    int limit = 10,
    DocumentSnapshot? startAfter,
    Map<String, dynamic>? filters,
  }) {
    Query query =
        _db.collection('jobs').orderBy('postedDate', descending: true);

    if (filters != null) {
      if (filters['type'] != null) {
        query = query.where('type', isEqualTo: filters['type']);
      }
      if (filters['location'] != null) {
        query = query.where('location', isEqualTo: filters['location']);
      }
      // Add more filters as needed
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    return query.limit(limit).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Job.fromMap({
          ...data,
          'id': doc.id,
        });
      }).toList();
    });
  }

  // Get saved jobs for a user
  Stream<List<Job>> getSavedJobs(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('savedJobs')
        .snapshots()
        .asyncMap((snapshot) async {
      List<Job> jobs = [];
      for (var doc in snapshot.docs) {
        final jobDoc = await _db.collection('jobs').doc(doc.id).get();
        if (jobDoc.exists) {
          jobs.add(Job.fromMap(jobDoc.data()!));
        }
      }
      return jobs;
    });
  }

  // Save/unsave a job
  Future<void> toggleSaveJob(String userId, String jobId) async {
    final docRef =
        _db.collection('users').doc(userId).collection('savedJobs').doc(jobId);

    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({'savedAt': FieldValue.serverTimestamp()});
    }
  }

  // Apply for a job
  Future<void> applyForJob(
      String userId, String jobId, Map<String, dynamic> application) async {
    await _db
        .collection('jobs')
        .doc(jobId)
        .collection('applications')
        .doc(userId)
        .set({
      ...application,
      'appliedAt': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
  }
}
