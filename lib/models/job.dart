// Model class for Job listings
class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type; // Full-time, Part-time, etc.
  final String description;
  final String logoUrl;
  final List<String> requirements;
  final DateTime postedDate;
  final bool isSaved;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.description,
    required this.logoUrl,
    required this.requirements,
    required this.postedDate,
    this.isSaved = false,
  });

  // Will be used later with Firebase
  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'],
      title: map['title'],
      company: map['company'],
      location: map['location'],
      salary: map['salary'],
      type: map['type'],
      description: map['description'],
      logoUrl: map['logoUrl'],
      requirements: List<String>.from(map['requirements']),
      postedDate: DateTime.parse(map['postedDate']),
      isSaved: map['isSaved'] ?? false,
    );
  }
}
