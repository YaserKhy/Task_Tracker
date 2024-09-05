part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class LoadCategoriesState extends AddTaskState {
  final List<String> categories;
  LoadCategoriesState({required this.categories});
}