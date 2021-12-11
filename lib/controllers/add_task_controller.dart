import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../global/app_colors.dart';
import '../models/task.dart';
import 'task_controller.dart';

class AddTaskController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var startTime = DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  var endTime = "9:45 AM".obs;

  var selectedRemind = 5.obs;
  var remindList = [
    5,
    10,
    15,
    20,
  ].obs;

  var selectedRepeat = "None".obs;
  var repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ].obs;

  var selectedColor = 0.obs;

  var titleController = TextEditingController().obs;
  var noteController = TextEditingController().obs;

  validateData() async {
    if (titleController.value.text.isNotEmpty &&
        noteController.value.text.isNotEmpty) {
      await TaskController().addTask(
        task: Task(
          title: titleController.value.text,
          note: noteController.value.text,
          color: selectedColor.value,
          date: DateFormat.yMd().format(selectedDate.value),
          endTime: endTime.value,
          startTime: startTime.value,
          isCompleted: 0,
          remind: selectedRemind.value,
          repeat: selectedRepeat.value,
        ),
      );
      Get.back();
    } else if (titleController.value.text.isEmpty ||
        noteController.value.text.isEmpty) {
      Get.snackbar(
        'Required',
        'You forgot a field, You must fill it',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.pinkClr,
        icon: const Icon(
          Icons.dangerous_rounded,
          color: AppColors.whiteClr,
        ),
        colorText: AppColors.whiteClr,
        duration: const Duration(seconds: 3),
      );
    }
  }

  datePicked(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (_pickerDate != null) {
      selectedDate.value = _pickerDate;
    }
  }

  timePicked({
    required BuildContext context,
    required bool isStartTime,
  }) async {
    TimeOfDay? _pickerTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: isStartTime == true
            ? int.parse(startTime.value.split(":")[0])
            : int.parse(endTime.value.split(":")[0]),
        minute: isStartTime == true
            ? int.parse(startTime.value.split(":")[1].split(" ")[0])
            : int.parse(endTime.value.split(":")[1].split(" ")[0]),
      ),
    );

    String formatTime = _pickerTime!.format(context);
    if (isStartTime == true) {
      startTime.value = formatTime;
    } else if (isStartTime == false) {
      endTime.value = formatTime;
    }
  }
}
