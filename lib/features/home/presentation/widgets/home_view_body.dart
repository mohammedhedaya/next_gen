import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/features/home/presentation/widgets/home_search_bar_widget.dart';
import 'package:next_gen/features/home/presentation/widgets/investments_list_view_section.dart';
import 'package:next_gen/features/home/presentation/widgets/investments_recommended.dart';
import 'package:next_gen/features/home/presentation/widgets/my_investments_title_and_view_all.dart';
import 'package:next_gen/features/home/presentation/widgets/recommended_title.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: HomeSearchBarWidget()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: MyInvestmentsTitleAndViewAll()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: InvestmentsListViewSection()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: RecommendedSection()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: InvestmentsRecommended()),
          ],
        ),
      ),
    );
  }
}
