import 'package:get/route_manager.dart';
import 'package:task_manager_app/views/add_task_screen.dart';
import 'package:task_manager_app/views/home_screen.dart';
import 'package:task_manager_app/views/login_screen.dart';
import 'package:task_manager_app/views/register_screen.dart';

final appRoutes = [
  GetPage(name: '/login', page: () => LoginScreen()),
  GetPage(name: '/register', page: () => RegisterScreen()),
  GetPage(name: '/home', page: () => HomeScreen()),
  GetPage(name: '/add-task', page: () => AddTaskScreen()),
];
