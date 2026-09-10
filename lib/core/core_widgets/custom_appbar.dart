import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/my_text_style.dart';
import '../style/my_colors.dart';
import 'custom_text.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    this.icon,
    this.describeText,
    required this.text,
    this.imgPath,
  });

  final IconData? icon;
  final String? describeText;
  final String? imgPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: MyColors.primaryGold.withOpacity(0.4),
              width: 1.5.w,
            ),
          ),
          child: CircleAvatar(
            radius: 25.r,
            backgroundColor: MyColors.primaryGold.withOpacity(0.13),
            child: icon != null
                ? Icon(icon, color: MyColors.primaryGold, size: 28.r)
                : Image.asset(
                    imgPath!,
                    width: 28.w,
                    height: 28.h,
                    color: MyColors.primaryGold,
                  ),
          ),
        ),
        SizedBox(width: 40.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              text: text,
              style: MyTextStyle.appbarTitle.copyWith(
                color: MyColors.secondaryGold,
                fontSize: 28.sp,
              ),
            ),
            if (describeText != null)
              CustomText(
                text: describeText!,
                style: MyTextStyle.appbarSubtitle.copyWith(fontSize: 16.sp),
              ),
          ],
        ),
      ],
    );
  }
}

