import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noorr/features/settings_screen/ui/widgets/setting_card.dart';
import 'package:provider/provider.dart';

import '../../../core/core_widgets/custom_appbar.dart';
import '../../../core/core_widgets/custom_scaffold.dart';
import '../../../core/core_widgets/custom_text.dart';
import '../../../core/style/my_colors.dart';
import '../../../core/style/my_text_style.dart';
import '../../prayer_times_screen/logic/prayer_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isPrayerSettingsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(22.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomAppbar(
                  text: "الإعدادات",
                  icon: Icons.settings_outlined,
                ),
                SizedBox(height: 30.h),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.cardBackground.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: MyColors.white.withOpacity(0.05),
                      width: 1.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      SettingCard(
                        title: 'التنبيهات',
                        icon: Icons.notifications_active,
                        showDivider: true,
                        onTap: () {},
                      ),
                      SettingCard(
                        title: 'مظهر التطبيق',
                        subtitle: 'الوضع الداكن',
                        icon: Icons.palette,
                        showDivider: true,
                        onTap: () {},
                      ),
                      SettingCard(
                        title: 'اللغة',
                        subtitle: 'العربية',
                        icon: Icons.language,
                        showDivider: true,
                        onTap: () {},
                      ),

                      SettingCard(
                        title: 'إعدادات أوقات الصلاة',
                        icon: Icons.update,
                        showDivider: true,
                        onTap: () {
                          setState(() {
                            _isPrayerSettingsExpanded = !_isPrayerSettingsExpanded;
                          });
                        },
                        trailing: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return RotationTransition(
                              turns: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(
                            _isPrayerSettingsExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.arrow_back_ios_new,
                            key: ValueKey<bool>(
                              _isPrayerSettingsExpanded,
                            ),
                            color: _isPrayerSettingsExpanded
                                ? MyColors.primaryGold
                                : MyColors.white24,
                            size: 16.r,
                          ),
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        child: _isPrayerSettingsExpanded
                            ? Consumer<PrayerProvider>(
                          builder: (context, prayerProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SettingCard(
                                  title: 'تحسين دقة الموقع',
                                  subtitle:
                                  'تحديث الموقع الحالي وخطوط العرض/الطول',
                                  icon: Icons.my_location,
                                  showDivider: true,
                                  onTap: () async {
                                    await prayerProvider.refreshLocation();
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: CustomText(
                                            text: 'تم تحديث الموقع بنجاح',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SettingCard(
                                  title: 'التوقيت الصيفي (+1 ساعة)',
                                  subtitle:
                                  'فعله إذا كانت مواقيت الصلاة متأخرة ساعة',
                                  icon: Icons.wb_sunny_outlined,
                                  showDivider: false,
                                  trailing: CupertinoSwitch(
                                    activeColor: MyColors.primaryGold,
                                    value: prayerProvider.isSummerTime,
                                    onChanged: (value) {
                                      bool isSystemAlreadyDST =
                                          DateTime.now()
                                              .timeZoneOffset
                                              .inHours >=
                                              3;
                                      prayerProvider.toggleSummerTime(
                                        value,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                            : const SizedBox.shrink(),
                      ),

                      Divider(
                        color: MyColors.white.withOpacity(0.05),
                        height: 1.h,
                        thickness: 1.h,
                      ),

                      SettingCard(
                        title: 'عن التطبيق',
                        icon: Icons.info,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: CustomText(
                    text: "تطبيق سَكِينَة - الإصدار 1.0.0",
                    style: MyTextStyle.locationLabel.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}