class Event {
  final String id;
  final String title;
  final DateTime dateTime;
  final String location;
  final String? description;
  final String imageUrl;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as String,
      title: map['title'] as String,
      dateTime: DateTime.parse(map['date_time'] as String),
      location: map['location'] as String,
      description: map['description'] as String?,
      imageUrl: map['image_url'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
