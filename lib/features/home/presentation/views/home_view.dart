import 'package:flutter/material.dart';
import 'package:next_gen/core/shared/custom_app_bar.dart';
import 'package:next_gen/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar(), body: HomeViewBody());
  }
}
