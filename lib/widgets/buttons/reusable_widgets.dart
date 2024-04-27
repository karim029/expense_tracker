// Import necessary packages
import 'package:flutter/material.dart';

// Define the ReusableTextField widget as a StatelessWidget
class ReusableTextField extends StatelessWidget {
  // Constructor for the ReusableTextField widget
  const ReusableTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.prefixText = '',
  });

  // Define the controller property
  final TextEditingController controller;

  // Define the label property
  final String label;

  // Define the keyboardType property
  final TextInputType keyboardType;

  // Define the prefixText property
  final String prefixText;

  // Build the widget tree for the ReusableTextField widget
  @override
  Widget build(BuildContext context) {
    // Return the TextField widget with the specified properties
    return TextField(
      controller: controller,
      maxLength: 50,
      decoration: InputDecoration(
        prefixText: prefixText,
        label: Text(label),
      ),
      keyboardType: keyboardType,
    );
  }
}

// Define the ReusableButtons widget as a StatelessWidget
class ReusableButtons extends StatelessWidget {
  // Constructor for the ReusableButtons widget
  const ReusableButtons({
    super.key,
    required this.onCancelPressed,
    required this.onSavePressed,
    this.cancelText = 'Cancel',
    this.saveText = 'Save Expense',
  });

  // Define the onCancelPressed property
  final void Function() onCancelPressed;

  // Define the onSavePressed property
  final void Function() onSavePressed;

  // Define the cancelText property
  final String cancelText;

  // Define the saveText property
  final String saveText;

  // Build the widget tree for the ReusableButtons widget
  @override
  Widget build(BuildContext context) {
    // Return the Row widget with the specified properties
    return Row(
      children: [
        const Spacer(),
        TextButton(
          onPressed: onCancelPressed,
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: onSavePressed,
          child: Text(saveText),
        ),
      ],
    );
  }
}