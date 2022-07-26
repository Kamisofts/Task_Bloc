import 'package:bloc_tasks/models/task.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_export.dart';
import '../widgets/task_list.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text('Add Task', style: TextStyle(fontSize: 24)),
                      const SizedBox(height: 10),
                      TextField(
                        autofocus: true,
                        controller: titleController,
                        decoration: const InputDecoration(
                          label:Text('Title'),
                          border: OutlineInputBorder()

                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                        TextButton(onPressed: ()=>Navigator.pop(context), child:const Text('Cancel')),
                        const SizedBox(width: 20),
                        ElevatedButton(onPressed: (){
                          var task=TaskModel(title: titleController.text);
                          context.read<TaskBloc>().add(AddTask(task: task));
                          Navigator.pop(context);
                        }, child:const Text('Add')),
                      ],)
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<TaskModel> taskList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Chip(
                  label: Text(
                    'Tasks:',
                  ),
                ),
              ),
              TasksList(taskList: taskList)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
