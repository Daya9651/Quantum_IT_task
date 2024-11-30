
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../model/task_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void onInit() {
    super.onInit();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void addTask(Task task) {
    tasks.add(task);
    scheduleNotification(task);
  }

  void editTask(String id, Task newTask) {
    int index = tasks.indexWhere((task) => task.id == id);
    tasks[index] = newTask;
    update();
  }

  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
    update();
  }

  void scheduleNotification(Task task) {
    var scheduledNotificationDateTime = task.dueDate.subtract(Duration(minutes: 30));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        // 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher');
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // flutterLocalNotificationsPlugin.schedule(
    //     task.id.hashCode,
    //     'Task Reminder',
    //     'You have a task "${task.title}" due soon',
    //     scheduledNotificationDateTime,
    //     platformChannelSpecifics);
  }

  List<Task> get sortedTasksByPriority => tasks..sort((a, b) => b.priority.compareTo(a.priority));
  List<Task> get sortedTasksByDueDate => tasks..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  List<Task> get sortedTasksByCreationDate => tasks;
}
