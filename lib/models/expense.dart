// Expense Data Structure for the app

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final formatter = DateFormat.yMd();

// random expense id
const uuid = Uuid();

// expense category enum
enum Category { food, travel, leisure, work }

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  // Class Constructor
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); // initializer for the class creates an id for each expense

  // Single Expense Properties
  final String id;
  final DateTime date;
  final String title;
  final double amount;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
