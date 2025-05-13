import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/features/home/data/recommended_investments_model.dart';
import 'package:rxdart/rxdart.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                style: AppStyles.style16W400.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  hintText: 'Search by title or description...',
                  hintStyle: AppStyles.style16W400.copyWith(
                    color: Colors.white70,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                  suffixIcon:
                      _searchQuery.isNotEmpty
                          ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                          : null,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Results or Empty State
            Expanded(
              child:
                  _searchQuery.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 60.sp,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Search for investments',
                              style: AppStyles.style24W500.copyWith(
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Type in the search bar above to find investments',
                              style: AppStyles.style14W400.copyWith(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      : StreamBuilder<List<RecommendedInvestmentModel>>(
                        stream: Rx.combineLatest2(
                          FirebaseFirestore.instance
                              .collection('Recommended Investments')
                              .snapshots()
                              .map(
                                (snapshot) =>
                                    snapshot.docs
                                        .map(
                                          (doc) =>
                                              RecommendedInvestmentModel.fromFirestore(
                                                doc,
                                              ),
                                        )
                                        .toList(),
                              ),
                          FirebaseFirestore.instance
                              .collection('investments')
                              .snapshots()
                              .map(
                                (snapshot) =>
                                    snapshot.docs
                                        .map(
                                          (doc) =>
                                              RecommendedInvestmentModel.fromFirestore(
                                                doc,
                                              ),
                                        )
                                        .toList(),
                              ),
                          (
                            List<RecommendedInvestmentModel> recommendedData,
                            List<RecommendedInvestmentModel> investmentsData,
                          ) => [...recommendedData, ...investmentsData],
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                "Error loading data",
                                style: AppStyles.style16W400.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }

                          final investments = snapshot.data ?? [];
                          final filteredInvestments =
                              investments.where((investment) {
                                return investment.title.toLowerCase().contains(
                                      _searchQuery,
                                    ) ||
                                    investment.description
                                        .toLowerCase()
                                        .contains(_searchQuery);
                              }).toList();

                          if (filteredInvestments.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 60.sp,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'No results found',
                                    style: AppStyles.style24W500.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Try a different search term',
                                    style: AppStyles.style14W400.copyWith(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.only(bottom: 20.h),
                            itemCount: filteredInvestments.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final investment = filteredInvestments[index];
                              return Card(
                                color: AppColors.buttomOneInLogin,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Fixed Row with proper constraints
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              investment.title,
                                              style: AppStyles.style21W600
                                                  .copyWith(
                                                    color: Colors.white,
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: 70.w,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors
                                                      .textColorOnboardingTwo,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                'EGP${investment.amount}',
                                                style: AppStyles.style24W500
                                                    .copyWith(
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        investment.description,
                                        style: AppStyles.style14W400.copyWith(
                                          color: Colors.white,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 12.h),
                                      LinearProgressIndicator(
                                        value: investment.progress / 100,
                                        backgroundColor: Colors.grey[800],
                                        color: AppColors.textColorOnboardingTwo,
                                        minHeight: 6.h,
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${investment.progress.toStringAsFixed(0)}% Completed',
                                            style: AppStyles.style12W400
                                                .copyWith(
                                                  color: AppColors.whiteColor,
                                                ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context.push(
                                                "/investmentsView",
                                                extra: investment,
                                              );
                                            },
                                            child: Text(
                                              'View Details',
                                              style: AppStyles.style12W400
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    decoration:
                                                        TextDecoration
                                                            .underline,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
