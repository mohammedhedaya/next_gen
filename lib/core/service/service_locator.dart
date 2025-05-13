import 'package:get_it/get_it.dart';
import 'package:next_gen/features/news/cubit/news_cubit.dart';

import '../cache/cache_helper.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerFactory<NewsCubit>(() => NewsCubit());
}
