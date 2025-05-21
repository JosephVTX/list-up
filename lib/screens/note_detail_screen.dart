// lib/screens/note_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/task.dart'; // Import the Task model

class NoteDetailScreen extends StatelessWidget {
  final Task task; // The task data to display in detail

  const NoteDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title), // Use the task title as the app bar title
        backgroundColor: Colors.lightBlue[50], // Match the task item color
        elevation: 0, // No shadow for the app bar
      ),
      backgroundColor: Colors.white, // White background for the screen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the full description
            Text(
              task.description,
              style: const TextStyle(
                fontSize: 16.0,
                height: 1.5, // Line spacing
              ),
            ),
            const SizedBox(height: 20.0),
            // Display checklist items if any
            if (task.checklistItems.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Checklist:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Iterate and display each checklist item
                  Column(
                    children:
                        task.checklistItems.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                // Simple checkbox (simulated)
                                Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  // Allow text to wrap
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            // You can add more details here if needed (e.g., date, priority)
          ],
        ),
      ),
    );
  }
}
