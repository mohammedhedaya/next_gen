import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:next_gen/core/cache/cache_helper.dart';
import 'package:next_gen/core/constants/constants.dart';
import 'package:next_gen/core/service/service_locator.dart';
import 'package:next_gen/features/auth/presentation/views/choose_login.dart';
import 'package:next_gen/features/auth/presentation/views/login_view.dart';
import 'package:next_gen/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:next_gen/features/home/presentation/widgets/search_view_screen.dart';
import 'package:next_gen/features/investments/presentation/views/investments_view.dart';
import 'package:next_gen/features/news/cubit/news_cubit.dart';
import 'package:next_gen/features/news/presentation/views/news_view.dart';
import 'package:next_gen/features/onboarding/views/onboarding_view.dart';
import 'package:next_gen/features/profile/presentation/widgets/information.dart';
import 'package:next_gen/features/start_up/presentation/views/start_up_view.dart';

final CacheHelper cache = getIt<CacheHelper>();
final bool? onBoardingDone = cache.getData(key: "onBoardingDone");
final String? userId = cache.getData(key: "userId");

final GoRouter router = GoRouter(
  initialLocation:
      onBoardingDone == true
          ? (userId == null ? '/chooselogin' : '/bottomNavBar')
          : '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const OnboardingPage()),
    GoRoute(
      path: '/chooselogin',
      builder: (context, state) => const ChooseLogin(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    GoRoute(
      path: '/bottomNavBar',
      builder: (context, state) => const BottomNavBar(),
    ),
    GoRoute(
      path: '/investmentsView',
      builder: (context, state) => const InvestmentsView(),
    ),
    GoRoute(
      path: '/startUpView',
      builder: (context, state) => const StartUpView(),
    ),
    GoRoute(
      path: '/searchView',
      builder: (context, state) => const SearchView(),
    ),
     GoRoute(
      path: '/teamPage',
      builder: (context, state) =>  TeamPage(),
    ),
    GoRoute(path: '/newsView', builder: (context, state) => const NewsView()),
  ],
);
