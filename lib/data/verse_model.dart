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
      // trim() strips the trailing spaces present in raw JSON values
      kannadaOriginal: (json['kannada_original'] ?? '').trim(),
      englishTransliteration: (json['english_transliteration'] ?? '').trim(),
      englishTranslation: (json['english_translation'] ?? '').trim(),
      tags: json['tags'] ?? '',
    );
  }
}

class Verse {
  final int id;
  final String chapter;
  final String kannada;
  final String transliteration;
  final String english;
  final String category;
  final List<VerseLine> lines;

  // Structured line-by-line access for detail screen display
  List<String> get kannadaLines =>
      lines.map((l) => l.kannadaOriginal).where((s) => s.isNotEmpty).toList();

  List<String> get transliterationLines =>
      lines.map((l) => l.englishTransliteration).where((s) => s.isNotEmpty).toList();

  List<String> get englishLines =>
      lines.map((l) => l.englishTranslation).where((s) => s.isNotEmpty).toList();

  const Verse({
    required this.id,
    required this.chapter,
    required this.kannada,
    required this.transliteration,
    required this.english,
    required this.category,
    required this.lines,
  });

  factory Verse.fromLines(List<VerseLine> lines) {
    assert(lines.isNotEmpty);
    final id = lines.first.verseNumber.toInt();
    final chapter = lines.first.chapter.replaceAll('_', ' ');

    // Each line on its own row, trimmed, empty lines excluded
    final kannada = lines
        .map((l) => l.kannadaOriginal)
        .where((s) => s.isNotEmpty)
        .join('\n');

    final transliteration = lines
        .map((l) => l.englishTransliteration)
        .where((s) => s.isNotEmpty)
        .join('\n');

    final english = lines
        .map((l) => l.englishTranslation)
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
