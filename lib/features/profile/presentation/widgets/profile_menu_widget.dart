import 'package:flutter/material.dart';
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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.whiteColor,
        ),
        child: Icon(icon, color: AppColors.textColorOnboardingThree),
      ),
      title: Text(title, style: AppStyles.style14W400.apply(color: textColor)),
      trailing:
          endIcon
              ? Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.whiteColor,
                ),
                child: const Icon(
                  LineAwesomeIcons.angle_right_solid,
                  size: 18,
                  color: AppColors.textColorOnboardingThree,
                ),
              )
              : null,
    );
  }
}
