import 'package:flutter/material.dart';
import 'package:job_connect/models/user_profile.dart';
import 'package:job_connect/services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  UserProfile? _profile;
  bool _isLoading = false;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> loadProfile(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await _profileService.getUserProfile(userId);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(String userId, UserProfile profile) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _profileService.updateProfile(userId, profile);
      _profile = profile;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfilePicture(String userId, String imageUrl) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedUrl =
          await _profileService.updateProfilePicture(userId, imageUrl);
      _profile = _profile?.copyWith(avatarUrl: updatedUrl);
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
