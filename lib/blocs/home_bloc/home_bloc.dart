import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:todo_ex/data/all_tasks.dart';
import 'package:todo_ex/models/task.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final data = GetIt.I.get<AllTasks>();
  HomeBloc() : super(HomeInitial()) {
    data.loadTasks();
    on<ShowTasksEvent>((event, emit) {
      if (data.tasks.isNotEmpty) {
        emit(ShowTasksState(tasks: data.tasks));
      }
    });

    on<CompleteTaskEvent>((event, emit) {
      data.changeState(task: event.task);
      log('${event.task.title} is changed to ${event.task.isCompleted}');
      emit(ShowTasksState(tasks: data.tasks));
    });

    on<DeleteTaskEvent>((event, emit) {
      data.deleteTask(task: event.task);
      log('${event.task.title} is DELETED');
      emit(ShowTasksState(tasks: data.tasks));
    });

    on<EditTaskEvent>((event, emit) {
      String oldtitle = event.task.title;
      data.editTask(task: event.task, newTitle: event.newTitle);
      log('task $oldtitle is changed to ${event.task.title}');
      emit(ShowTasksState(tasks: data.tasks));
    });
  }
}