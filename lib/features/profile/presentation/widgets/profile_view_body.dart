import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:next_gen/core/cache/cache_helper.dart';
import 'package:next_gen/core/service/service_locator.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/profile/presentation/widgets/contact_us.dart';
import 'package:next_gen/features/profile/presentation/widgets/profile_menu_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final String name = user?.displayName ?? 'Guest User';
    final String email = user?.email ?? 'No email';
    final String? photoUrl = user?.photoURL;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(
              width: 120.w,
              height: 120.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child:
                    photoUrl != null
                        ? Image.network(photoUrl, fit: BoxFit.cover)
                        : Image.asset(
                          Assets.imagesDefaultimage,
                        ), // حط صورة افتراضية عندك هنا
              ),
            ),
            SizedBox(height: 10.h),
            Text(name, style: AppStyles.style14W400),
            Text(email, style: AppStyles.style12W400),
            SizedBox(height: 20.h),

            Divider(thickness: 1.h),
            SizedBox(height: 10.h),
            ProfileMenuWidget(
              title: 'Information',
              icon: LineAwesomeIcons.info_solid,
              onPress: () {
                context.push('/TeamPage');
              },
              endIcon: true,
            ),
            ProfileMenuWidget(
              title: 'Logout',
              icon: LineAwesomeIcons.sign_out_alt_solid,
              textColor: Colors.red,
              onPress: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        backgroundColor: AppColors.whiteColor,
                        title: const Text("Confirm Logout"),
                        content: const Text(
                          "Are you sure you want to log out?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );

                if (confirm == true) {
                  await FirebaseAuth.instance.signOut();

                  // حذف التوكن من الكاش
                  await getIt<CacheHelper>().removeData(key: 'token');
                  await getIt<CacheHelper>().removeData(key: 'userId');
                  context.go('/chooselogin');
                }
              },
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
