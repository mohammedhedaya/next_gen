import 'package:flutter/material.dart';
import 'package:next_gen/core/shared/custom_app_bar.dart';
import 'package:next_gen/features/start_up/presentation/widgets/start_up_view_body.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar(), body: StartUpViewBody());
  }
}
