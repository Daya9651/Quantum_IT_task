
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_it_task/model/task_model.dart';
import '../../controller/task_controller.dart';
import 'package:intl/intl.dart';

class TaskFormPage extends StatelessWidget {
  final bool isEditing;
  final Task? task;

  TaskFormPage({this.isEditing = false, this.task});

  final TaskController taskController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isEditing && task != null) {
      titleController.text = task!.title;
      descriptionController.text = task!.description;
      priorityController.text = task!.priority.toString();
      dueDateController.text = DateFormat.yMMMd().format(task!.dueDate);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priorityController,
              decoration: InputDecoration(labelText: 'Priority',
              hintText: 'Enter in Digit..'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dueDateController,
              decoration: InputDecoration(labelText: 'Due Date'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dueDateController.text = DateFormat.yMMMd().format(pickedDate);
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  id: isEditing ? task!.id : DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: int.parse(priorityController.text),
                  dueDate: DateFormat.yMMMd().parse(dueDateController.text),
                );

                if (isEditing) {
                  taskController.editTask(task!.id, newTask);
                } else {
                  taskController.addTask(newTask);
                }

                Get.back();
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
