import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/utils/app_colors.dart';
import 'package:next_gen/features/news/cubit/news_cubit.dart';
import 'package:next_gen/features/news/presentation/widgets/news_card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsViewBody extends StatelessWidget {
  const NewsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return ListView.separated(
              itemCount: state.newsModel.articles?.length ?? 0,
              separatorBuilder: (_, __) => SizedBox(height: 20.h),
              itemBuilder: (context, index) {
                final article = state.newsModel.articles![index];
                return NewsCard(
                  imageUrl: article.urlToImage ?? '', // Ensure this is a valid URL
                  title: article.title ?? '',
                  companyName: article.source?.name ?? '',
                  date: article.publishedAt ?? '',
                  logoUrl: '', // Adjust if needed
                );
              },
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
