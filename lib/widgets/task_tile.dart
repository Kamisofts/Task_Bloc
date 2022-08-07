import 'package:bloc_tasks/models/task_model.dart';
import 'package:bloc_tasks/widgets/edit_task.dart';
import 'package:bloc_tasks/widgets/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_export.dart';

class TaskTile extends StatelessWidget {
  TaskModel task;

  TaskTile({Key? key, required this.task}) : super(key: key);

  void _removeOrDeleteTask(BuildContext ctx) {
    task.isDeleted!
        ? ctx.read<TaskBloc>().add(DeleteTask(task: task))
        : ctx.read<TaskBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    Navigator.of(context).pop();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditTaskScreen(oldTask: task),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          task.isFavorite == false
              ? const Icon(Icons.star_border_outlined)
              : const Icon(Icons.star_rounded),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DateFormat()
                            .add_yMMMd()
                            .format(DateTime.parse(task.date)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: task.isDone,
                      onChanged: task.isDeleted!
                          ? null
                          : (val) {
                              context
                                  .read<TaskBloc>()
                                  .add(UpdateTask(task: task));
                            },
                    ),
                    PopUpMenu(
                      cancelOrDelete: () => _removeOrDeleteTask(context),
                      task: task,
                      editTaskCallback: () => _editTask(context),
                      likeOrDislike: () => context
                          .read<TaskBloc>()
                          .add(MarkFavoriteOrUnfavoriteTask(task: task)),
                      restoreTaskCallback: () =>
                          context.read<TaskBloc>().add(RestoreTask(task: task)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
