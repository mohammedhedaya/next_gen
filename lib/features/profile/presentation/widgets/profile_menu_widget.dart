import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.endIcon,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 35.w,
        height: 35.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: AppColors.whiteColor,
        ),
        child: Icon(
          icon,
          color: AppColors.textColorOnboardingThree,
          size: 20.sp,
        ),
      ),
      title: Text(
        title,
        style: AppStyles.style14W400.apply(
          color: textColor,
          fontSizeFactor: 1.sp,
        ),
      ),
      trailing:
          endIcon
              ? Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: AppColors.whiteColor,
                ),
                child: Icon(
                  LineAwesomeIcons.angle_right_solid,
                  size: 15.sp,
                  color: AppColors.textColorOnboardingThree,
                ),
              )
              : null,
    );
  }
}
