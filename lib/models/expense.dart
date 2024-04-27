// Expense Data Structure for the app

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// Define date formatter for consistent date display
final formatter = DateFormat.yMd();

// random expense id
const uuid = Uuid();

// expense category enum
enum Category { food, travel, leisure, work }

// Map to associate each category with an icon
const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  // Constructor for Expense class
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); // initializer for the class creates an id for each expense

   // Properties of an Expense
  final String id; // Unique identifier for the expense
  final DateTime date; // Date of the expense
  final String title; // Title or description of the expense
  final double amount; // Amount spent for the expense
  final Category category; // Category of the expense

  // Getter method to retrieve formatted date string
  String get formattedDate {
    return formatter.format(date); // Format date using defined formatter
  }
}

// Class representing a group of expenses based on category
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  final Category category; // Category of the expense bucket
  final List<Expense> expenses; // List of expenses within this bucket

  // Constructor to filter expenses based on category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  // Method to calculate total expenses within this bucket
  double get totalExpenses {
    double sum = 0;

    // Iterate through expenses and sum up their amounts
    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
