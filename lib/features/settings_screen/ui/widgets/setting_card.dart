import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core_widgets/custom_text.dart';
import '../../../../core/style/my_colors.dart';
import '../../../../core/style/my_text_style.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.showDivider,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final bool? showDivider;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                trailing ??
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: MyColors.white24,
                      size: 16.r,
                    ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: title,
                              style: MyTextStyle.settingsTitle,
                              textAlign: TextAlign.end,
                            ),
                            if (subtitle != null) ...[
                              SizedBox(height: 2.h),
                              CustomText(
                                text: subtitle!,
                                style: MyTextStyle.settingsSubtitle,
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),

                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: MyColors.primaryGold.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: MyColors.primaryGold,
                          size: 22.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        if (showDivider != false)
          Divider(
            color: MyColors.white.withOpacity(0.05),
            height: 1.h,
            thickness: 1.h,
          ),
      ],
    );
  }
}
