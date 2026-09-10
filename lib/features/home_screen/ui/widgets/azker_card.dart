import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core_widgets/custom_text.dart' show CustomText;
import '../../../../core/style/my_text_style.dart';
import '../../../../core/style/my_colors.dart';

class AzkarSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  const AzkarSection({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 122.h,
        padding:  EdgeInsets.symmetric(vertical: 18.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: MyColors.white.withOpacity(0.05),
            width: 1.5.w,
          ),
          color: MyColors.cardBackground.withOpacity(0.5),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CircleAvatar(
                radius: 25.r,
                backgroundColor: MyColors.secondaryGold.withOpacity(0.2),
                child: Icon(icon, color: MyColors.primaryGold, size: 28.r),
              ),
            ),

            CustomText(
              text: title,
              style: MyTextStyle.cardSubtitle.copyWith(
                color: MyColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
