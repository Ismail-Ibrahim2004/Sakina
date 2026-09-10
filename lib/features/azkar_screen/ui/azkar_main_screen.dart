import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noorr/features/azkar_screen/ui/azkar_viewer_screen.dart';

import '../../../core/core_widgets/custom_scaffold.dart';
import '../../../core/core_widgets/custom_text.dart';
import '../../../core/style/my_colors.dart';
import '../../../core/style/my_text_style.dart';

class AzkarMainScreen extends StatelessWidget {
  const AzkarMainScreen({super.key});

  static const List<Map<String, dynamic>> azkarCategories = [
    {'id': 'salah', 'title': 'بعد الصلاة', 'icon': Icons.auto_awesome_outlined},
    {
      'id': 'masaa',
      'title': 'أذكار المساء',
      'icon': Icons.nights_stay_outlined,
    },
    {'id': 'nawm', 'title': 'أذكار النوم', 'icon': Icons.bedtime_outlined},
    {
      'id': 'safar',
      'title': 'أذكار السفر',
      'icon': Icons.flight_takeoff_rounded,
    },
    {'id': 'manzil', 'title': 'أذكار المنزل', 'icon': Icons.home_outlined},
    {'id': 'taaam', 'title': 'أذكار الطعام', 'icon': Icons.restaurant_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 15.h),
               CustomText(
                text: 'الأذكار',
                style: MyTextStyle.appbarTitle,
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AzkarViewer(
                      categoryId: 'sabah',
                      categoryTitle: 'أذكار الصباح',
                    ),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 22.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: const LinearGradient(
                      colors: [MyColors.primaryGold, MyColors.darkGold],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.primaryGold.withOpacity(0.35),
                        blurRadius: 18.r,
                        offset: Offset(0, 6.h),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            text: 'أذكار الصباح',
                            style: MyTextStyle.welcomeTitle.copyWith(fontSize: 22.sp),
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            text: 'ابدأ يومك بذكر الله',
                            style: MyTextStyle.lastReadInfo.copyWith(
                              color: MyColors.darkBackground.withOpacity(0.75),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Container(
                        width: 56.r,
                        height: 56.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.darkBackground.withOpacity(0.15),
                        ),
                        child: Icon(
                          Icons.wb_sunny_rounded,
                          color: MyColors.darkBackground,
                          size: 32.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: 1.15,
                  ),
                  itemCount: azkarCategories.length,
                  itemBuilder: (context, index) {
                    final category = azkarCategories[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AzkarViewer(
                            categoryId: category['id'] as String,
                            categoryTitle: category['title'] as String,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.cardBackground.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: MyColors.white.withOpacity(0.07),
                            width: 1.2.w,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 56.r,
                              height: 56.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.secondaryGold.withOpacity(0.15),
                              ),
                              child: Icon(
                                category['icon'] as IconData,
                                color: MyColors.primaryGold,
                                size: 28.r,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            CustomText(
                              text: category['title'].toString(),
                              style: MyTextStyle.cardSubtitle.copyWith(
                                color: MyColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 14.h),
            ],
          ),
        ),
      ),
    );
  }
}

