import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/service/firebase_service.dart';
import 'package:uuid/uuid.dart';

class TaskController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final tasks = <TaskModel>[].obs;
  final isLoading = false.obs;

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _firebaseService.getTasks(userId).listen((taskList) {
        tasks.assignAll(taskList);
      });
    }
  }

  Future<void> addTask(
    String title,
    String description,
    String date,
    String time,
  ) async {
    try {
      isLoading.value = true;
      final task = TaskModel(
        description: description,
        title: title,
        id: const Uuid().v4(),
        date: date,
        time: time,
        isCompleted: false,
      );
      await _firebaseService.addTask(userId, task).then((value) => Get.back());
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      isLoading.value = true;

      await _firebaseService
          .updateTask(userId, task)
          .then((value) => Get.back());
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;

      await _firebaseService.deleteTask(userId, taskId);
    } catch (e) {
      Get.snackbar("error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleComplete(String id, bool isCompleted) {
    try {
      _firebaseService.toggleComplete(id, isCompleted);
    } catch (e) {
      Get.snackbar("ERROR", e.toString());
    }
  }
}
