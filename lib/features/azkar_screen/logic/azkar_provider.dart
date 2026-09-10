import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AzkarProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _azkar = [];
  bool _isLoading = true;
  int _zikrIndex = 0;
  int _count = 0;
  bool _isFinished = false;

  List<Map<String, dynamic>> get azkar => _azkar;
  bool get isLoading => _isLoading;
  int get zikrIndex => _zikrIndex;
  int get count => _count;
  bool get isFinished => _isFinished;

  String get currentZikr => _azkar.isNotEmpty ? _azkar[_zikrIndex]['text'] as String : "";
  int get targetCount => _azkar.isNotEmpty ? _azkar[_zikrIndex]['count'] as int : 0;
  double get progress => targetCount > 0 ? (_count / targetCount).clamp(0.0, 1.0) : 0.0;

  Future<void> loadAzkar(String categoryId) async {
    _isLoading = true;
    _zikrIndex = 0;
    _count = 0;
    _isFinished = false;
    notifyListeners();

    try {
      final raw = await rootBundle.loadString('assets/jsons/azkar.json');
      final data = jsonDecode(raw) as Map<String, dynamic>;

      final dynamic category = (data['categories'] as List).firstWhere(
        (c) => c['id'] == categoryId,
        orElse: () => null,
      );

      if (category != null) {
        _azkar = List<Map<String, dynamic>>.from(category['azkar']);
      } else {
        _azkar = [];
      }
    } catch (e) {
      debugPrint("Error loading Azkar in provider: $e");
      _azkar = [];
    }
    
    _isLoading = false;
    notifyListeners();
  }

  void increment(VoidCallback onComplete) {
    if (_isFinished) return;

    _count++;

    if (_count >= targetCount) {
      if (_zikrIndex < _azkar.length - 1) {
        _zikrIndex++;
        _count = 0;
      } else {
        _count = targetCount;
        _isFinished = true;
        onComplete();
      }
    }
    notifyListeners();
  }

  void reset() {
    _count = 0;
    _zikrIndex = 0;
    _isFinished = false;
    notifyListeners();
  }
}
