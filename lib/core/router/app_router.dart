import 'package:go_router/go_router.dart';
import 'package:next_gen/core/constants/constants.dart';
import 'package:next_gen/features/auth/presentation/views/choose_login.dart';
import 'package:next_gen/features/auth/presentation/views/login_view.dart';
import 'package:next_gen/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:next_gen/features/investments/presentation/views/investments_view.dart';
import 'package:next_gen/features/onboarding/views/onboarding_view.dart';
import 'package:next_gen/features/start_up/presentation/views/start_up_view.dart';

final GoRouter router = GoRouter(
  initialLocation: token == null ? '/' : '/homeview',
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
  ],
);
