class VerseLine {
  final double verseNumber;
  final double lineNumber;
  final String chapter;
  final String kannadaOriginal;
  final String englishTransliteration;
  final String englishTranslation;
  final String tags;

  const VerseLine({
    required this.verseNumber,
    required this.lineNumber,
    required this.chapter,
    required this.kannadaOriginal,
    required this.englishTransliteration,
    required this.englishTranslation,
    required this.tags,
  });

  factory VerseLine.fromJson(Map<String, dynamic> json) {
    return VerseLine(
      verseNumber: (json['verse_number'] as num).toDouble(),
      lineNumber: (json['line_number'] as num).toDouble(),
      chapter: json['chapter'] ?? '',
      kannadaOriginal: json['kannada_original'] ?? '',
      englishTransliteration: json['english_transliteration'] ?? '',
      englishTranslation: json['english_translation'] ?? '',
      tags: json['tags'] ?? '',
    );
  }
}

class Verse {
  final int id;
  final String chapter;
  final String kannada;       // all lines joined
  final String transliteration;
  final String english;
  final String category;
  final List<VerseLine> lines;

  const Verse({
    required this.id,
    required this.chapter,
    required this.kannada,
    required this.transliteration,
    required this.english,
    required this.category,
    required this.lines,
  });

  /// Build a Verse from a list of VerseLine (one JSON file = one verse)
  factory Verse.fromLines(List<VerseLine> lines) {
    assert(lines.isNotEmpty);
    final id = lines.first.verseNumber.toInt();
    final chapter = lines.first.chapter.replaceAll('_', ' ');

    final kannada = lines
        .map((l) => l.kannadaOriginal.trim())
        .where((s) => s.isNotEmpty)
        .join('\n');

    final transliteration = lines
        .map((l) => l.englishTransliteration.trim())
        .where((s) => s.isNotEmpty)
        .join('\n');

    final english = lines
        .map((l) => l.englishTranslation.trim())
        .where((s) => s.isNotEmpty)
        .join('\n');

    return Verse(
      id: id,
      chapter: chapter,
      kannada: kannada,
      transliteration: transliteration,
      english: english,
      category: chapter,
      lines: lines,
    );
  }
}
