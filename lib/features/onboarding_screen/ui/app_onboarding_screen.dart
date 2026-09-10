import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/core_widgets/custom_scaffold.dart';
import '../../../core/core_widgets/custom_text.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/style/my_colors.dart';
import '../../../core/style/my_text_style.dart';

class AppOnboardingScreen extends StatefulWidget {
  const AppOnboardingScreen({super.key});

  @override
  State<AppOnboardingScreen> createState() => _AppOnboardingScreenState();
}

class _AppOnboardingScreenState extends State<AppOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "مرحباً بك في سَكِينَة",
      "desc":
          "رفيقك اليومي في قراءة القرآن، والأذكار، ومواقيت الصلاة بطمأنينة وخشوع.",
      "image": "assets/images/Splash_logo.png",
    },
    {
      "title": "القرآن الكريم",
      "desc":
          "اقرأ وتدبر آيات الله، واحفظ آخر قراءة لك لتكمل من حيث توقفت بكل سهولة.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "مواقيت الصلاة والأذكار",
      "desc":
          "حافظ على صلاتك في وقتها، وداوم على أذكار الصباح والمساء لتنير يومك.",
      "image": "assets/images/onboarding2.png",
    },
  ];

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('app_has_seen_onboarding', true);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AppRouter()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Image.asset(
                          onboardingData[index]["image"]!,
                          height: 250.h,
                        ),
                        SizedBox(height: 60.h),
                        CustomText(
                          text: onboardingData[index]["title"]!,
                          style: MyTextStyle.welcomeTitle.copyWith(
                            fontSize: 28.sp,
                            color: MyColors.primaryGold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        CustomText(
                          text: onboardingData[index]["desc"]!,
                          style: MyTextStyle.lastReadInfo.copyWith(
                            fontSize: 18.sp,
                            height: 1.5,
                            color: MyColors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: onboardingData.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: MyColors.primaryGold,
                  dotColor: MyColors.white.withOpacity(0.3),
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  expansionFactor: 3,
                  spacing: 8.w,
                ),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage == onboardingData.length - 1) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryGold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: CustomText(
                    text: _currentPage == onboardingData.length - 1
                        ? "ابدأ الآن"
                        : "التالي",
                    style: MyTextStyle.tajawal.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBackground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
