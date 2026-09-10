import 'package:flutter/material.dart';

import '../../../../core/core_widgets/custom_text.dart';
import '../../../../core/services/format_arabic_number.dart';
import '../../../../core/style/my_text_style.dart';
import '../../../../core/style/my_colors.dart';

class SoraCard extends StatelessWidget {
  const SoraCard({
    super.key,
    required this.soraName,
    this.guzaNum,
    this.hazbName,
    required this.ayatNum,
    required this.revelationType,
    required this.soraNum,
    required this.onTap,
  });

  final String soraName;
  final int soraNum;
  final String? guzaNum;
  final String? hazbName;
  final int ayatNum;
  final String revelationType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: MyColors.white.withOpacity(0.05),
            width: 1.5,
          ),
          color: MyColors.cardBackground.withOpacity(0.5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                revelationType.toLowerCase() == "meccan" ||
                        revelationType.toLowerCase() == "makkah" ||
                        revelationType == "مكية"
                    ? Image.asset("assets/images/islam (1).png", scale: 1.5)
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Image.asset(
                          "assets/images/icons8-mosque-48.png",
                          scale: 1.5,
                        ),
                      ),
                CustomText(
                  text: "${toArabicDigits(ayatNum)} آيَة",
                  style: MyTextStyle.soraInfo,
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  text: soraName,
                  textDirection: TextDirection.rtl,
                  style: MyTextStyle.soraName,
                ),
              ],
            ),
            const SizedBox(width: 10),
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.secondaryGold,
              ),
              child: CustomText(
                text: toArabicDigits(soraNum),
                style: MyTextStyle.soraNumber.copyWith(
                  color: MyColors.darkBackground,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
