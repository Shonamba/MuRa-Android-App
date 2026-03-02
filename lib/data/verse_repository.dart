import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'verse_model.dart';

class VerseRepository {
  static const int _totalVerses = 1000;

  /// Loads all verses from bundled assets — instant, works offline
  static Future<List<Verse>> fetchAllVerses() async {
    final List<Verse> verses = [];

    for (int i = 1; i <= _totalVerses; i++) {
      try {
        final String data =
            await rootBundle.loadString('assets/data/verse_$i.0.json');
        final List<dynamic> jsonList = jsonDecode(data);
        final lines = jsonList
            .map((j) => VerseLine.fromJson(j as Map<String, dynamic>))
            .toList();
        if (lines.isNotEmpty) {
          verses.add(Verse.fromLines(lines));
        }
      } catch (e) {
        // File doesn't exist for this number — stop looking
        debugPrint('Stopped at verse $i: $e');
        break;
      }
    }

    return verses;
  }

  /// Load a single verse from assets
  static Future<Verse?> fetchVerse(int verseNumber) async {
    try {
      final String data = await rootBundle
          .loadString('assets/data/verse_$verseNumber.0.json');
      final List<dynamic> jsonList = jsonDecode(data);
      final lines = jsonList
          .map((j) => VerseLine.fromJson(j as Map<String, dynamic>))
          .toList();
      return lines.isNotEmpty ? Verse.fromLines(lines) : null;
    } catch (e) {
      debugPrint('Failed to load verse $verseNumber: $e');
      return null;
    }
  }
}
