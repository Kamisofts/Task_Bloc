import 'package:bloc_tasks/blocs/bloc_export.dart';
import 'package:bloc_tasks/services/guid_gen.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return Padding(
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
          ),   const SizedBox(height: 10),
          TextField(
            maxLines: 5,
            minLines: 3,
            autofocus: true,
            controller: descController,
            decoration: const InputDecoration(
                label:Text('Description'),
                border: OutlineInputBorder()

            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end,children: [
            TextButton(onPressed: ()=>Navigator.pop(context), child:const Text('Cancel')),
            const SizedBox(width: 20),
            ElevatedButton(onPressed: (){
              var task=TaskModel(id:GUIDGen.generate(),title: titleController.text,description: descController .text);
              context.read<TaskBloc>().add(AddTask(task: task));
              Navigator.pop(context);
            }, child:const Text('Add')),
          ],)
        ],
      ),
    );
  }
}
