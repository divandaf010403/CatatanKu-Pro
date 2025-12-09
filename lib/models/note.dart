class Note {
  final String id;
  String title;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a new note with current timestamp
  factory Note.create({
    required String id,
    required String title,
    required String description,
  }) {
    final now = DateTime.now();
    return Note(
      id: id,
      title: title,
      description: description,
      createdAt: now,
      updatedAt: now,
    );
  }

  // Update note with new data and update timestamp
  void update({
    String? title,
    String? description,
  }) {
    if (title != null) this.title = title;
    if (description != null) this.description = description;
    updatedAt = DateTime.now();
  }

  // Convert note to map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  // Create note from map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }
}