import 'package:flutter/material.dart';
import 'package:next_gen/core/shared/custom_app_bar.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/features/news/presentation/widgets/news_view_body.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar(), body: NewsViewBody());
  }
}
