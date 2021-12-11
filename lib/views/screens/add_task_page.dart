import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/add_task_controller.dart';
import '../../global/app_colors.dart';
import '../../global/app_text_style.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  AddTaskController addTaskController = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 20, end: 20, bottom: 30, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task", style: headingStyle),
              InputField(
                title: 'Title',
                hint: 'Enter your title',
                textEditingController: addTaskController.titleController.value,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter your note',
                textEditingController: addTaskController.noteController.value,
              ),
              Obx(
                () {
                  return InputField(
                    title: 'Date',
                    hint: DateFormat.yMd()
                        .format(addTaskController.selectedDate.value),
                    widget: IconButton(
                      icon: const Icon(Icons.calendar_today_rounded, size: 25),
                      onPressed: () {
                        addTaskController.datePicked(context);
                      },
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => InputField(
                        title: 'Start Time',
                        hint: addTaskController.startTime.value,
                        widget: IconButton(
                          icon: const Icon(Icons.timer_rounded, size: 25),
                          onPressed: () {
                            addTaskController.timePicked(
                                context: context, isStartTime: true);
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => InputField(
                        title: 'End Time',
                        hint: addTaskController.endTime.value,
                        widget: IconButton(
                          icon: const Icon(Icons.timer_rounded, size: 25),
                          onPressed: () {
                            addTaskController.timePicked(
                                context: context, isStartTime: false);
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => InputField(
                  title: 'Remind',
                  hint:
                      '${addTaskController.selectedRemind.value} minutes early',
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 25,
                    elevation: 4,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      addTaskController.selectedRemind.value =
                          int.parse(newValue!);
                    },
                    style: hintInputStyle,
                    items: addTaskController.remindList
                        .map<DropdownMenuItem<String>>((element) {
                      return DropdownMenuItem(
                        value: '$element',
                        child: Text('$element'),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Obx(
                () => InputField(
                  title: 'Repeat',
                  hint: addTaskController.selectedRepeat.value,
                  widget: DropdownButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 25,
                    elevation: 4,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      addTaskController.selectedRepeat.value = newValue!;
                    },
                    style: hintInputStyle,
                    items: addTaskController.repeatList
                        .map<DropdownMenuItem<String>>((element) {
                      return DropdownMenuItem(
                        value: element,
                        child: Text(element),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPicker(),
                  Button(
                    label: 'Create Task',
                    onTap: () => addTaskController.validateData(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color", style: titleInputStyle),
        Obx(
          () => Wrap(
            children: List<Widget>.generate(3, (int index) {
              return GestureDetector(
                onTap: () {
                  addTaskController.selectedColor.value = index;
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 5, top: 5),
                  child: CircleAvatar(
                    child: addTaskController.selectedColor.value == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                    radius: 12,
                    backgroundColor: index == 0
                        ? AppColors.primaryClr
                        : index == 1
                            ? AppColors.pinkClr
                            : AppColors.yellowClr,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 25,
          color: Get.isDarkMode ? AppColors.whiteClr : AppColors.darkHeaderClr,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/user2.png"),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
