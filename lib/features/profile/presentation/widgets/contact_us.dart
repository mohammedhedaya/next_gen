import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/assets.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  final String instagramUrl =
      "https://www.instagram.com/next_gen_inovators_/?utm_source=qr#";
  final String whatsappUrl = "https://wa.me/201027888676";

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Want to know more?', style: AppStyles.style14W400ConstactUs),
        SizedBox(height: 10.h),
        Text('Follow us', style: AppStyles.style14W400ConstactUs),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                Assets.imagesInstagramLogo2022,
                width: 50.w,
                height: 50.h,
              ),
              onPressed: () => _launchUrl(instagramUrl),
            ),
            SizedBox(width: 20.w),
            IconButton(
              icon: SvgPicture.asset(
                Assets.imagesLogoWhatsapp,
                width: 40.w,
                height: 40.h,
              ),
              onPressed: () => _launchUrl(whatsappUrl),
            ),
          ],
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1,
          indent: 40.w,
          endIndent: 40.w,
        ),
        Text(
          'Powered by',
          style: TextStyle(
            fontFamily: 'KaushanScript-Regular',
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textColorOnboardingThree,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'nextGen Team',
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'KaushanScript-Regular',
                color: AppColors.buttomOneInLogin,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
