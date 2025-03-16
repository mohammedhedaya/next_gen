import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart'; // استيراد go_router
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/core/utils/assets.dart';

class ChooseLogin extends StatelessWidget {
  const ChooseLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  Assets.imagesBackgroundImage,
                  width: 199.33.w,
                  height: 80.h,
                ),
              ],
            ),
            SizedBox(height: 80.h),

            buildButton(
              text: 'Login as Investor',
              color: AppColors.buttomOneInLogin,
              textColor: AppColors.blackColor,
              onPressed: () => context.push("/login"),
            ),
            SizedBox(height: 15.h),
            buildButton(
              text: 'Login as Startup',
              color: AppColors.buttomTwoInLogin,
              textColor: AppColors.blackColor,
              onPressed: () => context.push("/startUpView"),
            ),
            SizedBox(height: 15.h),
            buildButton(
              text: 'Sign Up',
              color: AppColors.buttomThreeInLogin,
              textColor: AppColors.blackColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: AppStyles.style16W400),
      ),
    );
  }
}
