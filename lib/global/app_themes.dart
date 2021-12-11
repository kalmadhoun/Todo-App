import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static final light = ThemeData(
    backgroundColor: AppColors.whiteClr,
    primaryColor: AppColors.primaryClr,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    backgroundColor: AppColors.darkGreyClr,
    primaryColor: AppColors.darkGreyClr,
    brightness: Brightness.dark,
  );
}
