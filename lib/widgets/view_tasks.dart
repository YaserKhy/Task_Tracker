import 'package:flutter/material.dart';
import 'package:todo_ex/blocs/home_bloc/home_bloc.dart';
import 'package:todo_ex/globals/app_colors.dart';
import 'package:todo_ex/models/task.dart';
import 'package:todo_ex/widgets/task_card.dart';
import 'package:todo_ex/widgets/user_input.dart';

class ViewTasks extends StatelessWidget {
  final List<Task> tasks;
  final List<Task> completedTasks;
  final List<Task> unCompletedTasks;
  final dynamic bloc;
  const ViewTasks({super.key, required this.tasks, required this.completedTasks, required this.unCompletedTasks, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Total Tasks : ${tasks.length}"),
            Text("Completed : ${completedTasks.length}"),
            Text("Incompleted : ${unCompletedTasks.length}"),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task currentTask = tasks[index];
              return TaskCard(
                task: currentTask,
                onChanged: (v) {
                  bloc.add(CompleteTaskEvent(task: currentTask));
                },
                onDelete: () {
                  bloc.add(DeleteTaskEvent(task: currentTask));
                },
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController editController = TextEditingController();
                      return AlertDialog(
                        title: const Text("Edit Task"),
                        content: UserInput(titleController: editController,mode: 'edit'),
                        actions: [
                          ElevatedButton(
                            style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(mainColor)),
                            onPressed: () {
                              bloc.add(EditTaskEvent(task: currentTask, newTitle: editController.text));
                              Navigator.pop(context);
                            },
                            child: const Text("Edit Task",style: TextStyle(color: Colors.white))
                          )
                        ],
                      );
                    }
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}