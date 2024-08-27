import 'package:flutter/material.dart';
import 'package:todo_ex/extensions/screen_size.dart';
import 'package:todo_ex/globals/app_colors.dart';
import 'package:todo_ex/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(bool?)? onChanged;
  final Function()? onDelete;
  final Function()? onEdit;
  const TaskCard(
      {super.key,
      required this.task,
      required this.onChanged,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.getWidth(divideBy: 30),
        vertical: context.getHeight(divideBy: 100)
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: textFieldColor,
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (v) => onChanged!(v)
          ),
          title: Text(
            task.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500
            )
          ),
          subtitle: Text(task.category,style: const TextStyle(fontSize: 15)),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onEdit,
                child: const Icon(Icons.edit,color: Colors.blue),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: onDelete,
                child: const Icon(Icons.close,color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}