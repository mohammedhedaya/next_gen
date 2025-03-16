import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "NextGen",
        style: AppStyles.style24W500.copyWith(fontSize: 24.sp),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
