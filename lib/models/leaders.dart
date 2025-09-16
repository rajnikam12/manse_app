class Leader {
  final String id;
  final String name;
  final String imageUrl;
  final String socialLink;
  final String role;
  final DateTime createdAt;

  Leader({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.socialLink,
    required this.role,
    required this.createdAt,
  });

  factory Leader.fromMap(Map<String, dynamic> map) {
    return Leader(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['image_url'] as String,
      socialLink: map['social_link'] as String,
      role: map['role'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
