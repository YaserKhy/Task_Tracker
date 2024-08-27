import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_ex/data/all_tasks.dart';
import 'package:todo_ex/extensions/screen_size.dart';
import 'package:todo_ex/globals/app_colors.dart';
import 'package:todo_ex/widgets/user_input.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  List<String> categories = GetIt.I.get<AllTasks>().categories;
  String selectedCategory = GetIt.I.get<AllTasks>().categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: const BackButton(color: Colors.white,),
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
      body: Padding(
        padding: MediaQuery.orientationOf(context) == Orientation.landscape ? const EdgeInsets.symmetric(horizontal: 200) : const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const Text("Add new task", style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),),
            const SizedBox(height: 10,),
            SizedBox(
              height: context.getHeight() > 1000 ? null : 60,
              child: UserInput(titleController: titleController, mode: 'new'),
            ),
            const SizedBox(height: 10,),
            const Text("Choose Category", style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),),
            const SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 120,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: textFieldColor, border: Border.all(color: Colors.black87), borderRadius: BorderRadius.circular(4)),
                  child: DropdownButton(
                    isExpanded: true,
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: textFieldColor,
                    padding: EdgeInsets.zero,
                    value: selectedCategory,
                    items: List.generate(categories.length, (index){
                      return DropdownMenuItem(
                        value: categories[index],
                        child: Text(categories[index],style: const TextStyle(color: Colors.black))
                      );
                    }),
                    onChanged: (v) {
                      selectedCategory = v!;
                      setState((){});
                    },
                  ),
                ),
                const SizedBox(width: 20,),
                IconButton(
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                    backgroundColor: WidgetStatePropertyAll(mainColor)
                  ),
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: const Text("Add category"),
                        content: TextField(
                          controller: categoryController,
                          decoration: const InputDecoration(filled: true,fillColor: textFieldColor),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(mainColor)),
                            onPressed: (){
                              GetIt.I.get<AllTasks>().addCategory(category: categoryController.text);
                              setState(() {});
                              Navigator.pop(context,true);
                            },
                            child: const Text("Add category", style: TextStyle(color: Colors.white),)
                          )
                        ],
                        actionsAlignment: MainAxisAlignment.center,
                      );
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white,)
                )
              ],
            ),
            const SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(mainColor)),
                onPressed: () {
                  GetIt.I.get<AllTasks>().addTask(title: titleController.text, category: selectedCategory);
                  Navigator.pop(context,true);
                },
                child: const Text("Add Task", style: TextStyle(color: Colors.white))
              ),
            ),
          ],
        ),
      ),
    );
  }
}