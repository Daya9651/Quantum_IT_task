import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quantum_it_task/controller/task_controller.dart';
import '../../model/task_model.dart';
import 'task_form_page.dart';

class TaskListPage extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quantum IT Todo List App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: TaskSearch(taskController));
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(task.title),
                subtitle: Row(
                  children: [
                    Text("Due date ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text(DateFormat.yMMMd().format(task.dueDate), style: TextStyle(fontSize: 16),),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskController.deleteTask(task.id);
                  },
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(task.title),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Due Date: ${DateFormat.yMMMd().format(task.dueDate)}"),
                            // Add more task details here
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Close"),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              Get.to(() => TaskFormPage(isEditing: true, task: task));
                            },
                            child: Text("Edit"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => TaskFormPage());
        },
        child: Icon(Icons.add, size: 40,),
      ),
    );
  }
}

class TaskSearch extends SearchDelegate<Task> {
  final TaskController taskController;

  TaskSearch(this.taskController);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = taskController.tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final task = results[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(task.title),
            subtitle: Text(DateFormat.yMMMd().format(task.dueDate)),
            onTap: () {
              close(context, task);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(task.title),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Due Date: ${DateFormat.yMMMd().format(task.dueDate)}"),
                        // Add more task details here
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Close"),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.to(() => TaskFormPage(isEditing: true, task: task));
                        },
                        child: Text("Edit"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = taskController.tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final task = suggestions[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Text(task.title),
            subtitle: Text(DateFormat.yMMMd().format(task.dueDate)),
            onTap: () {
              close(context, task);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(task.title),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Due Date: ${DateFormat.yMMMd().format(task.dueDate)}"),
                        // Add more task details here
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Close"),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                          Get.to(() => TaskFormPage(isEditing: true, task: task));
                        },
                        child: Text("Edit"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
