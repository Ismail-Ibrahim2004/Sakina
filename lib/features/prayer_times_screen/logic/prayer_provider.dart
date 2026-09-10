import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerProvider extends ChangeNotifier {
  PrayerTimes? _prayerTimes;
  bool _isLoading = true;
  DateTime _now = DateTime.now();
  Timer? _clockTimer;
  
  double _latitude = 30.0444; 
  double _longitude = 31.2357;
  
  String _cityName = 'الاسكندرية';
  double _qiblaDirection = 0;
  bool _isSummerTime = false;

  PrayerTimes? get prayerTimes => _prayerTimes;
  bool get isLoading => _isLoading;
  DateTime get now => _now;
  String get cityName => _cityName;
  double get qiblaDirection => _qiblaDirection;
  bool get isSummerTime => _isSummerTime;

  final List<Map<String, dynamic>> prayerInfo = [
    {'name': 'الفجر', 'icon': Icons.brightness_3_outlined},
    {'name': 'الشروق', 'icon': Icons.wb_twilight},
    {'name': 'الظهر', 'icon': Icons.wb_sunny_outlined},
    {'name': 'العصر', 'icon': Icons.wb_sunny},
    {'name': 'المغرب', 'icon': Icons.nights_stay_outlined},
    {'name': 'العشاء', 'icon': Icons.nightlight_round},
  ];

  PrayerProvider() {
    init();
  }

  Future<void> init() async {
    await _loadSettings();
    await refreshLocation();
    _startClock();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('isSummerTime')) {
       _isSummerTime = DateTime.now().timeZoneOffset.inHours >= 3;
       await prefs.setBool('isSummerTime', _isSummerTime);
    } else {
       _isSummerTime = prefs.getBool('isSummerTime') ?? false;
    }
    notifyListeners();
  }

  Future<void> toggleSummerTime(bool value) async {
    _isSummerTime = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSummerTime', value);
    _calculatePrayerTimes();
    notifyListeners();
  }

  void _startClock() {
    _clockTimer?.cancel();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _now = DateTime.now();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  Future<void> refreshLocation() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isServiceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          final position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.medium,
            ),
          );
          _latitude = position.latitude;
          _longitude = position.longitude;
          _cityName = 'موقعك الحالي';
        }
      }
    } catch (e) {
      debugPrint('Location error in provider: $e');
    }

    _calculatePrayerTimes();
  }

  void _calculatePrayerTimes() {
    final coords = Coordinates(_latitude, _longitude);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    if (_isSummerTime) {
      params.adjustments.fajr = 60;
      params.adjustments.sunrise = 60;
      params.adjustments.dhuhr = 60;
      params.adjustments.asr = 60;
      params.adjustments.maghrib = 60;
      params.adjustments.isha = 60;
    }

    final dateComponents = DateComponents.from(_now);
    _prayerTimes = PrayerTimes(coords, dateComponents, params);
    
    final qibla = Qibla(coords);
    _qiblaDirection = qibla.direction;
    
    _isLoading = false;
    notifyListeners();
  }

  List<DateTime> getAllPrayerTimes() {
    if (_prayerTimes == null) return [];
    return [
      _prayerTimes!.fajr,
      _prayerTimes!.sunrise,
      _prayerTimes!.dhuhr,
      _prayerTimes!.asr,
      _prayerTimes!.maghrib,
      _prayerTimes!.isha,
    ];
  }

  int getNextPrayerIndex() {
    final times = getAllPrayerTimes();
    if (times.isEmpty) return 0;
    for (int i = 0; i < times.length; i++) {
      if (_now.isBefore(times[i])) return i;
    }
    return 0;
  }

  int getCurrentPrayerIndex() {
    final times = getAllPrayerTimes();
    if (times.isEmpty) return -1;
    for (int i = times.length - 1; i >= 0; i--) {
      if (_now.isAfter(times[i])) return i;
    }
    return -1;
  }

  Duration getTimeUntilNextPrayer() {
    final times = getAllPrayerTimes();
    if (times.isEmpty) return Duration.zero;
    final nextIndex = getNextPrayerIndex();
    
    DateTime nextTime = times[nextIndex];
    if (_now.isAfter(nextTime) && nextIndex == 0) {
      nextTime = nextTime.add(const Duration(days: 1));
    }
    
    final diff = nextTime.difference(_now);
    return diff.isNegative ? Duration.zero : diff;
  }

  String formatCountdown(Duration duration) {
    if (duration.isNegative) return '00:00:00';
    final h = duration.inHours.toString().padLeft(2, '0');
    final m = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final s = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  String formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'مساءً' : 'صباحاً';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final h = hour12.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m $period';
  }
}
