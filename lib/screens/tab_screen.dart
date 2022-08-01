import 'package:bloc_tasks/screens/tabs/completed_task_screen.dart';
import 'package:bloc_tasks/screens/tabs/favorite_task_screen.dart';
import 'package:bloc_tasks/screens/tabs/pending_task_screen.dart';
import 'package:bloc_tasks/widgets/add_task.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_export.dart';
import '../blocs/tabBloc/tabs_bloc.dart';
import 'my_drawer.dart';

class TabScreen extends StatelessWidget {
    TabScreen({Key? key}) : super(key: key);
  static const String id = 'tab_screen';

  int selectTab = 0;
  List<Map<String, dynamic>> pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pageName': const FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, TabsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(pageDetails[state.selectTab]['title']),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: const MyDrawer(),
          body: pages(state),
          floatingActionButton: state.selectTab==0? FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ):null,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectTab,
            onTap: (index) {
              index == 0
                  ? context.read<TabsBloc>().add(TabsPendingEvent())
                  : index == 1
                      ? context.read<TabsBloc>().add(TabsCompletedEvent())
                      : context.read<TabsBloc>().add(TabsFavoriteEvent());


            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.incomplete_circle_rounded), label: 'Pending Task'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), label: 'Completed Task'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite Task')
            ],
          ),
        );
      },
    );
  }

  StatelessWidget pages(TabsState state) {
    return state.selectTab == 0
        ? const PendingTasksScreen()
        : state.selectTab == 1
            ? const CompletedTasksScreen()
            : const FavoriteTasksScreen();
  }
}
