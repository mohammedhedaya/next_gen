import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/profile/presentation/widgets/contact_us.dart';
import 'package:next_gen/features/profile/presentation/widgets/profile_menu_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w), // جعل التباعد متجاوبًا
        child: Column(
          children: [
            SizedBox(
              width: 120.w, // جعل العرض متجاوبًا
              height: 120.h, // جعل الارتفاع متجاوبًا
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  100.r,
                ), // ضبط الحدود بشكل متجاوب
                child: Image.asset(Assets.imagesOmar),
              ),
            ),
            SizedBox(height: 10.h), // ضبط المسافات
            Text('Omar Hesham', style: AppStyles.style14W400),
            Text('omar.hesham.213@gmail.com', style: AppStyles.style12W400),
            SizedBox(height: 20.h),

            Divider(thickness: 1.h), // ضبط الخط الفاصل ليكون متجاوبًا
            SizedBox(height: 10.h),

            /// القائمة
            ProfileMenuWidget(
              title: 'Our Location',
              icon: LineAwesomeIcons.location_arrow_solid,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Billing Details',
              icon: LineAwesomeIcons.wallet_solid,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'User Management',
              icon: LineAwesomeIcons.user_check_solid,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Information',
              icon: LineAwesomeIcons.info_solid,
              onPress: () {},
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Logout',
              icon: LineAwesomeIcons.sign_out_alt_solid,
              textColor: Colors.red,
              onPress: () {},
              endIcon: true,
            ),

            SizedBox(height: 30.h),
            const ContactUs(),
          ],
        ),
      ),
    );
  }
}
