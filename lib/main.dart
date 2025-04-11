import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/bindings/initial_bindings.dart';
import 'package:task_manager_app/controllers/auth_controller.dart';
import 'package:task_manager_app/firebase_options.dart';
import 'package:task_manager_app/routes.dart';
import 'package:task_manager_app/views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      getPages: appRoutes,
      title: 'Task Manager',
      theme: ThemeData(),
      home: LoginScreen(),
    );
  }
}
