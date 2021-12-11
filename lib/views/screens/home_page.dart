import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/task_controller.dart';
import '../../global/app_colors.dart';
import '../../global/app_text_style.dart';
import '../../models/task.dart';
import '../../services/notifiaction_services.dart';
import '../../services/theme_sevices.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotificationServices notificationServices;
  HomeController homeController = Get.put(HomeController());
  TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    notificationServices = NotificationServices();
    notificationServices.initializeNotification();
    notificationServices.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(height: 20),
          _showTasks(context),
        ],
      ),
    );
  }

  Widget _addDateBar() {
    return Obx(
      () => Container(
        margin: const EdgeInsetsDirectional.only(top: 20, start: 20),
        child: DatePicker(
          DateTime.now(),
          initialSelectedDate: homeController.selectedDate.value,
          height: 120,
          width: 85,
          selectionColor: AppColors.primaryClr,
          selectedTextColor: AppColors.whiteClr,
          dateTextStyle: dateTextStyle,
          dayTextStyle: dayTextStyle,
          monthTextStyle: monthTextStyle,
          onDateChange: (date) {
            setState(() {
              homeController.selectedDate.value = date;
            });
          },
        ),
      ),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          Button(
            label: "+ Add Task",
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          notificationServices.displayNotification(
            title: 'Theme Changed',
            body: Get.isDarkMode
                ? 'Light Theme Activated'
                : 'Dark Theme Activated',
          );
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
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

  _showTasks(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = taskController.taskList[index];
            if (task.repeat == 'Daily') {
              DateTime date = DateFormat.jm().parse(task.startTime);
              var myTime = DateFormat("HH:mm").format(date);
              notificationServices.scheduledNotification(
                hour: int.parse(myTime.toString().split(":")[0]),
                minute: int.parse(myTime.toString().split(":")[1]),
                task: task,
              );
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task: task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (task.date ==
                DateFormat.yMd().format(homeController.selectedDate.value)) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task: task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsetsDirectional.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.30
            : MediaQuery.of(context).size.height * 0.42,
        color: Get.isDarkMode ? AppColors.darkGreyClr : AppColors.whiteClr,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[700] : Colors.grey[300],
              ),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onPressed: () {
                      taskController.markTaskCompleted(task.id!);
                      Get.back();
                      taskController.getTasks();
                    },
                    color: AppColors.primaryClr,
                    context: context,
                  ),
            _bottomSheetButton(
              label: "Delete Task",
              onPressed: () {
                taskController.delete(task: task);
                Get.back();
                taskController.getTasks();
              },
              color: AppColors.pinkClr,
              context: context,
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 3),
            _bottomSheetButton(
              label: "Close",
              onPressed: () {
                Get.back();
              },
              color: AppColors.darkHeaderClr,
              context: context,
              isClose: true,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onPressed,
    required Color color,
    required BuildContext context,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsetsDirectional.only(top: 4, bottom: 4),
        height: 60,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[700]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : color,
        ),
        child: Text(
          label,
          style: isClose
              ? bottomSheetTitle
              : bottomSheetTitle.copyWith(
                  color: AppColors.whiteClr,
                ),
        ),
      ),
    );
  }
}
