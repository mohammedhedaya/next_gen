import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/searchView");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.transparent, width: 0.9.w),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.blackColor, size: 25.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                "Find companies to invest in",
                style: AppStyles.style14W400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
