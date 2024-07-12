import 'package:flutter/material.dart';
import 'package:imake/tasks/data/local/model/task_model.dart';
import 'package:imake/tasks/data/local/model/user_model.dart';

@immutable
sealed class TasksState {}

final class LoginSuccess extends TasksState {
  final UserModel model;

  LoginSuccess({required this.model});
}

final class LoginFailure extends TasksState {
  final String error;

  LoginFailure({required this.error});
}

final class FetchTasksSuccess extends TasksState {
  final List<TaskModel> tasks;
  final bool isSearching;

  FetchTasksSuccess({required this.tasks, this.isSearching = false});
}

final class AddTasksSuccess extends TasksState {}

final class LoadTaskFailure extends TasksState {
  final String error;

  LoadTaskFailure({required this.error});
}

final class AddTaskFailure extends TasksState {
  final String error;

  AddTaskFailure({required this.error});
}

final class TasksLoading extends TasksState {}

final class UpdateTaskFailure extends TasksState {
  final String error;

  UpdateTaskFailure({required this.error});
}

final class UpdateTaskSuccess extends TasksState {}
