import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';

class InvestmentsListViewSection extends StatelessWidget {
  const InvestmentsListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h, // ارتفاع متجاوب
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.push("/InvestmentsView");
            },
            child: SizedBox(
              width: 180.w, // عرض متجاوب
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r), // زوايا متجاوبة
                ),
                elevation: 4,
                color: AppColors.colorInCardHome,
                child: Padding(
                  padding: EdgeInsets.all(12.w), // تباعد متجاوب
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 24.r, // حجم متجاوب
                            child: Image.asset(Assets.imagesLogoInCaed),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(),
                            ),
                            padding: EdgeInsets.all(6.w), // تباعد متجاوب
                            child: Icon(
                              Icons.arrow_outward,
                              size: 20.sp, // حجم أيقونة متجاوب
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h), // مسافة متجاوبة
                      Text(
                        "Rave",
                        style: TextStyle(
                          fontSize: 20.sp, // حجم الخط متجاوب
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h), // مسافة متجاوبة
                      Text(
                        "\$65,000",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[700],
                        ), // خط متجاوب
                      ),
                      SizedBox(height: 6.h), // مسافة متجاوبة
                      Text(
                        "Fintech app development provides more freedom to banking and other financial institutions.",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ), // خط متجاوب
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(
                            value: 0.78,
                            backgroundColor: Colors.grey[300],
                            color: Colors.black,
                          ),
                          SizedBox(height: 4.h), // مسافة متجاوبة
                          Text(
                            "78%  In Progress",
                            style: TextStyle(
                              fontSize: 12.sp, // خط متجاوب
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
