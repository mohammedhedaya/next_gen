import 'package:next_gen/core/utils/assets.dart';
import 'package:next_gen/features/onboarding/components/onboarding_info.dart';

class OnboardingData {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      text: "Empowering Visionaries, Connecting Innovators with Investors",
      image: Assets.imagesOnboardingOne,
    ),

    OnboardingInfo(
      text:
          "A dynamic platform designed to connect startups with aspiring investors.",
      image: Assets.imagesOnboardingTwo,
    ),

    OnboardingInfo(
      text:
          "Showcase ongoing or high-performing projects with thumbnails, brief summaries, and funding Progress Bars.",
      image: Assets.imagesOnboardingThree,
    ),
  ];
}
