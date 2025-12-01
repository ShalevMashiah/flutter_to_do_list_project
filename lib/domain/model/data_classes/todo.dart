class Todo {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  final DateTime? createdAt;
  final DateTime? completedAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    DateTime? createdAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Todo copyWith({
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt,
    );
  }
}
