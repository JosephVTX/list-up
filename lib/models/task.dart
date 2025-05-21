// lib/models/task.dart
class Task {
  final String id;
  String
  categoryId; // Make categoryId mutable in case we want to change categories later
  String title; // Make title mutable
  String description; // Make description mutable
  List<String> checklistItems; // Make checklistItems mutable
  bool isCompleted; // Make isCompleted mutable

  Task({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    this.checklistItems = const [],
    this.isCompleted = false,
  });

  // Convert a Task object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'checklistItems': checklistItems,
      'isCompleted': isCompleted,
    };
  }

  // Create a Task object from a JSON map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      categoryId: json['categoryId'],
      title: json['title'],
      description: json['description'],
      checklistItems: List<String>.from(
        json['checklistItems'] ?? [],
      ), // Handle null case
      isCompleted: json['isCompleted'] ?? false, // Handle null case
    );
  }
}
