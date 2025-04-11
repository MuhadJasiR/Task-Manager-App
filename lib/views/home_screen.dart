import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    List colors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.amber,
    ];
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(index.toString()),
                        ),
                        title: Text("Task title"),
                        subtitle: Text("Task title"),
                        trailing: Checkbox(value: false, onChanged: (value) {}),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/add-task'),
        label: Icon(Icons.add),
      ),
    );
  }
}
