import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/core_widgets/custom_scaffold.dart';
import '../../../core/core_widgets/custom_text.dart';
import '../../../core/style/my_colors.dart';
import '../../../core/style/my_text_style.dart';
import '../logic/prayer_provider.dart';
import 'Widgets/prayer_card.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<PrayerProvider>(
        builder: (context, prayerProvider, child) {
          if (prayerProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: MyColors.primaryGold),
            );
          }

          final nextIndex = prayerProvider.getNextPrayerIndex();
          final nextName =
              prayerProvider.prayerInfo[nextIndex]['name'] as String;
          final countdown = prayerProvider.getTimeUntilNextPrayer();
          final times = prayerProvider.getAllPrayerTimes();
          final currentIndex = prayerProvider.getCurrentPrayerIndex();

          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: MyColors.primaryGold,
                          size: 22.r,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: 'مواقيت الصلاة',
                              style: MyTextStyle.prayerHeaderTitle,
                            ),
                            CustomText(
                              text: prayerProvider.cityName,
                              style: MyTextStyle.locationLabel,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 22.h,
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            MyColors.primaryGold,
                            MyColors.secondaryGold,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22.r),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.primaryGold.withOpacity(0.35),
                            blurRadius: 18.r,
                            offset: Offset(0, 6.h),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomText(
                            text: 'الصلاة القادمة: $nextName',
                            style: MyTextStyle.nextPrayerStatus,
                          ),
                          SizedBox(height: 10.h),
                          CustomText(
                            text: prayerProvider.formatCountdown(countdown),
                            style: MyTextStyle.countdownText,
                          ),
                          SizedBox(height: 6.h),
                          CustomText(
                            text: 'متبقي على رفع الأذان',
                            style: MyTextStyle.countdownDesc,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Column(
                      children: List.generate(
                        prayerProvider.prayerInfo.length,
                        (i) {
                          final bool isCurrent = (i == currentIndex);
                          final bool isNext = (i == nextIndex);
                          final String timeStr = times.isNotEmpty
                              ? prayerProvider.formatTime(times[i])
                              : '--:--';

                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: PrayerCard(
                              name:
                                  prayerProvider.prayerInfo[i]['name']
                                      as String,
                              icon:
                                  prayerProvider.prayerInfo[i]['icon']
                                      as IconData,
                              time: timeStr,
                              isCurrent: isCurrent,
                              isNext: isNext,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

