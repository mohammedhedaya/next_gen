import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/home/data/recommended_investments_model.dart';

class InvestmentsRecommended extends StatelessWidget {
  const InvestmentsRecommended({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h, // زيادة الارتفاع لتجنب الـ overflow
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('Recommended Investments')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final investments =
              snapshot.data!.docs
                  .map((doc) => RecommendedInvestmentModel.fromFirestore(doc))
                  .toList();

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: investments.length,
            itemBuilder: (context, index) {
              final investment = investments[index];

              return InkWell(
                onTap: () {
                  context.push("/InvestmentsView");
                },
                child: SizedBox(
                  width: 180.w,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 4,
                    color: AppColors.colorInCardHome,
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // الصورة والسهم
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 22.r, // تصغير نصف القطر قليلاً
                                    child: Image.asset(
                                      Assets.imagesLogoInCaed3,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(),
                                    ),
                                    padding: EdgeInsets.all(
                                      5.w,
                                    ), // تصغير الحشوة
                                    child: Icon(
                                      Icons.arrow_outward,
                                      size: 18.sp, // تصغير حجم الأيقونة
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              // العنوان
                              Text(
                                investment.title,
                                style: TextStyle(
                                  fontSize: 16.sp, // تصغير حجم الخط
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              // المبلغ
                              Text(
                                "EGP${investment.amount}",
                                style: TextStyle(
                                  fontSize: 11.sp, // تصغير حجم الخط
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              // الوصف
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    investment.description,
                                    style: TextStyle(
                                      fontSize: 14.sp, // تصغير حجم الخط
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              // شريط التقدم والنسبة
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LinearProgressIndicator(
                                    value: investment.progress / 100,
                                    backgroundColor: Colors.grey[300],
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "${investment.progress.toStringAsFixed(0)}% In Progress",
                                    style: TextStyle(
                                      fontSize: 14.sp, // تصغير حجم الخط
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorInProgress,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
