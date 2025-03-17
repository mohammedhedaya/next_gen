import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';

class InvestmentsRecommended extends StatelessWidget {
  const InvestmentsRecommended({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h, // ✅ ارتفاع متجاوب مثل InvestmentsListViewSection
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.push("/InvestmentsView");
            },
            child: SizedBox(
              width: 180.w, // ✅ عرض متجاوب مثل InvestmentsListViewSection
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 4,
                color: AppColors.colorInCardHome,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 24.r,
                            child: Image.asset(Assets.imagesLogoInCaed3),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(),
                            ),
                            padding: EdgeInsets.all(6.w),
                            child: Icon(
                              Icons.arrow_outward,
                              size: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Digitzoid",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "\$40,000",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Expanded(
                        // ✅ استخدام Expanded لمنع overflow
                        child: Text(
                          "Fintech app development provides more freedom to banking and other financial institutions..",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ), // ✅ إضافة تباعد قبل Progress Indicator
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(
                            value: 0.45,
                            backgroundColor: Colors.grey[300],
                            color: Colors.black,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "45%  In Progress",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorInProgress,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
