import 'package:get_storage/get_storage.dart';
import 'package:todo_ex/models/task.dart';

// class to represent tasks data and methods
class AllTasks {
  // constructor to load saved categories and tasks
  // this won't get executed in the first time launch since there are no saved tasks and categories
  AllTasks() {loadCategories(); loadTasks();}
  
  // lists to store tasks and categories "acts like a bridge between app and storage"
  List<Task> tasks = [];
  List<String> categories = ['default'];
  
  // box to store tasks and categories
  final box = GetStorage();
  
  // ---------- methods of tasks list ----------
  // method to add task
  addTask({required String title, required String category}) {
    tasks.add(Task.fromJson(
      {
        'id' : tasks.isEmpty ? 1 : tasks.last.id+1,
        'title' : title,
        'category' : category,
        'isCompleted' : false,
      }
    ));
    saveTasks();
  }

  // method to save tasks
  saveTasks() async {
    await box.write('tasks', tasks.map((task)=>task.toJson()).toList());
  }

  // method to load saved tasks
  loadTasks() {
    if(box.hasData('tasks')) {
      List<Map<String,dynamic>> tasksAsJson = List.from(box.read('tasks')).cast<Map<String,dynamic>>();
      for(var task in tasksAsJson) {
        tasks.add(Task.fromJson(task));
      }
    }
  }

  // ---------- methods of categories list ----------
  // method to add category
  addCategory({required String category}) {
    categories.add(category);
    saveCategories();
  }

  // method to save categories
  saveCategories() async {
    await box.write("categories", categories);
  }

  // method to load saved categories
  loadCategories() {
    if(box.hasData('categories')) {
      categories = List.from(box.read('categories').cast<String>());
    }
  }

  // ---------- methods of a single task ----------
  // method to change a task state
  changeState({required Task task}) {
    task.isCompleted = !task.isCompleted;
    saveTasks();
  }

  // method to delete task
  deleteTask({required Task task}) {
    tasks.remove(task);
    saveTasks();
  }

  // method to edit task
  editTask({required Task task, required String newTitle}) {// get index of old task
    task.title = newTitle;
    saveTasks();
  }
}