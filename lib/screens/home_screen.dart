import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_ex/data/all_tasks.dart';
import 'package:todo_ex/extensions/screen_push.dart';
import 'package:todo_ex/globals/app_colors.dart';
import 'package:todo_ex/models/task.dart';
import 'package:todo_ex/screens/add_screen.dart';
import 'package:todo_ex/widgets/no_tasks_view.dart';
import 'package:todo_ex/widgets/task_card.dart';
import 'package:todo_ex/widgets/user_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController editController = TextEditingController();
  
  List<Task> tasks = GetIt.I.get<AllTasks>().tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "Task Tracker",
          style: GoogleFonts.signikaNegative(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700
          )
        )
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Total Tasks : ${tasks.length}"),
                Text("Completed : ${tasks.where((task)=>task.isCompleted==true).toList().length}"),
                Text("Incompleted : ${tasks.where((task)=>task.isCompleted==false).toList().length}"),
              ],
            ),
            tasks.isEmpty ? const NoTasksView()
            : Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  Task currentTask = tasks[index];
                  return TaskCard(
                    task: currentTask,
                    onChanged: (v){
                      GetIt.I.get<AllTasks>().changeState(task : currentTask);
                      setState(() {});
                    },
                    onDelete: (){
                      GetIt.I.get<AllTasks>().deleteTask(task: currentTask);
                      setState(() {});
                    },
                    onEdit: () {
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: const Text("Edit Task"),
                          content: UserInput(titleController: editController, mode: 'edit'),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(mainColor)),
                              onPressed: (){
                                GetIt.I.get<AllTasks>().editTask(task: currentTask, newTitle: editController.text);
                                setState(() {});
                                Navigator.pop(context,true);
                              },
                              child: const Text("Edit Task", style: TextStyle(color: Colors.white),)
                            )
                          ],
                        );
                      });
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        shape: const OvalBorder(),
        child: const Icon(Icons.add, size: 30,color: Colors.white,),
        onPressed: (){
          context.push(target: const AddScreen(),saveData: (p0) {
            if(p0 == true){
              setState(() {});
            }
          },);
        }),
    );
  }
}