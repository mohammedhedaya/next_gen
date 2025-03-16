import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/core/utils/app_text_style.dart';

class MyInvestmentsTitleAndViewAll extends StatelessWidget {
  const MyInvestmentsTitleAndViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("My Investments", style: AppStyles.style21W600),
        TextButton.icon(
          onPressed: () {
            context.push("/InvestmentsView");
          },
          label: Text("View All", style: AppStyles.style12W400),
          icon: const Icon(Icons.arrow_forward_ios),
          iconAlignment: IconAlignment.end,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: 0,
            iconColor: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
