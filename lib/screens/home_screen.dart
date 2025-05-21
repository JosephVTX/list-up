// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/task.dart';
import 'package:myapp/widgets/category_card.dart';
import 'package:myapp/widgets/task_item.dart';
import 'package:myapp/screens/note_detail_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/utils/storage_helper.dart'; // Import the storage helper
import 'package:uuid/uuid.dart'; // Add uuid for unique IDs (add dependency in pubspec.yaml)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> _categories = [];
  List<Task> _tasks = [];
  String? _selectedCategoryId;
  final Uuid _uuid = Uuid(); // Corrected: Removed const

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedCategories = await StorageHelper.loadCategories();
    final loadedTasks = await StorageHelper.loadTasks();
    setState(() {
      _categories = loadedCategories;
      _tasks = loadedTasks;
      _updateCategoryTaskCounts();
    });
  }

  Future<void> _saveData() async {
    await StorageHelper.saveTasks(_tasks);
    await StorageHelper.saveCategories(_categories);
  }

  void _updateCategoryTaskCounts() {
    // Recalculate counts from the current task list
    final Map<String, int> taskCountMap = {};
    for (var task in _tasks) {
      taskCountMap[task.categoryId] = (taskCountMap[task.categoryId] ?? 0) + 1;
    }
    // Update the taskCount for each category in the _categories list
    for (var category in _categories) {
      category.taskCount = taskCountMap[category.id] ?? 0;
    }
    // Save the updated categories with correct counts
    _saveData(); // Save after updating counts
  }

  List<Task> _getTasksForCategory() {
    if (_selectedCategoryId == null) {
      return _tasks;
    }
    return _tasks
        .where((task) => task.categoryId == _selectedCategoryId)
        .toList();
  }

  // Function to toggle task completion status
  void _toggleTaskCompletion(String taskId, bool? isCompleted) {
    setState(() {
      // Find the task by ID and update its completion status
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        _tasks[taskIndex].isCompleted = isCompleted ?? false;
        _saveData(); // Save data after updating a task
      }
    });
  }

  void _showAddTaskDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    // Ensure there's at least one category to select from
    String? selectedCategoryDropdownId =
        _categories.isNotEmpty ? _categories.first.id : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Nueva Tarea'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),
                // Dropdown to select category - Only show if categories exist
                if (_categories.isNotEmpty)
                  DropdownButtonFormField<String>(
                    value: selectedCategoryDropdownId,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    items:
                        _categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id,
                            child: Text(category.name),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      selectedCategoryDropdownId = newValue;
                    },
                  ),
                // Optional: Message if no categories are available
                if (_categories.isEmpty)
                  const Text('Crea una categoría primero para agregar tareas.'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newTask = Task(
                  id: _uuid.v4(),
                  // Assign to selected category or a default/placeholder if none exist
                  categoryId:
                      selectedCategoryDropdownId ??
                      'default', // Use 'default' or handle appropriately
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                );

                // Only add the task if a title is provided and a category could be assigned
                if (newTask.title.isNotEmpty &&
                        selectedCategoryDropdownId != null ||
                    _categories.isEmpty) {
                  setState(() {
                    _tasks.add(newTask);
                    _updateCategoryTaskCounts(); // Update counts after adding
                  });
                  // _saveData() is called within _updateCategoryTaskCounts
                  Navigator.pop(context);
                } else if (newTask.title.isEmpty) {
                  // Optionally show a message if the title is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'El título de la tarea no puede estar vacío.',
                      ),
                    ),
                  );
                } else if (_categories.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Debes crear una categoría antes de agregar tareas.',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog to add a new category
  void _showAddCategoryDialog() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Nueva Categoría'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre de la Categoría',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newCategoryName = nameController.text.trim();
                if (newCategoryName.isNotEmpty) {
                  setState(() {
                    // Create a new category with a unique ID and default icon/count
                    final newCategory = Category(
                      id: _uuid.v4(),
                      name: newCategoryName,
                      icon: 'folder', // Default icon
                      taskCount: 0,
                    );
                    _categories.add(newCategory);
                  });
                  _saveData(); // Save the updated categories
                  Navigator.pop(context);
                }
                // Optionally show an error if name is empty
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListUp'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () {
              // Simulate logout: Navigate back to the LoginScreen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Hola, David!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Aquí tienes tus pendientes hoy',
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Categorías',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length + 1,
              itemBuilder: (context, index) {
                if (index < _categories.length) {
                  final category = _categories[index];
                  return CategoryCard(
                    category: category,
                    onTap: () {
                      setState(() {
                        // Toggle category selection for filtering
                        if (_selectedCategoryId == category.id) {
                          _selectedCategoryId = null; // Deselect
                        } else {
                          _selectedCategoryId = category.id; // Select
                        }
                      });
                    },
                  );
                } else {
                  // "Add Category" button
                  return GestureDetector(
                    onTap: _showAddCategoryDialog, // Show add category dialog
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 30,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Agregar nueva categoría',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Mis pendientes del día',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getTasksForCategory().length,
              itemBuilder: (context, index) {
                final task = _getTasksForCategory()[index];
                return TaskItem(
                  task: task,
                  onTap: () {
                    // Navigate to the detail screen (no change here)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailScreen(task: task),
                      ),
                    );
                  },
                  onToggleComplete: (bool? isChecked) {
                    // Call the function to update task completion status
                    _toggleTaskCompletion(task.id, isChecked);
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Floating Action Button to Add Task
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
      // Bottom Navigation Bar (simulated)
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 30),
            label: 'Agregar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            _showAddTaskDialog(); // Show add task dialog on tapping "Agregar"
          }
          // TODO: Implement actions for other bottom navigation items (e.g., settings screen)
          if (index == 2) {
            print('Tapped Settings');
            // Example: Navigate to a placeholder settings screen
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
          }
        },
      ),
    );
  }
}
