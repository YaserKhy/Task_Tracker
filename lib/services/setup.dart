import 'package:get_it/get_it.dart';
import 'package:todo_ex/data/all_tasks.dart';

void setup() {
  // service locator pattern "singleton" : creates a single instance that is reused each time it is requested
  GetIt.I.registerSingleton<AllTasks>(AllTasks());
}