import 'package:bloc_tasks/blocs/bloc_export.dart';
import 'package:equatable/equatable.dart';
import '../../models/task_model.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<RemoveTask>(_onRemoveTask);
    on<DeleteAllTask>(_onDeleteAllTasks);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      removedTasks: state.removedTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;
    List<TaskModel> favoriteTasks = state.favoriteTasks;
    var taskIndex=favoriteTasks.indexOf(event.task);

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true)),
      if(task.isFavorite==true){

        favoriteTasks= List.from(favoriteTasks)..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true)),
      }
          }
        : {
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false)),
            completedTasks = List.from(completedTasks)..remove(task),
      if(task.isFavorite==true){

        favoriteTasks= List.from(favoriteTasks)..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: false)),
      }
          };

    emit(TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTasks: List.from(state.pendingTasks)..remove(event.task),
      completedTasks: List.from(state.completedTasks)..remove(event.task),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
      removedTasks: List.from(state.removedTasks)
        ..add(event.task.copyWith(isDeleted: true)),
    ));
  }

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TaskState> emit) {
    final state = this.state;

    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;
    List<TaskModel> favoriteTasks = state.favoriteTasks;

    var taskIndex = pendingTasks.indexOf(event.task);
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }

    emit(TaskState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;

    List<TaskModel> favoriteTasks = state.favoriteTasks;

    if (event.oldTask.isFavorite == false) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    emit(TaskState(
      pendingTasks: state.pendingTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
      pendingTasks: state.pendingTasks
        ..insert(
            0,
            event.task
                .copyWith(isDeleted: false, isFavorite: false, isDone: false)),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks..remove(event.task),
    ));
  }


  void _onDeleteAllTasks(DeleteAllTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: List.from(state.removedTasks)..clear(),
    ));
  }



  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
