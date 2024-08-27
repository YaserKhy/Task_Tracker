import 'package:flutter/material.dart';
import 'package:todo_ex/globals/app_colors.dart';

class UserInput extends StatelessWidget {
  final TextEditingController titleController;
  final String mode;
  const UserInput({super.key, required this.titleController, required this.mode});

  @override
  Widget build(BuildContext context) {
    return TextField(
        onTapOutside: (event) {FocusManager.instance.primaryFocus?.unfocus();},
        minLines: 1,
        maxLines: 4,
        maxLength: 50,
        controller: titleController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          filled: true,
          fillColor: textFieldColor,
          labelText: mode!="edit" ? "Enter a task" : "Enter new name for task",
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ));
  }
}
