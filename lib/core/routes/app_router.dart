import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/azkar_screen/ui/azkar_main_screen.dart';
import '../../features/home_screen/UI/home_screen.dart';
import '../../features/prayer_times_screen/ui/prayer_times_screen.dart';
import '../../features/quran_screen/ui/quran_screen.dart';
import '../../features/settings_screen/ui/settings_screen.dart';

import '../style/my_colors.dart';
import '../style/my_text_style.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  int currentIndex = 4;

  final List<Widget> pages = [
    const SettingsScreen(),
    const PrayerTimesScreen(),
    const AzkarMainScreen(),
    const QuranScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.darkBackground,
        selectedItemColor: MyColors.primaryGold,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: MyColors.white54,
        currentIndex: currentIndex,
        selectedLabelStyle: MyTextStyle.tajawal.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 11.sp,
        ),
        unselectedLabelStyle: MyTextStyle.tajawal.copyWith(fontSize: 10.sp),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 24.r),
            activeIcon: Icon(
              Icons.settings,
              color: MyColors.primaryGold,
              size: 24.r,
            ),
            label: 'الإعدادات',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined, size: 24.r),
            activeIcon: Icon(Icons.access_time_filled, size: 24.r),
            label: 'المواقيت',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/islam.png',
              width: 24.w,
              height: 24.h,
              color: MyColors.white54,
            ),
            activeIcon: Image.asset(
              'assets/images/islam.png',
              width: 24.w,
              height: 24.h,
              color: MyColors.primaryGold,
            ),
            label: 'الأذكار',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/quran.png',
              width: 24.w,
              height: 24.h,
              color: MyColors.white54,
            ),
            activeIcon: Image.asset(
              'assets/images/quran.png',
              width: 24.w,
              height: 24.h,
              color: MyColors.primaryGold,
            ),
            label: 'القرآن',
          ),

          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/main.png',
              width: 24.w,
              height: 24.h,
              color: MyColors.white54,
            ),
            activeIcon: Image.asset(
              'assets/images/main.png',
              width: 24.w,
              height: 24.h,
              color: MyColors.primaryGold,
            ),
            label: 'الرئيسية',
          ),
        ],
      ),
    );
  }
}
