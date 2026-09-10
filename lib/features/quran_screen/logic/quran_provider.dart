import 'package:flutter/material.dart';
import 'package:qcf_quran/qcf_quran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranProvider extends ChangeNotifier {
  int _lastReadPage = 1;
  String _lastReadSurah = "الفاتحة";
  bool _isDarkMode = false;

  int get lastReadPage => _lastReadPage;
  String get lastReadSurah => _lastReadSurah;
  bool get isDarkMode => _isDarkMode;

  QuranProvider() {
    _loadSettings();
    loadLastReadPage();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('quran_dark_mode') ?? false;
    notifyListeners();
  }

  void toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quran_dark_mode', _isDarkMode);
    notifyListeners();
  }

  Future<void> loadLastReadPage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final page = prefs.getInt('last_read_page') ?? 1;

      final pageData = getPageData(page);
      String surahName = "الفاتحة";
      if (pageData.isNotEmpty) {
        final surahNum = pageData.first['surah'] as int;
        surahName = getSurahNameArabic(surahNum);
      }

      _lastReadPage = page;
      _lastReadSurah = surahName;
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading last read in provider: $e");
    }
  }

  Future<void> saveLastPage(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('last_read_page', page);

      final pageData = getPageData(page);
      if (pageData.isNotEmpty) {
        final surahNum = pageData.first['surah'] as int;
        _lastReadSurah = getSurahNameArabic(surahNum);
      }

      _lastReadPage = page;
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving page: $e');
    }
  }
}
