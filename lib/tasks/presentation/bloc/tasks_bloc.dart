import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imake/tasks/data/local/model/user_model.dart';
import 'package:imake/tasks/data/repository/login_repository.dart';
import 'package:imake/tasks/presentation/bloc/tasks_event.dart';
import 'package:imake/tasks/presentation/bloc/tasks_state.dart';
import '../../data/repository/task_repository.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;
  final LoginRepository loginRepository;

  TasksBloc(this.taskRepository, this.loginRepository)
      : super(FetchTasksSuccess(tasks: const [])) {
    on<LoginEvent>(_login);
    on<AddNewTaskEvent>(_addNewTask);
    on<FetchTaskEvent>(_fetchTasks);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SortTaskEvent>(_sortTasks);
    on<SearchTaskEvent>(_searchTasks);
  }

  _login(LoginEvent event, Emitter<TasksState> emit) async {
    try {
      //final user = await loginRepository.findUser(
      //event.userModel.name, event.userModel.password);

      //if (user == null) return emit(LoginFailure(error: "User não encontrado"));

      UserModel user = new UserModel(name: "admin", password: "admin");

      return emit(LoginSuccess(model: user));
    } catch (exception) {
      emit(LoginFailure(error: exception.toString()));
    }
  }

  _addNewTask(AddNewTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      if (event.taskModel.title.trim().isEmpty) {
        return emit(AddTaskFailure(error: 'Título não pode ser vazio'));
      }
      if (event.taskModel.description.trim().isEmpty) {
        return emit(AddTaskFailure(error: 'Descrição não pode ser vazia'));
      }
      if (event.taskModel.startDateTime == null) {
        return emit(AddTaskFailure(error: 'Faltou a data de inicio'));
      }
      if (event.taskModel.stopDateTime == null) {
        return emit(AddTaskFailure(error: 'Faltou a data de fim'));
      }
      if (event.taskModel.detail.trim().isEmpty) {
        return emit(AddTaskFailure(error: 'Faltou os detalhes'));
      }
      await taskRepository.createNewTask(event.taskModel);
      emit(AddTasksSuccess());
      final tasks = await taskRepository.getTasks();
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(AddTaskFailure(error: exception.toString()));
    }
  }

  void _fetchTasks(FetchTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await taskRepository.getTasks();
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(LoadTaskFailure(error: exception.toString()));
    }
  }

  _updateTask(UpdateTaskEvent event, Emitter<TasksState> emit) async {
    try {
      if (event.taskModel.title.trim().isEmpty) {
        return emit(UpdateTaskFailure(error: 'Título não pode ser vazio'));
      }
      if (event.taskModel.description.trim().isEmpty) {
        return emit(UpdateTaskFailure(error: 'Descrição não pode ser vazia'));
      }
      if (event.taskModel.startDateTime == null) {
        return emit(UpdateTaskFailure(error: 'Faltou a data de inicio'));
      }
      if (event.taskModel.stopDateTime == null) {
        return emit(UpdateTaskFailure(error: 'Faltou a data de fim'));
      }
      if (event.taskModel.detail.trim().isEmpty) {
        return emit(AddTaskFailure(error: 'Faltou os detalhes'));
      }
      emit(TasksLoading());
      final tasks = await taskRepository.updateTask(event.taskModel);
      emit(UpdateTaskSuccess());
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(UpdateTaskFailure(error: exception.toString()));
    }
  }

  _deleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await taskRepository.deleteTask(event.taskModel);
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(LoadTaskFailure(error: exception.toString()));
    }
  }

  _sortTasks(SortTaskEvent event, Emitter<TasksState> emit) async {
    final tasks = await taskRepository.sortTasks(event.sortOption);
    return emit(FetchTasksSuccess(tasks: tasks));
  }

  _searchTasks(SearchTaskEvent event, Emitter<TasksState> emit) async {
    final tasks = await taskRepository.searchTasks(event.keywords);
    return emit(FetchTasksSuccess(tasks: tasks, isSearching: true));
  }
}
