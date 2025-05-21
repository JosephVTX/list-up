// lib/widgets/task_item.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/task.dart'; // Import the Task model

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTap; // Function to call when the task is tapped
  final ValueChanged<bool?>
  onToggleComplete; // Function to call when checkbox is toggled

  const TaskItem({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleComplete, // Require the new callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:
              task.isCompleted
                  ? const Color.fromARGB(255, 154, 197, 158)
                  : const Color.fromARGB(255, 160, 206, 227), // Different color if completed
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          // Use a Row to place the checkbox and text side-by-side
          children: [
            // Checkbox to mark task as complete
            Checkbox(
              value: task.isCompleted,
              onChanged: onToggleComplete, // Call the provided callback
              activeColor: Colors.green, // Color when checked
            ),
            const SizedBox(width: 8.0),
            // Task details (Title and Description)
            Expanded(
              // Allow text to take remaining space and wrap
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      // Add strikethrough if completed
                      decoration:
                          task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey[600] : Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    task.description.isNotEmpty
                        ? task.description
                        : '${task.checklistItems.length} checklist items',
                    style: TextStyle(
                      fontSize: 14.0,
                      color:
                          task.isCompleted
                              ? Colors.grey[500]
                              : Colors.grey[700],
                      // Add strikethrough if completed
                      decoration:
                          task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // You could add more icons or widgets here
          ],
        ),
      ),
    );
  }
}
