import 'package:bloc_tasks/models/task_model.dart';
import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu(
      {Key? key,
      required this.cancelOrDelete,
      required this.task,
      required this.likeOrDislike,
      required this.editTaskCallback, required this.restoreTaskCallback})
      : super(key: key);
  final VoidCallback cancelOrDelete;
  final VoidCallback likeOrDislike;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => task.isDeleted == false
            ? [
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit')),
                  onTap: () => editTaskCallback,
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite == false
                          ? const Icon(Icons.bookmark_add_outlined)
                          : const Icon(Icons.bookmark_remove_outlined),
                      label: task.isFavorite == false
                          ? const Text('Add to \nBookmark')
                          : const Text('Remove from \nBookmark')),
                  onTap: () => likeOrDislike,
                ),
                PopupMenuItem(
                  onTap: cancelOrDelete,
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete')),
                ),
              ]
            : [
                PopupMenuItem(
                  onTap: restoreTaskCallback,
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.restore_from_trash),
                      label: const Text('Restore')),
                ),
                PopupMenuItem(
                  onTap: cancelOrDelete,
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete Forever')),
                ),
              ]);
  }
}
