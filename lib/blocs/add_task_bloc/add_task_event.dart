part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskEvent {}

final class AddNewTaskEvent extends AddTaskEvent{
  final String title;
  final String catgeory;
  AddNewTaskEvent({required this.catgeory, required this.title});
}

final class LoadCategoriesEvent extends AddTaskEvent {}