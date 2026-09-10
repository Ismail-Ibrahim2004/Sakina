import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noorr/features/quran_screen/ui/widgets/sora_card.dart';
import 'package:qcf_quran/qcf_quran.dart';
import '../../../core/core_widgets/custom_appbar.dart';
import '../../../core/core_widgets/custom_scaffold.dart';
import '../../sora_screen/ui/surah_viewer.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              const CustomAppbar(
                text: "القرآن الكريم",
                imgPath: "assets/images/quran.png",
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 114,
                  itemBuilder: (context, index) {
                    final surahIndex = index + 1;
                    return SoraCard(
                      soraName: getSurahNameArabic(surahIndex),
                      soraNum: surahIndex,
                      ayatNum: getVerseCount(surahIndex),
                      revelationType: getPlaceOfRevelation(surahIndex),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SurahViewer(
                              initialPage: getPageNumber(surahIndex, 1),
                              surahName: getSurahNameArabic(surahIndex),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
