import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_gen/core/app/app.dart';
import 'package:next_gen/core/cache/cache_helper.dart';
import 'package:next_gen/core/function/get_user_token.dart';
import 'package:next_gen/core/service/service_locator.dart';
import 'package:next_gen/core/utils/my_bloc_observer.dart';
import 'package:next_gen/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await ScreenUtil.ensureScreenSize();
  await getIt<CacheHelper>().init();
  await getUserTokenAndID();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}
