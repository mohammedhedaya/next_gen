import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';

class InvestmentsViewBody extends StatelessWidget {
  const InvestmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات الشركات (أسماء + صور)
    final List<Map<String, String>> companies = [
      {"name": "Rave", "image": Assets.imagesLogoInCaed},
      {"name": "Digitzoid", "image": Assets.imagesLogoInCaed3},
      {"name": "Stargazer", "image": Assets.imagesLogoInCaed2},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          // تحديد لون الكارد بناءً على الفهرس
          Color cardColor =
              index == companies.length - 1
                  ? AppColors
                      .colorInCard3Home // لون خاص لآخر عنصر
                  : (index.isEven
                      ? AppColors.colorInCardHome
                      : AppColors.colorInCard2Home);

          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: InkWell(
              onTap: () {
                // context.push("/investmentsView");
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: cardColor, // تطبيق اللون المختار
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.r,
                      offset: Offset(0, 3.h),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30.r,
                          child: Image.asset(
                            companies[index]["image"]!, // الصورة حسب الفهرس
                            width: 30.w,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              companies[index]["name"]!, // الاسم حسب الفهرس
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$65,000",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Fintech app development provides more freedom to banking and other financial institutions.",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    ),
                    SizedBox(height: 12.h),
                    LinearProgressIndicator(
                      value: index.isEven ? 0.78 : 0.23,
                      backgroundColor: Colors.grey[300],
                      color: Colors.black,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${index.isEven ? 78 : 23}% In Progress",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorInProgress,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
