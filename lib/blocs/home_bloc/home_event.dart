part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class ShowTasksEvent extends HomeEvent {}

final class CompleteTaskEvent extends HomeEvent {
  final Task task;
  CompleteTaskEvent({required this.task});
}

final class DeleteTaskEvent extends HomeEvent {
  final Task task;
  DeleteTaskEvent({required this.task});
}

final class EditTaskEvent extends HomeEvent {
  final Task task;
  final String newTitle;
  EditTaskEvent({required this.task, required this.newTitle});
}