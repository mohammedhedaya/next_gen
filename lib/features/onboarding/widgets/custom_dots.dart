import 'package:flutter/material.dart';
import 'package:next_gen/features/onboarding/components/onboarding_data.dart';

class CustomDots extends StatelessWidget {
  final int currentIndex;

  const CustomDots({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingData();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.items.length,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: currentIndex == index ? Colors.white : Colors.grey,
          ),
          height: 7,
          width: currentIndex == index ? 30 : 7,
          duration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
