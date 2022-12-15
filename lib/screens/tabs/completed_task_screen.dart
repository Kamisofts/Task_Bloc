import 'package:bloc_tasks/models/task_model.dart';
import 'package:bloc_tasks/screens/my_drawer.dart';
import 'package:bloc_tasks/widgets/add_task.dart';
import 'package:flutter/material.dart';

import '../../blocs/bloc_export.dart';
import '../../widgets/task_list.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);
  static const String id = 'task_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<TaskModel> taskList = state.completedTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Center(
              child: Chip(
                label: Text(
                  '${state.pendingTasks.length.toString()} Pending | ${state.completedTasks.length.toString()}  Completed',
                ),
              ),
            ),
            TasksList(taskList: taskList)
          ],
        );
      },
    );
  }
}
