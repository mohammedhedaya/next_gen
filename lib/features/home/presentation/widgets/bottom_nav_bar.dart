import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/home/presentation/views/home_view.dart';
import 'package:next_gen/features/investments/presentation/views/investments_view.dart';
import 'package:next_gen/features/news/presentation/views/news_view.dart';
import 'package:next_gen/features/profile/presentation/views/profile_view.dart';
import '../../../../core/utils/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeView(),
      const InvestmentsView(),
      const NewsView(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder:
            (child, animation) =>
                FadeTransition(opacity: animation, child: child),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: GNav(
          gap: 10.w,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          color: AppColors.grayColor,
          activeColor: AppColors.primaryColor,
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: [
            _buildNavBarItem(Assets.imagesHomeIcon, "Home", 0),
            _buildNavBarItem(Assets.imagesInvestments, "Investments", 1),
            _buildNavBarItem(Assets.imagesNews, "News", 2),
            _buildNavBarItem(Assets.imagesProfile, "Profile", 3),
          ],
        ),
      ),
    );
  }

  GButton _buildNavBarItem(String iconPath, String text, int index) {
    return GButton(
      icon: Icons.clear,
      iconSize: 0,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              _currentIndex == index
                  ? AppColors.primaryColor
                  : AppColors.grayColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            text,
            style: TextStyle(
              color:
                  _currentIndex == index
                      ? AppColors.primaryColor
                      : AppColors.grayColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
