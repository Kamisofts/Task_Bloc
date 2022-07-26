part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {
  const TaskEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final TaskModel task;

  const AddTask({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  const UpdateTask({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final TaskModel task;

  const DeleteTask({required this.task});

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}
