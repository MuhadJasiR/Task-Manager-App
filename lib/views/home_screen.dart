import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controllers/auth_controller.dart';
import 'package:task_manager_app/controllers/task_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController authController = AuthController();
  final TaskController taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Your Task",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: Icon(Icons.login),
          ),
        ],
      ),
      body: Obx(() {
        int completed =
            taskController.tasks.where((task) => task.isCompleted).length;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Completed",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                "$completed/${taskController.tasks.length} Task",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.grey.shade100,
                      child: ListTile(
                        leading: Checkbox(
                          value: taskController.tasks[index].isCompleted,
                          onChanged: (value) {
                            taskController.toggleComplete(
                              taskController.tasks[index].id,
                              value!,
                            );
                          },
                        ),
                        title: Text(taskController.tasks[index].title),
                        subtitle: Text(taskController.tasks[index].description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(taskController.tasks[index].date),
                                Text(taskController.tasks[index].time),
                              ],
                            ),
                            PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'update') {
                                  Get.toNamed(
                                    "/add-task",
                                    arguments: taskController.tasks[index],
                                  );
                                } else if (value == 'delete') {
                                  taskController.deleteTask(
                                    taskController.tasks[index].id,
                                  );
                                }
                              },
                              itemBuilder:
                                  (context) => [
                                    PopupMenuItem(
                                      onTap: () {},
                                      value: 'update',
                                      child: Text('Update'),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey.shade100,
        onPressed: () => Get.toNamed('/add-task'),
        label: Icon(Icons.add_to_photos_outlined, color: Colors.black),
      ),
    );
  }
}
