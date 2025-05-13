import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/home/data/investment_model.dart';

class InvestmentsListViewSection extends StatelessWidget {
  const InvestmentsListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('investments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("لا توجد أفكار استثمارية حاليًا"));
          }

          final docs = snapshot.data!.docs;
          final investments =
              docs.map((doc) => InvestmentModel.fromFirestore(doc)).toList();

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // تم إضافة هذا السطر
                        children: [
                          // العنوان + السهم
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 24.r,
                                child: Image.asset(Assets.imagesLogoInCaed),
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
                            investment.title,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "EGP${investment.amount.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Expanded(
                            // تم استبدال Flexible بـ Expanded
                            child: Text(
                              investment.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize:
                                MainAxisSize.min, // تم إضافة هذا السطر
                            children: [
                              LinearProgressIndicator(
                                value: investment.progress / 100,
                                backgroundColor: Colors.grey[300],
                                color: Colors.black,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "${investment.progress.toStringAsFixed(0)}% In Progress",
                                style: TextStyle(
                                  fontSize: 14.sp,
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
          );
        },
      ),
    );
  }
}
