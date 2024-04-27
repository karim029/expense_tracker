import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final String prefixText;

  const ReusableTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.keyboardType = TextInputType.text,
      this.prefixText = ''});

  @override
  Widget build(BuildContext context) {
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

class ReusableButtons extends StatelessWidget {
  final void Function() onCancelPressed;
  final void Function() onSavePressed;
  final String cancelText;
  final String saveText;

  const ReusableButtons(
      {super.key,
      required this.onCancelPressed,
      required this.onSavePressed,
      this.cancelText = 'Cancel',
      this.saveText = 'Save Expense'});

  @override
  Widget build(BuildContext context) {
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
