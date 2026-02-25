import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'verse_model.dart';

class VerseRepository {
  static const String _baseUrl =
      'https://hangyoicream.github.io/MuRa-Web-App/data';

  // How many verse JSON files exist — update this as you add more
  static const int _totalVerses = 10;

  /// Fetches all verses from verse_1.0.json ... verse_N.0.json
  static Future<List<Verse>> fetchAllVerses() async {
    final List<Verse> verses = [];

    for (int i = 1; i <= _totalVerses; i++) {
      try {
        final url = '$_baseUrl/verse_$i.0.json';
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final List<dynamic> jsonList = jsonDecode(response.body);
          final lines = jsonList
              .map((j) => VerseLine.fromJson(j as Map<String, dynamic>))
              .toList();

          if (lines.isNotEmpty) {
            verses.add(Verse.fromLines(lines));
          }
        }
      } catch (e) {
        debugPrint('Failed to load verse $i: $e');
      }
    }

    return verses;
  }

  /// Fetch a single verse by number
  static Future<Verse?> fetchVerse(int verseNumber) async {
    try {
      final url = '$_baseUrl/verse_$verseNumber.0.json';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final lines = jsonList
            .map((j) => VerseLine.fromJson(j as Map<String, dynamic>))
            .toList();
        return lines.isNotEmpty ? Verse.fromLines(lines) : null;
      }
    } catch (e) {
      debugPrint('Failed to load verse $verseNumber: $e');
    }
    return null;
  }
}
