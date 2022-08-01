import 'package:bloc_tasks/screens/recycle_bin.dart';
import 'package:bloc_tasks/screens/tab_screen.dart';
import 'package:bloc_tasks/screens/tabs/pending_task_screen.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_export.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          child: Column(children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text(
                'Task Drawer',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(TabScreen.id),
                  child: ListTile(
                    title: const Text('My Tasks'),
                    leading: const Icon(Icons.folder_special),
                    trailing: Text('${state.pendingTasks.length} | ${state.completedTasks.length}'),
                  ),
                );
              },
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  child: ListTile(
                    title: const Text('Bin'),
                    leading: const Icon(Icons.delete),
                    trailing: Text(state.removedTasks.length.toString()),
                  ),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                    value: state.switchValue,
                    onChanged: (val) {
                      val
                          ? context.read<SwitchBloc>().add(SwitchOnEvent())
                          : context.read<SwitchBloc>().add(SwitchOffEvent());
                    });
              },
            )
          ]),
        ),

      ),
    );
  }
}
