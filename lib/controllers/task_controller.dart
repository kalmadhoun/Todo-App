import 'package:get/get.dart';

import '../database/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;

  @override
  onReady() {
    getTasks();
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.inserat(task: task);
  }

  getTasks() async {
    var tasks = await DBHelper.query();
    var toList = tasks.map((e) => Task.fromJson(e)).toList();
    taskList.assignAll(toList);
  }

  delete({required Task task}) {
    DBHelper.delete(task: task);
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
  }
}
