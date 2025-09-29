import 'package:flutter/material.dart';
import 'package:islami_app_online_sun/core/resources/assets_manager.dart';
import 'package:islami_app_online_sun/features/onboarding/widgets/on_boarding_item.dart';
import 'package:islami_app_online_sun/features/onboarding/widgets/onboarding_indicator_widget.dart';
import 'package:islami_app_online_sun/models/onboarding_model.dart';

class OnboradingScreen extends StatefulWidget {
  const OnboradingScreen({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

class _OnboradingScreenState extends State<OnboradingScreen> {
  int currentPageIndex = 0;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Image.asset(ImageAssets.islamiLogo),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: OnboardingModel.onboardingPages.length,
                  onPageChanged: (index) {
                    currentPageIndex = index;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingItem(
                      model: OnboardingModel.onboardingPages[index],
                    );
                  },
                ),
              ),
              OnboardingIndicatorWidget(
                currentPageIndex: currentPageIndex,
                pageController: pageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
