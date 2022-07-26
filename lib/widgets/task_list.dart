import 'package:flutter/material.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key,required this.taskList}) : super(key: key);
  final List<TaskModel> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            taskList[index].title,
          ),
          trailing: Checkbox(
            value: taskList[index].isDone,
            onChanged: (val) {},
          ),
        ),
      ),
    );
  }
}
