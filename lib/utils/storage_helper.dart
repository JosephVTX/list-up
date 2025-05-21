// lib/utils/storage_helper.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/task.dart';

class StorageHelper {
  static const String _tasksKey = 'tasks'; // Key for storing tasks
  static const String _categoriesKey =
      'categories'; // Key for storing categories

  // Load tasks from local storage
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_tasksKey); // Get the JSON string
    if (tasksString == null) {
      return []; // Return an empty list if no data is found
    }
    // Decode the JSON string into a list of maps, then convert to Task objects
    final List<dynamic> taskMaps = jsonDecode(tasksString);
    return taskMaps.map((map) => Task.fromJson(map)).toList();
  }

  // Save tasks to local storage
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the list of Task objects to a list of JSON maps, then encode to a string
    final tasksString = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_tasksKey, tasksString); // Save the string
  }

  // Load categories from local storage
  static Future<List<Category>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesString = prefs.getString(_categoriesKey);
    if (categoriesString == null) {
      // Return a default list of categories if none are saved
      return [
        Category(id: '1', name: 'Personal', icon: 'person', taskCount: 0),
        Category(id: '2', name: 'Tareas', icon: 'assignment', taskCount: 0),
        Category(id: '3', name: 'Trabajo', icon: 'work', taskCount: 0),
        Category(
          id: '4',
          name: 'Finanzas',
          icon: 'account_balance_wallet',
          taskCount: 0,
        ),
        Category(id: '5', name: 'Salud', icon: 'healing', taskCount: 0),
      ];
    }
    final List<dynamic> categoryMaps = jsonDecode(categoriesString);
    return categoryMaps.map((map) => Category.fromJson(map)).toList();
  }

  // Save categories to local storage
  static Future<void> saveCategories(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesString = jsonEncode(
      categories.map((category) => category.toJson()).toList(),
    );
    await prefs.setString(_categoriesKey, categoriesString);
  }
}
