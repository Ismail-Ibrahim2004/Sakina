import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qcf_quran/qcf_quran.dart';

import '../../../../core/services/format_arabic_number.dart';
import '../../../../core/style/my_colors.dart';
import '../../../../core/style/my_text_style.dart';
import '../../../../core/core_widgets/custom_text.dart';
import '../../quran_screen/logic/quran_provider.dart';

class SurahViewer extends StatefulWidget {
  final int initialPage;
  final String surahName;

  const SurahViewer({
    super.key,
    required this.initialPage,
    required this.surahName,
  });

  @override
  State<SurahViewer> createState() => _SurahViewerState();
}

class _SurahViewerState extends State<SurahViewer> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    int currentSurahNumber = 1;
    int currentJuzNumber = 1;
    int firstVerse = 1;

    try {
      final pageData = getPageData(_currentPage);
      if (pageData.isNotEmpty) {
        currentSurahNumber = pageData.first['surah'] as int;
        firstVerse = pageData.first['start'] as int;
        currentJuzNumber = getJuzNumber(currentSurahNumber, firstVerse);
      }
    } catch (e) {
      debugPrint("Error calculating page info: $e");
    }

    return Scaffold(
      backgroundColor: MyColors.quranPageBg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'الجزء ${toArabicDigits(currentJuzNumber)}',
                    style: MyTextStyle.pageNumber.copyWith(
                      color: const Color(0xFF8B7355),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomText(
                    text: getSurahNameArabic(currentSurahNumber),
                    style: MyTextStyle.pageNumber.copyWith(
                      color: const Color(0xFF8B7355),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'UthmanicHafs',
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.h),
                child: PageviewQuran(
                  initialPageNumber: widget.initialPage,
                  sp: 1.sp,
                  h: 0.88.h,
                  theme: QcfThemeData(
                    pageBackgroundColor: MyColors.quranPageBg,
                    verseTextColor: const Color(0xFF1A1A1A),
                  ),
                  onPageChanged: (page) {
                    setState(() => _currentPage = page);
                    context.read<QuranProvider>().saveLastPage(page);
                  },
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 60.r,
                    height: 45.r,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/ZakhrafaNum.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: CustomText(
                        text: toArabicDigits(_currentPage),
                        style: MyTextStyle.pageNumber.copyWith(
                          color: const Color(0xFF1A1A1A),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
