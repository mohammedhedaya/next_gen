import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';
import 'package:next_gen/core/utils/assets.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recommended", style: AppStyles.style21W600)],
        ),
         SizedBox(height: 15.h),
        Wrap(
          spacing: 10,
          children: [
            _buildCategoryChip(Assets.imagesFinance, "Finance"),
            _buildCategoryChip(Assets.imagesDesign, "Design"),
            _buildCategoryChip(Assets.imagesHealth, "Health"),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String iconPath, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
           SizedBox(width: 6.w),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
