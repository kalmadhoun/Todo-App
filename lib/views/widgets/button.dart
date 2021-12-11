import 'package:flutter/material.dart';

import '../../global/app_colors.dart';

class Button extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const Button({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryClr,
        ),
        child: Text(
          label,
          style: const TextStyle(color: AppColors.whiteClr),
        ),
      ),
    );
  }
}
