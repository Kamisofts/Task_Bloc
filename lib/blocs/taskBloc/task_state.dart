part of 'task_bloc.dart';

@immutable
 class TaskState {
  final List<TaskModel> allTasks;
  const TaskState({this.allTasks=const <TaskModel>[]});
  @override
  // TODO: implement props
  List<Object?> get props => [allTasks];
}

class TaskInitial extends TaskState {

}
