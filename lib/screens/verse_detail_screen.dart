import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/app_provider.dart';
import '../data/verses.dart';

class VerseDetailScreen extends StatefulWidget {
  final Verse verse;
  final List<Verse> verseList;
  final int initialIndex;

  const VerseDetailScreen({
    super.key,
    required this.verse,
    required this.verseList,
    required this.initialIndex,
  });

  @override
  State<VerseDetailScreen> createState() => _VerseDetailScreenState();
}

class _VerseDetailScreenState extends State<VerseDetailScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showEnglish = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _shareVerse(Verse verse) {
    final text =
        '${verse.kannada}\n\n${verse.english}\n\n— ಮುದ್ದುರಾಮನ ಮನಸು, K. C. Shivappa\nhttps://hangyoicream.github.io/MuRa-Web-App/';
    Share.share(text);
  }

  /// Measures all lines at [maxFontSize] and returns the font size that makes
  /// the LONGEST line fit within [availableWidth]. All lines then share this size.
  double _uniformFontSize({
    required List<String> lines,
    required double availableWidth,
    required double maxFontSize,
    required double minFontSize,
    required TextStyle baseStyle,
  }) {
    double fontSize = maxFontSize;

    for (final line in lines) {
      if (line.isEmpty) continue;

      // Binary-search the right font size for this line
      double lo = minFontSize;
      double hi = maxFontSize;

      while (hi - lo > 0.5) {
        final mid = (lo + hi) / 2;
        final tp = TextPainter(
          text: TextSpan(text: line, style: baseStyle.copyWith(fontSize: mid)),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: double.infinity);

        if (tp.width <= availableWidth) {
          lo = mid;
        } else {
          hi = mid;
        }
      }

      // The fitting size for this line is lo — track the smallest across all lines
      if (lo < fontSize) fontSize = lo;
    }

    return fontSize.clamp(minFontSize, maxFontSize);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;
    final bgColor = isDark ? const Color(0xFF1A1208) : const Color(0xFFFFF8EC);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? const Color(0xFFFFD580) : const Color(0xFF7A3B00),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${_currentIndex + 1} / ${widget.verseList.length}',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_rounded,
              color: isDark ? const Color(0xFFFFD580) : const Color(0xFFFF9933),
            ),
            onPressed: () => _shareVerse(widget.verseList[_currentIndex]),
          ),
          Consumer<AppProvider>(
            builder: (_, prov, __) {
              final verseId = widget.verseList[_currentIndex].id;
              return IconButton(
                icon: Icon(
                  prov.isFavorite(verseId)
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: prov.isFavorite(verseId)
                      ? Colors.red
                      : isDark
                          ? const Color(0xFFFFD580)
                          : const Color(0xFFFF9933),
                ),
                onPressed: () => prov.toggleFavorite(verseId),
              );
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.verseList.length,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (context, index) {
          final verse = widget.verseList[index];
          return LayoutBuilder(
            builder: (context, constraints) {
              return _buildVersePage(context, verse, isDark, constraints.maxWidth);
            },
          );
        },
      ),
    );
  }

  Widget _buildVersePage(BuildContext context, Verse verse, bool isDark, double pageWidth) {
    final cardColor = isDark ? const Color(0xFF2A1E0F) : Colors.white;
    final accentColor = const Color(0xFFFF9933);
    final textColor = isDark ? const Color(0xFFFFF0D0) : const Color(0xFF2C1A00);
    final subtleColor = isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040);

    // Exact usable width inside each container
    final cardTextWidth = pageWidth - 40 - 48 - 2; // screen pad + card pad + border
    final englishTextWidth = pageWidth - 40 - 40;   // screen pad + english card pad

    // Base styles (fontSize is placeholder — overridden below)
    final kannadaBase = GoogleFonts.tiroKannada(
      height: 1.6,
      color: textColor,
      fontWeight: FontWeight.w500,
    );
    final translitBase = GoogleFonts.poppins(
      height: 1.6,
      color: subtleColor,
      fontStyle: FontStyle.italic,
    );
    final englishBase = GoogleFonts.poppins(
      height: 1.7,
      color: textColor,
      fontStyle: FontStyle.italic,
    );

    // Compute ONE font size per block — dictated by the longest line in each block
    final kannadaFontSize = _uniformFontSize(
      lines: verse.kannadaLines,
      availableWidth: cardTextWidth,
      maxFontSize: 20,
      minFontSize: 11,
      baseStyle: kannadaBase,
    );

    final translitFontSize = _uniformFontSize(
      lines: verse.transliterationLines,
      availableWidth: cardTextWidth,
      maxFontSize: 15,
      minFontSize: 9,
      baseStyle: translitBase,
    );

    final englishFontSize = _uniformFontSize(
      lines: verse.englishLines,
      availableWidth: englishTextWidth,
      maxFontSize: 15,
      minFontSize: 9,
      baseStyle: englishBase,
    );

    // Renders all lines at the same computed size — uniform, no per-line scaling
    Widget lineBlock(List<String> lines, double width, TextStyle style) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((line) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            width: width,
            child: Text(
              line,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: style,
            ),
          ),
        )).toList(),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withOpacity(0.3)),
              ),
              child: Text(
                verse.category,
                style: GoogleFonts.tiroKannada(fontSize: 13, color: accentColor),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Main verse card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(color: accentColor.withOpacity(0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Decorative top line
                Row(
                  children: [
                    Expanded(child: Divider(color: accentColor.withOpacity(0.3), thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('❧', style: TextStyle(color: accentColor, fontSize: 18)),
                    ),
                    Expanded(child: Divider(color: accentColor.withOpacity(0.3), thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),

                // Verse number
                Text(
                  '${verse.id}',
                  style: GoogleFonts.poppins(fontSize: 11, color: subtleColor, letterSpacing: 1),
                ),
                const SizedBox(height: 16),

                // Kannada — all 4 lines at same kannadaFontSize
                lineBlock(
                  verse.kannadaLines,
                  cardTextWidth,
                  kannadaBase.copyWith(fontSize: kannadaFontSize),
                ),

                const SizedBox(height: 20),
                Divider(color: accentColor.withOpacity(0.2), thickness: 1),
                const SizedBox(height: 16),

                // Transliteration — all lines at same translitFontSize
                lineBlock(
                  verse.transliterationLines,
                  cardTextWidth,
                  translitBase.copyWith(fontSize: translitFontSize),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // English translation card
          GestureDetector(
            onTap: () => setState(() => _showEnglish = !_showEnglish),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _showEnglish ? Icons.keyboard_arrow_up : Icons.translate_rounded,
                        color: accentColor,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _showEnglish ? 'Hide Translation' : 'Show English Translation',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (_showEnglish) ...[
                    const SizedBox(height: 16),
                    // English — all lines at same englishFontSize
                    lineBlock(
                      verse.englishLines,
                      englishTextWidth,
                      englishBase.copyWith(fontSize: englishFontSize),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Copy button
          Center(
            child: OutlinedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: verse.kannada));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'ಪದ್ಯ ನಕಲಿಸಲಾಗಿದೆ!',
                      style: GoogleFonts.tiroKannada(fontSize: 14),
                    ),
                    backgroundColor: const Color(0xFFFF9933),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
              icon: const Icon(Icons.copy_rounded, size: 16),
              label: Text('ನಕಲಿಸಿ (Copy)', style: GoogleFonts.tiroKannada(fontSize: 14)),
              style: OutlinedButton.styleFrom(
                foregroundColor: accentColor,
                side: BorderSide(color: accentColor.withOpacity(0.4)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Swipe hint
          Center(
            child: Text(
              '← ← ಸ್ವೈಪ್ ಮಾಡಿ → →',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: subtleColor.withOpacity(0.5),
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
