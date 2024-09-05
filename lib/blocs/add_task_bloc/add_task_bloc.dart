import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_ex/data/all_tasks.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final data = GetIt.I.get<AllTasks>();
  AddTaskBloc() : super(AddTaskInitial()) {
    on<AddNewTaskEvent>((event, emit) {
      data.addTask(title: event.title, category: event.catgeory);
    });

    on<LoadCategoriesEvent>((event, emit) {
      emit(LoadCategoriesState(categories: data.categories));
    });
  }
}
