import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_router.dart';
import 'features/quran_screen/logic/quran_provider.dart';
import 'features/prayer_times_screen/logic/prayer_provider.dart';
import 'features/azkar_screen/logic/azkar_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'features/onboarding_screen/ui/app_onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('app_has_seen_onboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuranProvider()),
        ChangeNotifierProvider(create: (_) => PrayerProvider()),
        ChangeNotifierProvider(create: (_) => AzkarProvider()),
      ],
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72, 800.72),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        title: 'سَكِينَة | Sakina',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(textTheme: GoogleFonts.tajawalTextTheme()),
        home: hasSeenOnboarding ? const AppRouter() : const AppOnboardingScreen(),
      ),
    );
  }
}
