import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/verses.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Set<int> _favorites = {};
  String _selectedCategory = 'ಎಲ್ಲಾ (All)';
  int _currentVerseIndex = 0;

  bool get isDarkMode => _isDarkMode;
  Set<int> get favorites => _favorites;
  String get selectedCategory => _selectedCategory;
  int get currentVerseIndex => _currentVerseIndex;

  List<Verse> get filteredVerses {
    if (_selectedCategory == 'ಎಲ್ಲಾ (All)') return allVerses;
    return allVerses.where((v) => v.category == _selectedCategory).toList();
  }

  List<Verse> get favoriteVerses {
    return allVerses.where((v) => _favorites.contains(v.id)).toList();
  }

  AppProvider() {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    final favList = prefs.getStringList('favorites') ?? [];
    _favorites = favList.map((e) => int.parse(e)).toSet();
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> toggleFavorite(int verseId) async {
    if (_favorites.contains(verseId)) {
      _favorites.remove(verseId);
    } else {
      _favorites.add(verseId);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites.map((e) => e.toString()).toList());
    notifyListeners();
  }

  bool isFavorite(int verseId) => _favorites.contains(verseId);

  void setCategory(String category) {
    _selectedCategory = category;
    _currentVerseIndex = 0;
    notifyListeners();
  }

  void setCurrentVerseIndex(int index) {
    _currentVerseIndex = index;
    notifyListeners();
  }
}
