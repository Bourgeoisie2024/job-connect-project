class UserProfile {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String location;
  final List<String> skills;
  final String avatarUrl;

  UserProfile({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    required this.skills,
    required this.avatarUrl,
  });

  // Add fromMap constructor
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }

  // Add toMap method
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'email': email,
      'phone': phone,
      'location': location,
      'skills': skills,
      'avatarUrl': avatarUrl,
    };
  }

  // Add copyWith method
  UserProfile copyWith({
    String? name,
    String? title,
    String? email,
    String? phone,
    String? location,
    List<String>? skills,
    String? avatarUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      title: title ?? this.title,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      skills: skills ?? this.skills,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
