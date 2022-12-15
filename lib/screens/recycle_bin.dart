import 'package:bloc_tasks/widgets/task_list.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_export.dart';
import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);
  static const String id = 'recycle_bin';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              IconButton(
                onPressed: () =>context.read<TaskBloc>().add(DeleteAllTask()),
                icon: const Icon(Icons.delete_forever_outlined),
              )
            ],
          ),
          drawer:const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Center(
                child: Chip(
                  label: Text(
                    '${state.removedTasks.length} Tasks:',
                  ),
                ),
              ),
              TasksList(taskList: state.removedTasks )
            ],
          ),

        );
      },
    );
  }
}
