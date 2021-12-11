import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? AppColors.whiteClr : AppColors.darkGreyClr,
    ),
  );
}

TextStyle get titleInputStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? AppColors.whiteClr : AppColors.darkGreyClr,
    ),
  );
}

TextStyle get hintInputStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
    ),
  );
}

TextStyle get bottomSheetTitle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? AppColors.whiteClr : AppColors.darkGreyClr,
    ),
  );
}

TextStyle get dateTextStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle get dayTextStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle get monthTextStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.w600,
    ),
  );
}


