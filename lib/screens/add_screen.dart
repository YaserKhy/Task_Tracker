import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:todo_ex/blocs/add_task_bloc/add_task_bloc.dart';
import 'package:todo_ex/data/all_tasks.dart';
import 'package:todo_ex/extensions/screen_size.dart';
import 'package:todo_ex/globals/app_colors.dart';
import 'package:todo_ex/widgets/task_tracker_app_bar.dart';
import 'package:todo_ex/widgets/user_input.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = GetIt.I.get<AllTasks>().categories;
    String selectedCategory = GetIt.I.get<AllTasks>().categories.first;
    return BlocProvider(
      create: (context) => AddTaskBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AddTaskBloc>();
        bloc.add(LoadCategoriesEvent());
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), context.getHeight(divideBy: MediaQuery.orientationOf(context) == Orientation.landscape ? 10 : 15)),
            child: const TaskTrackerAppBar(back: true)
          ),
          body: Padding(
            padding: MediaQuery.orientationOf(context) == Orientation.landscape ? const EdgeInsets.symmetric(horizontal: 200) : const EdgeInsets.all(20),
            child: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                if(state is LoadCategoriesState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text("Add new task",style: TextStyle(fontSize: 23,color: Colors.black,fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: context.getHeight() > 1000 ? null : 60,
                        child: UserInput(titleController: bloc.titleController, mode: 'new'),
                      ),
                      const SizedBox(height: 10,),
                      const Text("Choose Category",style: TextStyle(fontSize: 23,color: Colors.black,fontWeight: FontWeight.w500),),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: 120,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: textFieldColor,border: Border.all(color: Colors.black87),borderRadius: BorderRadius.circular(4)),
                            child: DropdownButton(
                              isExpanded: true,
                              elevation: 3,
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: textFieldColor,
                              padding: EdgeInsets.zero,
                              value: selectedCategory,
                              items: List.generate(categories.length, (index) {
                                return DropdownMenuItem(
                                  value: categories[index],
                                  child: Text(categories[index],style: const TextStyle(color: Colors.black))
                                );
                              }),
                              onChanged: (v) {
                                selectedCategory = v!;
                                bloc.add(LoadCategoriesEvent());
                              }
                            ),
                          ),
                          const SizedBox(width: 20,),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white,),
                            style: const ButtonStyle(
                              shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                              backgroundColor:WidgetStatePropertyAll(mainColor)
                            ),
                            onPressed: ()=> showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: const Text("Add category"),
                                content: TextField(
                                  controller: bloc.categoryController,
                                  decoration: const InputDecoration(filled: true,fillColor: textFieldColor)
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  ElevatedButton(
                                    style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(mainColor)),
                                    onPressed: () {
                                      GetIt.I.get<AllTasks>().addCategory(category:bloc.categoryController.text);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Add category",style: TextStyle(color: Colors.white))
                                  )
                                ],
                              );
                            }),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          style: const ButtonStyle(backgroundColor:WidgetStatePropertyAll(mainColor)),
                          onPressed: () {
                            bloc.add(AddNewTaskEvent(catgeory: selectedCategory,title: bloc.titleController.text));
                            Navigator.pop(context);
                          },
                          child: const Text("Add Task",style: TextStyle(color: Colors.white))
                        ),
                      ),
                    ],
                  );
                }
                return const Text("data");
              },
            ),
          ),
        );
      }),
    );
  }
}