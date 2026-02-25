import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/verse_model.dart';
import '../data/verse_repository.dart';

enum LoadState { idle, loading, loaded, error }

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Set<int> _favorites = {};
  String _selectedCategory = 'ಎಲ್ಲಾ (All)';
  List<Verse> _allVerses = [];
  LoadState _loadState = LoadState.idle;
  String _errorMessage = '';

  bool get isDarkMode => _isDarkMode;
  Set<int> get favorites => _favorites;
  String get selectedCategory => _selectedCategory;
  List<Verse> get allVerses => _allVerses;
  LoadState get loadState => _loadState;
  String get errorMessage => _errorMessage;

  List<String> get categories {
    final chapters = _allVerses.map((v) => v.chapter).toSet().toList();
    chapters.sort();
    return ['ಎಲ್ಲಾ (All)', ...chapters];
  }

  List<Verse> get filteredVerses {
    if (_selectedCategory == 'ಎಲ್ಲಾ (All)') return _allVerses;
    return _allVerses.where((v) => v.chapter == _selectedCategory).toList();
  }

  List<Verse> get favoriteVerses =>
      _allVerses.where((v) => _favorites.contains(v.id)).toList();

  AppProvider() {
    _loadPrefs();
    loadVerses();
  }

  Future<void> loadVerses() async {
    _loadState = LoadState.loading;
    notifyListeners();

    try {
      _allVerses = await VerseRepository.fetchAllVerses();
      _loadState = LoadState.loaded;
    } catch (e) {
      _loadState = LoadState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
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
    await prefs.setStringList(
        'favorites', _favorites.map((e) => e.toString()).toList());
    notifyListeners();
  }

  bool isFavorite(int verseId) => _favorites.contains(verseId);

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
