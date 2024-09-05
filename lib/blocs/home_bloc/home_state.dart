part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ShowTasksState extends HomeState {
  final List<Task> tasks;
  final List<Task> completedTasks = GetIt.I.get<AllTasks>().tasks.where((task) => task.isCompleted == true).toList();
  final List<Task> unCompletedTasks = GetIt.I.get<AllTasks>().tasks.where((task) => task.isCompleted == false).toList();
  ShowTasksState({required this.tasks});
}