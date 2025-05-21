// lib/widgets/category_card.dart
import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart'; // Import the Category model

class CategoryCard extends StatelessWidget {
  final Category category; // The category data to display
  final VoidCallback onTap; // Function to call when the card is tapped

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap events
      child: Container(
        width: 150, // Fixed width for the category card
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255), // White background
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          boxShadow: [
            // Subtle shadow for depth
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display the category icon (using a placeholder for now)
            Icon(Icons.folder, color: const Color.fromARGB(255, 27, 28, 96)),
            const SizedBox(height: 8.0),
            // Display the category name
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 5, 9, 18),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4.0),
            // Display the number of tasks
            Text(
              '${category.taskCount} tasks',
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
