import 'package:flutter/material.dart';
import 'package:imake/tasks/data/local/model/task_model.dart';
import 'package:imake/tasks/data/local/model/user_model.dart';

@immutable
sealed class TasksEvent {}

class LoginEvent extends TasksEvent {
  final UserModel userModel;

  LoginEvent({required this.userModel});
}

class AddNewTaskEvent extends TasksEvent {
  final TaskModel taskModel;

  AddNewTaskEvent({required this.taskModel});
}

class FetchTaskEvent extends TasksEvent {}

class SortTaskEvent extends TasksEvent {
  final int sortOption;

  SortTaskEvent({required this.sortOption});
}

class UpdateTaskEvent extends TasksEvent {
  final TaskModel taskModel;

  UpdateTaskEvent({required this.taskModel});
}

class DeleteTaskEvent extends TasksEvent {
  final TaskModel taskModel;

  DeleteTaskEvent({required this.taskModel});
}

class SearchTaskEvent extends TasksEvent {
  final String keywords;

  SearchTaskEvent({required this.keywords});
}
