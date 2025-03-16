import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/news/presentation/widgets/news_card_widget.dart';

class NewsViewBody extends StatelessWidget {
  const NewsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: ListView(
          children: [
            const NewsCard(
              imageUrl: Assets.imagesImageTestNews1,
              title:
                  "UAE-Based Stargazer Raises \$5M to Expand Telegram-Based Crypto Trading",
              companyName: "Stargazer",
              date: "Mar 3, 2025",
              logoUrl: Assets.imagesLogoInCaed2,
            ),
            SizedBox(height: 20.h),
            const NewsCard(
              imageUrl: Assets.imagesImageTestNews2,
              title:
                  "UAE-Based Stargazer Raises \$5M to Expand Telegram-Based Crypto Trading",
              companyName: "Stargazer",
              date: "Mar 3, 2025",
              logoUrl: Assets.imagesLogoInCaed3,
            ),
          ],
        ),
      ),
    );
  }
}
