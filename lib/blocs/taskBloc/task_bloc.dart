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
    on<RemoveTask>(_onRemoveTask);
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

    task.isDone == false
        ? {
      pendingTasks=List.from(pendingTasks)..remove(task),
      completedTasks=List.from(completedTasks)..insert(0,task.copyWith(isDone: true)),
    }
        : {

      pendingTasks=List.from(pendingTasks)..insert(0,task.copyWith(isDone: false)),
      completedTasks=List.from(completedTasks)..remove(task),
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

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
