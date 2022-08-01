import 'package:bloc_tasks/models/task_model.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_export.dart';

class TaskTile extends StatelessWidget {
  TaskModel task;

  TaskTile({Key? key, required this.task}) : super(key: key);

  void _removeOrDeleteTask(BuildContext ctx) {
    task.isDeleted!
        ? ctx.read<TaskBloc>().add(DeleteTask(task: task))
        : ctx.read<TaskBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      onLongPress: () => _removeOrDeleteTask(context),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: task.isDeleted!
            ? null
            : (val) {
                context.read<TaskBloc>().add(UpdateTask(task: task));
              },
      ),
    );
  }
}
