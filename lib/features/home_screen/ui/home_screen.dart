import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noorr/features/home_screen/ui/widgets/zikr_counter.dart';
import 'package:provider/provider.dart';
import 'package:hijri/hijri_calendar.dart';
import '../../../core/core_widgets/custom_appbar.dart';
import '../../../core/core_widgets/custom_scaffold.dart';
import '../../../core/core_widgets/custom_text.dart';
import '../../../core/style/my_text_style.dart';
import '../../../core/style/my_colors.dart';
import '../../azkar_screen/ui/azkar_viewer_screen.dart';
import '../../sora_screen/ui/surah_viewer.dart';
import '../UI/widgets/azker_card.dart';
import '../../quran_screen/logic/quran_provider.dart';
import '../../prayer_times_screen/logic/prayer_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    var today = HijriCalendar.now();
    String hijriDate = '\u200F${today.hDay} ${today.longMonthName} ${today.hYear}هـ';

    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(22.0.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppbar(
                  icon: Icons.notifications_none_outlined,
                  describeText: hijriDate,
                  text: "السلام عليكم",
                ),
                SizedBox(height: 20.h),
                
                Consumer<QuranProvider>(
                  builder: (context, quranProvider, child) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SurahViewer(
                              initialPage: quranProvider.lastReadPage,
                              surahName: quranProvider.lastReadSurah,
                            ),
                          ),
                        ).then((_) => quranProvider.loadLastReadPage());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.primaryGold.withOpacity(0.8),
                              MyColors.darkGold.withOpacity(0.85),
                            ],
                            begin: AlignmentGeometry.topLeft,
                            end: AlignmentGeometry.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.menu_book, size: 55.r, color: MyColors.darkBackground),
                            SizedBox(width: 15.w),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: "القرآن الكريم",
                                    style: MyTextStyle.welcomeTitle,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerRight,
                                    child: CustomText(
                                      text: "آخر قراءة: سورة ${quranProvider.lastReadSurah}",
                                      style: MyTextStyle.lastReadInfo,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                SizedBox(height: 20.h),
                
                Row(
                  children: [
                    Expanded(
                      child: AzkarSection(
                        icon: Icons.nights_stay_rounded,
                        title: "أذكار المساء",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AzkarViewer(
                              categoryId: 'masaa',
                              categoryTitle: 'أذكار المساء',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: AzkarSection(
                        icon: Icons.wb_sunny_outlined,
                        title: "أذكار الصباح",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AzkarViewer(
                              categoryId: 'sabah',
                              categoryTitle: 'أذكار الصباح',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 20.h),
                const ZikrCounter(),
                SizedBox(height: 20.h),
                
                Consumer<PrayerProvider>(
                  builder: (context, prayerProvider, child) {
                    if (prayerProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator(color: MyColors.primaryGold));
                    }
                    
                    final nextIndex = prayerProvider.getNextPrayerIndex();
                    final nextName = prayerProvider.prayerInfo[nextIndex]['name'] as String;
                    final nextTime = prayerProvider.getAllPrayerTimes()[nextIndex];
                    
                    return Container(
                      height: 80.h,
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.white.withOpacity(0.05), width: 1.5.w),
                        color: MyColors.cardBackground.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: prayerProvider.formatTime(nextTime),
                            style: MyTextStyle.nextPrayerTime,
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'الصلاة القادمة',
                                style: MyTextStyle.nextPrayerLabel,
                              ),
                              CustomText(
                                text: 'صلاة $nextName',
                                style: MyTextStyle.prayerNameLarge,
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: MyColors.secondaryGold.withOpacity(0.2),
                            ),
                            child: Icon(
                              Icons.access_time_outlined,
                              color: MyColors.primaryGold,
                              size: 28.r,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

