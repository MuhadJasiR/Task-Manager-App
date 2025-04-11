import 'package:get/get.dart';
import 'package:task_manager_app/controllers/auth_controller.dart';
import 'package:task_manager_app/controllers/task_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(TaskController());
  }
}
