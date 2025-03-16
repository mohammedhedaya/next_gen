import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/start_up/presentation/widgets/add_new_buttom_idea.dart';

class StartUpViewBody extends StatelessWidget {
  const StartUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> companies = [
      {
        "name": "Suits",
        "image": Assets.imagesLogoInCaed,
        "price": "\$65,000",
        "progress": 0.78,
        "cardColor": const Color(0xFFF9E8C9),
      },
      {
        "name": "Nova Car Care",
        "image": Assets.imagesLogoInCaed3,
        "price": "\$25,000",
        "progress": 0.50,
        "cardColor": const Color(0xFFDCEBF6),
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const AddNewIdeaButton(),
          SizedBox(height: 16.h),

          // قائمة الكروت
          Expanded(
            child: ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: InkWell(
                    onTap: () {
                      // context.push("/investmentsView");
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: companies[index]["cardColor"],
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
                                  companies[index]["image"]!,
                                  width: 30.w,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 16.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            companies[index]["name"]!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            companies[index]["price"]!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Fintech app development provides more freedom to banking and other financial institutions.",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          LinearProgressIndicator(
                            value: companies[index]["progress"],
                            backgroundColor: Colors.grey[300],
                            color: Colors.black,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${(companies[index]["progress"] * 100).toInt()}% In Progress",
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
          ),
        ],
      ),
    );
  }
}
