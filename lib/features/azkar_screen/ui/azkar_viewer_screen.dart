import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/core_widgets/custom_text.dart';
import '../../../core/style/my_text_style.dart';
import '../../../core/style/my_colors.dart';
import '../logic/azkar_provider.dart';

class AzkarViewer extends StatefulWidget {
  final String categoryId;
  final String categoryTitle;

  const AzkarViewer({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
  });

  @override
  State<AzkarViewer> createState() => _AzkarViewerState();
}

class _AzkarViewerState extends State<AzkarViewer> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AzkarProvider>().loadAzkar(widget.categoryId);
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.darkBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(
              color: MyColors.secondaryGold.withOpacity(0.5),
              width: 1.5.w,
            ),
          ),
          title: Center(
            child: Icon(
              Icons.verified,
              color: MyColors.secondaryGold,
              size: 50.r,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'تقبل الله طاعتك!',
                textAlign: TextAlign.center,
                style: MyTextStyle.tajawal.copyWith(
                  color: MyColors.secondaryGold,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              CustomText(
                text:
                    'لقد أتممت هذه الأذكار المباركة.\nجعلها الله في ميزان حسناتك ونفعك بها في الدنيا والآخرة.',
                textAlign: TextAlign.center,
                style: MyTextStyle.tajawal.copyWith(
                  color: MyColors.white,
                  fontSize: 18.sp,
                  height: 1.5,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.secondaryGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: CustomText(
                text: 'جزاك الله خيراً',
                style: MyTextStyle.tajawal.copyWith(
                  color: MyColors.darkBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkBackground,
      body: Consumer<AzkarProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: MyColors.secondaryGold),
            );
          }

          if (provider.azkar.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "لا توجد أذكار أو حدث خطأ في التحميل",
                    style: TextStyle(color: MyColors.white, fontSize: 20.sp),
                  ),
                  SizedBox(height: 20.h),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyColors.secondaryGold,
                      size: 24.r,
                    ),
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Share.share(
                            'جرب تطبيق الأذكار ❤️\n${provider.currentZikr}',
                          );
                        },
                        icon: Icon(
                          Icons.share,
                          color: MyColors.secondaryGold,
                          size: 24.r,
                        ),
                      ),
                      CustomText(
                        text: widget.categoryTitle,
                        style: MyTextStyle.azkarCategoryTitle,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_forward,
                          color: MyColors.secondaryGold,
                          size: 24.r,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  Flexible(
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: 120.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 25.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.cardBackground.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: MyColors.secondaryGold.withOpacity(0.4),
                          width: 1.5.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 15.r,
                            offset: Offset(0, 5.h),
                          ),
                        ],
                      ),
                      child: RawScrollbar(
                        controller: _scrollController,
                        thumbColor: MyColors.secondaryGold.withOpacity(0.8),
                        thickness: 3.w,
                        radius: Radius.circular(10.r),
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_quote_rounded,
                                color: MyColors.secondaryGold.withOpacity(0.6),
                                size: 28.r,
                              ),
                              SizedBox(height: 12.h),
                              CustomText(
                                text: provider.currentZikr,
                                textAlign: TextAlign.center,
                                style: MyTextStyle.zikrText.copyWith(
                                  fontFamily: 'UthmanicHafs',
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Icon(
                                Icons.format_quote_rounded,
                                color: MyColors.secondaryGold.withOpacity(0.6),
                                size: 28.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 60.h),

                  GestureDetector(
                    onTap: () => provider.increment(_showCompletionDialog),
                    behavior: HitTestBehavior.opaque,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 280.r,
                          height: 280.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.darkBackground,
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.secondaryGold.withOpacity(0.4),
                                blurRadius: 18.r,
                                spreadRadius: 2.r,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 250.r,
                          height: 250.r,
                          child: CircularProgressIndicator(
                            value: provider.progress,
                            strokeWidth: 5.w,
                            backgroundColor: MyColors.white10,
                            valueColor: const AlwaysStoppedAnimation(
                              MyColors.secondaryGold,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: '${provider.count}',
                              style: MyTextStyle.counterText,
                            ),
                            CustomText(
                              text: '/ ${provider.targetCount}',
                              style: MyTextStyle.cardSubtitle.copyWith(
                                color: Colors.white70,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            CustomText(
                              text: 'العدّاد الحالي',
                              style: MyTextStyle.nextPrayerLabel.copyWith(
                                color: MyColors.white54,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 20.r,
                          right: 20.r,
                          child: GestureDetector(
                            onTap: provider.reset,
                            child: Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.darkBackground.withOpacity(
                                  0.85,
                                ),
                                border: Border.all(
                                  color: MyColors.secondaryGold.withOpacity(.9),
                                  width: 2.5.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColors.secondaryGold.withOpacity(
                                      0.5,
                                    ),
                                    blurRadius: 12.r,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: MyColors.secondaryGold,
                                size: 28.r,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
