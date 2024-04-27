import 'dart:io';

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/widgets.dart';
import 'package:expense_tracker/widgets/buttons/reusable_widgets.dart';
import 'package:flutter/cupertino.dart';

// This class creates a new expense form for the user to input expense details
class NewExpense extends StatefulWidget {
  const NewExpense({required this.onAddExpense, super.key});

  // This function is called when the user submits the form with valid input
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  // Text editing controller for the title input field
  final _titleController = TextEditingController();
  
  // Text editing controller for the amount input field
  final _amountController = TextEditingController();

  // Selected date for the expense
  DateTime? _selectedDate;

  // Selected category for the expense
  Category _selectedCategory = Category.leisure;

  // This function presents a date picker to the user
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // This function shows an error dialog to the user when the input is invalid
  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  // This function validates and submits the expense data
  void _submitExpenseData() {
    //data validation for the user input
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //show an error message using the device native features (cupertino for ios)
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constrains) {
      final width = constrains.maxWidth;
      var orientation = MediaQuery.of(context).orientation;

      return SizedBox(
        height: double.infinity,
        width: orientation == Orientation.landscape ? double.infinity : width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 30, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ReusableTextField(
                            controller: _titleController, label: 'Title'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: ReusableTextField(
                          controller: _amountController,
                          label: 'Amount',
                          keyboardType: TextInputType.number,
                          prefixText: '\$',
                        ),
                      ),
                    ],
                  )
                else
                  ReusableTextField(
                      controller: _titleController, label: 'Title'),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value as Category;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ReusableTextField(
                          controller: _amountController,
                          label: 'Amount',
                          keyboardType: TextInputType.number,
                          prefixText: '\$',
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  ReusableButtons(
                    onCancelPressed: () {
                      Navigator.pop(context);
                    },
                    onSavePressed: _submitExpenseData,
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value as Category;
                          });
                        },
                      ),
                      Expanded(
                        child: ReusableButtons(
                          onCancelPressed: () {
                            Navigator.pop(context);
                          },
                          onSavePressed: _submitExpenseData,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
