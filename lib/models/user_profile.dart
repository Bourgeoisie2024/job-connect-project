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
