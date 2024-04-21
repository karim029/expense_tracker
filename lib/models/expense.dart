// Expense Data Structure for the app

import 'package:uuid/uuid.dart';

// random expense id
const uuid = Uuid();

// expense category enum
enum Category { food, travel, leisure, work }

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
}
