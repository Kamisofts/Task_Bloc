import 'package:bloc_tasks/screens/recycle_bin.dart';
import 'package:bloc_tasks/screens/tab_screen.dart';
import 'package:bloc_tasks/screens/tabs/pending_task_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (context) => const RecycleBin());
      case TabScreen.id:
        return MaterialPageRoute(builder: (context) =>  TabScreen());
      default:
        return MaterialPageRoute(builder: (context) =>  TabScreen());
    }
  }
}
