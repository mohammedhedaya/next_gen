import 'package:flutter/foundation.dart';
import 'package:next_gen/core/constants/constants.dart';


//! get user token and id 
Future<void> getUserTokenAndID() async {
  // token = await getIt<CacheHelper>().getData(key: ApiKeys.token);
  // userId = await getIt<CacheHelper>().getData(key: ApiKeys.userId);
  if (kDebugMode) {
    print("token is $token");
  }
  if (kDebugMode) {
    print("userId is $userId");
  }
}