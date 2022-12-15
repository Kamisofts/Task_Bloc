import 'package:bloc_tasks/blocs/bloc_export.dart';
import 'package:bloc_tasks/services/guid_gen.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';

class EditTaskScreen extends StatelessWidget {
  final TaskModel oldTask;

  const EditTaskScreen({Key? key, required this.oldTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descController =
        TextEditingController(text: oldTask.description);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text('Edit Task', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text('Title'), border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 5,
            minLines: 3,
            autofocus: true,
            controller: descController,
            decoration: const InputDecoration(
                label: Text('Description'), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    var editedTask = TaskModel(
                        id: oldTask.id,
                        title: titleController.text,
                        isFavorite: oldTask.isFavorite,
                        isDone: false,
                        description: descController.text,
                        date: DateTime.now().toString());
                    context.read<TaskBloc>().add(EditTask(oldTask: oldTask,newTask: editedTask));
                    Navigator.pop(context);
                  },
                  child: const Text('Save')),
            ],
          )
        ],
      ),
    );
  }
}
