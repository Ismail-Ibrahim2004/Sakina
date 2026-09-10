import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core_widgets/custom_text.dart';
import '../../../../core/style/my_colors.dart';
import '../../../../core/style/my_text_style.dart';

class PrayerCard extends StatelessWidget {
  const PrayerCard({
    super.key,
    required this.name,
    required this.icon,
    required this.time,
    required this.isCurrent,
    required this.isNext,
  });

  final String name;
  final IconData icon;
  final String time;
  final bool isCurrent;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    final bool isHighlighted = isNext;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isHighlighted
            ? MyColors.primaryGold.withOpacity(0.1)
            : MyColors.cardBackground.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isNext
              ? MyColors.primaryGold.withOpacity(0.5)
              : MyColors.white.withOpacity(0.05),
          width: isNext ? 1.5.w : 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: time,
            style: MyTextStyle.tajawal.copyWith(
              color: isHighlighted ? MyColors.primaryGold : MyColors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          Row(
            children: [
              CustomText(
                text: name,
                style: MyTextStyle.tajawal.copyWith(
                  color: isHighlighted ? MyColors.primaryGold : MyColors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(width: 10.w),

              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? MyColors.primaryGold.withOpacity(0.2)
                      : MyColors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: isHighlighted
                      ? MyColors.primaryGold
                      : MyColors.textGray,
                  size: 18.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

