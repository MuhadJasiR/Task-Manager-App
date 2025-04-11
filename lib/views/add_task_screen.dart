import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager_app/controllers/task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final TaskController taskController = Get.find();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxString selectedDate = "Not selected".obs;
  final RxString selectedTime = "Not selected".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Task",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text("Add title"),
              _customFormField(
                "Give a title",
                1,
                titleController,
                _validateTitle,
              ),
              Text("Add description"),
              _customFormField(
                "What are you planning..",
                7,
                descriptionController,
                _validateDescription,
              ),
              SizedBox(height: 10),
              Text("Date & Time"),
              Obx(
                () => _customDateAndTime(
                  "Time",
                  selectedTime.value,
                  context,
                  () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      selectedTime.value = time.format(context);
                    }
                  },
                ),
              ),
              Obx(
                () => _customDateAndTime(
                  "Date",
                  selectedDate.value,
                  context,
                  () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      selectedDate.value =
                          '${date.day}-${date.month}-${date.year}';
                    }
                  },
                ),
              ),
              Spacer(),
              _customButton(),
            ],
          ),
        ),
      ),
    );
  }

  Container _customButton() {
    return Container(
      width: double.infinity,
      height: 55,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 46, 46, 46),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Obx(
        () => ElevatedButton(
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty) {
              taskController.addTask(
                titleController.text,
                descriptionController.text,
                selectedDate.string,
                selectedTime.string,
              );
            } else {
              Get.snackbar("Error", "Please fill all fields");
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child:
              taskController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
        ),
      ),
    );
  }

  TextFormField _customFormField(
    String hintText,
    int lines,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _customDateAndTime(
    String title,
    String content,
    BuildContext context,
    void Function()? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        height: 55,
        width: double.infinity,
        child: Row(
          children: [
            Text(title),
            Spacer(),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                content,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return "Title can't be empty";
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "Description can't be empty";
    }
    return null;
  }
}
