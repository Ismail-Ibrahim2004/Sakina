import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_colors.dart';

class MyTextStyle {
  static TextStyle tajawal = GoogleFonts.tajawal();
  static TextStyle cairo = GoogleFonts.cairo();
  static TextStyle amiri = GoogleFonts.amiri();

  static TextStyle tajawal40w800 = GoogleFonts.tajawal(
    fontSize: 40,
    fontWeight: FontWeight.w800,
  );
  static TextStyle cairo40w800 = GoogleFonts.cairo(
    fontSize: 40,
    fontWeight: FontWeight.w800,
  );
  static TextStyle amiri40w800 = GoogleFonts.amiri(
    fontSize: 40,
    fontWeight: FontWeight.w800,
  );

  static TextStyle appbarTitle = GoogleFonts.tajawal(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: MyColors.white,
  );
  static TextStyle appbarSubtitle = GoogleFonts.tajawal(
    fontSize: 14,
    color: MyColors.textGray,
  );

  static TextStyle cardTitle = GoogleFonts.tajawal(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: MyColors.white,
  );
  static TextStyle cardSubtitle = GoogleFonts.tajawal(
    fontSize: 14,
    color: MyColors.textGray,
  );
  static TextStyle cardGoldTitle = GoogleFonts.tajawal(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: MyColors.primaryGold,
  );

  static TextStyle soraName = GoogleFonts.amiri(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: MyColors.white,
  );
  static TextStyle soraInfo = GoogleFonts.tajawal(
    fontSize: 13,
    color: MyColors.textGray,
  );
  static TextStyle soraNumber = GoogleFonts.tajawal(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: MyColors.secondaryGold,
  );

  static TextStyle surahHeader = GoogleFonts.amiri(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MyColors.quranBrown,
  );
  static TextStyle pageNumber = GoogleFonts.amiri(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF1A1A1A),
  );

  static TextStyle zikrText = GoogleFonts.tajawal(
    fontSize: 24,
    height: 1.7,
    color: MyColors.white,
  );
  static TextStyle counterText = GoogleFonts.tajawal(
    fontSize: 55,
    fontWeight: FontWeight.bold,
    color: MyColors.secondaryGold,
  );
  static TextStyle azkarCategoryTitle = GoogleFonts.tajawal(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: MyColors.white,
  );

  static TextStyle welcomeTitle = GoogleFonts.tajawal(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: MyColors.darkBackground,
  );
  static TextStyle lastReadInfo = GoogleFonts.tajawal(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: MyColors.darkBackground.withOpacity(0.8),
  );
  static TextStyle nextPrayerLabel = GoogleFonts.tajawal(
    fontSize: 12,
    color: MyColors.textGray,
  );
  static TextStyle nextPrayerTime = GoogleFonts.tajawal(
    fontSize: 18,
    color: MyColors.secondaryGold,
  );
  static TextStyle prayerNameLarge = GoogleFonts.tajawal(
    fontSize: 18,
    color: MyColors.white,
  );

  static TextStyle prayerHeaderTitle = GoogleFonts.tajawal(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: MyColors.white,
  );
  static TextStyle locationLabel = GoogleFonts.tajawal(
    fontSize: 12,
    color: MyColors.textGray,
  );
  static TextStyle countdownText = GoogleFonts.tajawal(
    fontSize: 44,
    fontWeight: FontWeight.w900,
    letterSpacing: 2,
    color: MyColors.darkBackground,
  );
  static TextStyle nextPrayerStatus = GoogleFonts.tajawal(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: MyColors.darkBackground,
  );
  static TextStyle countdownDesc = GoogleFonts.tajawal(
    fontSize: 12,
    color: MyColors.darkBackground.withOpacity(0.7),
  );

  static TextStyle settingsTitle = GoogleFonts.tajawal(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: MyColors.white,
  );
  static TextStyle settingsSubtitle = GoogleFonts.tajawal(
    fontSize: 13,
    color: MyColors.textGray,
  );
}
