import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedDate = DateTime.now().obs;

  updateDate(date) {
    selectedDate.value = date;
  }
}
