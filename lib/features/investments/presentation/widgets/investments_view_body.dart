import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/home/data/investment_model.dart';
import 'package:rxdart/rxdart.dart';

class InvestmentsViewBody extends StatelessWidget {
  const InvestmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: StreamBuilder<List<InvestmentModel>>(
        stream: Rx.combineLatest2(
          FirebaseFirestore.instance.collection('investments').snapshots().map((
            snapshot,
          ) {
            return snapshot.docs.map((doc) {
              return InvestmentModel.fromFirestore(doc);
            }).toList();
          }),
          FirebaseFirestore.instance
              .collection('Recommended Investments')
              .snapshots()
              .map((snapshot) {
                return snapshot.docs.map((doc) {
                  return InvestmentModel.fromFirestore(doc);
                }).toList();
              }),
          (
            List<InvestmentModel> investments,
            List<InvestmentModel> recommendedInvestments,
          ) {
            return [
              ...investments,
              ...recommendedInvestments,
            ]; // دمج البيانات من كل من 'investments' و 'Recommended Investments'
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final investments = snapshot.data ?? [];

          return ListView.builder(
            itemCount: investments.length,
            itemBuilder: (context, index) {
              final investment = investments[index];
              Color cardColor =
                  index == investments.length - 1
                      ? AppColors.colorInCard3Home
                      : (index.isEven
                          ? AppColors.colorInCardHome
                          : AppColors.colorInCard2Home);

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: cardColor,
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
                                Assets.imagesLogoInCaed,
                                width: 30.w,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  investment.title,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "EGP${investment.amount}",
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
                          investment.description, // عرض الوصف من الـ Firestore
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Progress bar with percentage
                        LinearProgressIndicator(
                          value:
                              investment.progress /
                              100, // تحويل النسبة إلى قيم بين 0 و 1
                          backgroundColor: Colors.grey[300],
                          color: Colors.black,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${(investment.progress).toStringAsFixed(0)}% In Progress",
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
          );
        },
      ),
    );
  }
}
