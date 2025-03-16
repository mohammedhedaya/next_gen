import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/router/app_router.dart';
import 'package:next_gen/core/utils/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'NextGen',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
                    scaffoldBackgroundColor: AppColors.primaryColor,
          ),
          routerConfig: router,
        );
      },
    );
  }
}
