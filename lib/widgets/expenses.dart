// Import necessary packages
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// Define the Expenses widget as a StatefulWidget
class Expenses extends StatefulWidget {
  // Constructor for the Expenses widget
  const Expenses({
    super.key,
  });

  // Create the state for the Expenses widget
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

// Define the state for the Expenses widget
class _ExpensesState extends State<Expenses> {
  // Initialize a list of registered expenses
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  // Function to open the add expense overlay
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  // Function to add an expense to the list of registered expenses
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Function to remove an expense from the list of registered expenses
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // Show a snackbar with the deleted expense
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 3,
        ),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  // Build the widget tree for the Expenses widget
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Initialize the main content widget
    Widget mainContent = const Center(
      child: Text('No expenses was found, start adding some!'),
    );

    // If there are registered expenses, display the ExpensesList widget
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    // Return the Scaffold widget with the app bar and body
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: width < 600
         ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _registeredExpenses,
                  ),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}