// lib/models/category.dart
class Category {
  final String id;
  final String name;
  final String icon; // We'll use Material Icons names as strings
  int taskCount; // Make taskCount mutable to update it when adding tasks

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.taskCount,
  });

  // Convert a Category object to a JSON map
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'icon': icon, 'taskCount': taskCount};
  }

  // Create a Category object from a JSON map
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      taskCount: json['taskCount'],
    );
  }
}
