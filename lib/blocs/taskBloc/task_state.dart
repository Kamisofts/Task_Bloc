part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> favoriteTasks;

  // final List<TaskModel> allTasks;

  final List<TaskModel> removedTasks;

  const TaskState({
    this.pendingTasks = const <TaskModel>[],
    this.completedTasks = const <TaskModel>[],
    this.favoriteTasks = const <TaskModel>[],
    this.removedTasks = const <TaskModel>[],
  });

  @override
  // TODO: implement props
  List<Object?> get props => [pendingTasks,completedTasks,favoriteTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromJson(Map<String, dynamic> json) {
    return TaskState(
      pendingTasks: List<TaskModel>.of(json["pendingTasks"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      completedTasks: List<TaskModel>.of(json["completedTasks"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      favoriteTasks: List<TaskModel>.of(json["favoriteTasks"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
      removedTasks: List<TaskModel>.of(json["removedTasks"])
          .map((i) => i /* can't generate it properly yet */)
          .toList(),
    );
  }
//
}

class TaskInitial extends TaskState {}
