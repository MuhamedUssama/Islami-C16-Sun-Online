import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:islami_app_online_sun/core/cache/prefs_manager.dart';
import 'package:islami_app_online_sun/core/resources/colors_manager.dart';
import 'package:islami_app_online_sun/core/routes_manager/routes_manager.dart';
import 'package:islami_app_online_sun/models/onboarding_model.dart';

class OnboardingIndicatorWidget extends StatelessWidget {
  final int currentPageIndex;
  final PageController pageController;

  const OnboardingIndicatorWidget({
    super.key,
    required this.currentPageIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentPageIndex == 0
            ? const SizedBox(width: 64)
            : TextButton(
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  'Back',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(fontSize: 16),
                ),
              ),
        DotsIndicator(
          dotsCount: OnboardingModel.onboardingPages.length,
          position: currentPageIndex.toDouble(),
          decorator: DotsDecorator(
            activeColor: ColorsManager.gold,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (currentPageIndex < 4) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              await PrefsManager.setOnboardingSeen();
              Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
            }
          },
          child: Text(
            currentPageIndex < 4 ? 'Next' : 'Finish',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
