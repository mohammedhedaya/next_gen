import 'package:flutter/foundation.dart';
import 'package:next_gen/core/cache/cache_helper.dart';
import 'package:next_gen/core/constants/constants.dart';
import 'package:next_gen/core/service/service_locator.dart';

String? userId;

Future<void> getUserTokenAndID() async {
  userId = await getIt<CacheHelper>().getData(key: "userId");

  if (kDebugMode) {
    print("userId is $userId");
  }
}
