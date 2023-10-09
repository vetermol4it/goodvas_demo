import 'package:flutter/material.dart';
import 'package:goodvas_demo/ui_kit/app_colors.dart';

abstract class AppTextStyle {
  static const title = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 28,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 19,
    color: AppColors.textPrimary,
  );
}
