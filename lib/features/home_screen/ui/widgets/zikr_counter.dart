import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/core_widgets/custom_text.dart';
import '../../../../core/style/my_colors.dart';
import '../../../../core/style/my_text_style.dart';

class ZikrCounter extends StatefulWidget {
  const ZikrCounter({super.key});

  @override
  State<ZikrCounter> createState() => _ZikrCounterState();
}

class _ZikrCounterState extends State<ZikrCounter> {
  final List<String> _azkarList = [
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
    'لا حول ولا قوة إلا بالله',
    'أستغفر الله',
  ];

  int _currentIndex = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _nextZikr() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _azkarList.length;
      _counter = 0;
    });
  }

  void _prevZikr() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _azkarList.length) % _azkarList.length;
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_right,
            color: MyColors.primaryGold,
            size: 40.r,
          ),
          onPressed: _prevZikr,
        ),
        Expanded(
          child: GestureDetector(
            onTap: _incrementCounter,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.cardBackground.withOpacity(0.4),
                  border: Border.all(color: MyColors.primaryGold, width: 4.w),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: CustomText(
                          text: '$_counter',
                          style: MyTextStyle.counterText,
                        ),
                      ),
                      CustomText(
                        text: _azkarList[_currentIndex],
                        style: MyTextStyle.cardSubtitle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: MyColors.primaryGold,
            size: 40.r,
          ),
          onPressed: _nextZikr,
        ),
      ],
    );
  }
}

