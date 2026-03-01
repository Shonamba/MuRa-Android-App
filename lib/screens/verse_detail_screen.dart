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
          return _buildVersePage(context, verse, isDark);
        },
      ),
    );
  }

  Widget _buildVersePage(BuildContext context, Verse verse, bool isDark) {
    final cardColor = isDark ? const Color(0xFF2A1E0F) : Colors.white;
    final accentColor = const Color(0xFFFF9933);
    final textColor = isDark ? const Color(0xFFFFF0D0) : const Color(0xFF2C1A00);
    final subtleColor = isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040);

    final screenWidth = MediaQuery.of(context).size.width;
    final kannadadFontSize = screenWidth < 360 ? 17.0 : screenWidth < 400 ? 19.0 : 22.0;
    final transliterationFontSize = screenWidth < 360 ? 11.0 : 13.0;
    final englishFontSize = screenWidth < 360 ? 13.0 : 15.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Category badge — unchanged
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accentColor.withOpacity(0.3)),
            ),
            child: Text(
              verse.category,
              style: GoogleFonts.tiroKannada(
                fontSize: 13,
                color: accentColor,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Main Kannada verse card — unchanged except text widgets
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
              children: [
                // Decorative top line — unchanged
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: accentColor.withOpacity(0.3), thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('❧', style: TextStyle(color: accentColor, fontSize: 18)),
                    ),
                    Expanded(
                      child: Divider(color: accentColor.withOpacity(0.3), thickness: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Verse number — unchanged
                Text(
                  '${verse.id}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: subtleColor,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),

                // CHANGED: one Text widget per JSON line instead of one joined string
                ...verse.kannadaLines.map((line) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    line,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.tiroKannada(
                      fontSize: kannadadFontSize,
                      height: 1.85,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),

                const SizedBox(height: 20),
                Divider(color: accentColor.withOpacity(0.2), thickness: 1),
                const SizedBox(height: 16),

                // CHANGED: one Text widget per JSON line instead of one joined string
                ...verse.transliterationLines.map((line) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    line,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: transliterationFontSize,
                      height: 1.8,
                      color: subtleColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // English translation card — unchanged except text widget
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _showEnglish
                            ? Icons.keyboard_arrow_up
                            : Icons.translate_rounded,
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
                    // CHANGED: one Text widget per JSON line instead of one joined string
                    ...verse.englishLines.map((line) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        line,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: englishFontSize,
                          height: 1.8,
                          color: textColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Copy button — unchanged
          OutlinedButton.icon(
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.copy_rounded, size: 16),
            label: Text(
              'ನಕಲಿಸಿ (Copy)',
              style: GoogleFonts.tiroKannada(fontSize: 14),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: accentColor,
              side: BorderSide(color: accentColor.withOpacity(0.4)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),

          const SizedBox(height: 32),

          // Swipe hint — unchanged
          Text(
            '← ← ಸ್ವೈಪ್ ಮಾಡಿ → →',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: subtleColor.withOpacity(0.5),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
