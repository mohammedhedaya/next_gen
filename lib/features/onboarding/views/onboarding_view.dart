import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/features/onboarding/components/onboarding_data.dart';
import 'package:next_gen/features/onboarding/widgets/custom_button.dart';
import 'package:next_gen/features/onboarding/widgets/custom_dots.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = OnboardingData();
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NextGen",
          style: AppStyles.style24W500.copyWith(fontSize: 24.sp),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          body(),
          CustomButton(
            pageController: pageController,
            currentIndex: currentIndex,
            onIndexChanged: (newIndex) {
              setState(() {
                currentIndex = newIndex;
              });
            },
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  // Body
  Widget body() {
    return Expanded(
      child: Center(
        child: PageView.builder(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Images
                  Image.asset(
                    controller.items[currentIndex].image,
                    width: 357.w,
                    height: 268.h,
                  ),

                  SizedBox(height: 10.h),
                  CustomDots(currentIndex: currentIndex),
                  SizedBox(height: 15.h),

                  // Titles
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppStyles.style21W600.copyWith(
                        color: Colors.white,
                        fontSize: 21.sp,
                      ),
                      children: highlightWords(
                        controller.items[currentIndex].text,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

List<TextSpan> highlightWords(String text) {
  Map<String, Color> highlightColors = {
    "Innovators": AppColors.textColorOnboardingOne,
    "Investors": AppColors.textColorOnboardingOne,
    "startups": AppColors.textColorOnboardingTwo,
    "investors": AppColors.textColorOnboardingTwo,
    "thumbnails": AppColors.textColorOnboardingThree,
    "summaries": AppColors.textColorOnboardingThree,
    "Progress": AppColors.textColorOnboardingThree,
    "Bars": AppColors.textColorOnboardingThree,
  };

  List<TextSpan> spans = [];

  RegExp regex = RegExp(r'\b\w+\b');
  Iterable<RegExpMatch> matches = regex.allMatches(text);

  int lastMatchEnd = 0;

  for (final match in matches) {
    String word = match.group(0)!;

    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
    }

    Color? color = highlightColors[word];

    spans.add(
      TextSpan(
        text: word,
        style: TextStyle(
          color: color ?? Colors.white,
          fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
          fontSize: 21.sp,
        ),
      ),
    );

    lastMatchEnd = match.end;
  }

  if (lastMatchEnd < text.length) {
    spans.add(TextSpan(text: text.substring(lastMatchEnd)));
  }

  return spans;
}
