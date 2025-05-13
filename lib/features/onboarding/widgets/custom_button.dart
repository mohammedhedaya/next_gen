import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/cache/cache_helper.dart';
import 'package:next_gen/core/service/service_locator.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/features/onboarding/components/onboarding_data.dart';

class CustomButton extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final Function(int) onIndexChanged;

  const CustomButton({
    super.key,
    required this.pageController,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 40.h),
          width: 195.w,
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),
          child: TextButton(
            onPressed: () async {
              if (currentIndex != OnboardingData().items.length - 1) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                onIndexChanged(currentIndex + 1);
              } else {
                await getIt<CacheHelper>().saveData(
                  key: "onBoardingDone",
                  value: true,
                );
                context.push("/chooselogin");
              }
            },

            child: Text(
              currentIndex == OnboardingData().items.length - 1
                  ? "Get started"
                  : "Continue",
              style: AppStyles.style16W400.copyWith(fontSize: 16.sp),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        TextButton(
          onPressed: () async {
            await getIt<CacheHelper>().saveData(
              key: "onBoardingDone",
              value: true,
            );
            context.push("/chooselogin");
          },

          child: Text("Skip", style: AppStyles.style20W400),
        ),
      ],
    );
  }
}
