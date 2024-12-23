// auth_service.dart
// Handles all Firebase Authentication operations
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  // Single instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get current authenticated user
  User? get currentUser => _auth.currentUser;

  // Listen to auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up new user
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create the user account
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create the user profile in Firestore
      await _createUserProfile(userCredential.user!.uid, {
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'jobseeker',
      });

      return userCredential;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Create user profile in Firestore
  Future<void> _createUserProfile(String userId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(userId).set(data);
  }

  // Handle authentication errors
  Exception _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          return Exception('This email is already registered');
        case 'weak-password':
          return Exception('Password is too weak');
        case 'invalid-email':
          return Exception('Invalid email address');
        default:
          return Exception('Authentication failed');
      }
    }
    return Exception('An unexpected error occurred');
  }
}
```