import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_connect/models/user_profile.dart';

class ProfileService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get user profile
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserProfile.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Update user profile
  Future<void> updateProfile(String userId, UserProfile profile) async {
    try {
      await _db.collection('users').doc(userId).update(profile.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Update profile picture
  Future<String> updateProfilePicture(String userId, String imageUrl) async {
    try {
      await _db.collection('users').doc(userId).update({
        'avatarUrl': imageUrl,
      });
      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }
}
