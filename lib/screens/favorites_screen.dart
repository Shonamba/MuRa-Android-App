import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/verse_card.dart';
import 'verse_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final favorites = provider.favoriteVerses;
    final isDark = provider.isDarkMode;
    final accent = const Color(0xFFFF9933);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ಮೆಚ್ಚಿನ ಪದ್ಯಗಳು',
          style: GoogleFonts.tiroKannada(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (favorites.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${favorites.length}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 64,
                    color: isDark ? const Color(0xFF4A3020) : const Color(0xFFDDBB88),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ಇನ್ನೂ ಯಾವ ಪದ್ಯವೂ ಇಲ್ಲ',
                    style: GoogleFonts.tiroKannada(
                      fontSize: 18,
                      color: isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No favorites yet',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: isDark ? const Color(0xFF5A4030) : const Color(0xFFCCAA77),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '♥ ಪದ್ಯಗಳ ಮೇಲೆ ❤ ಒತ್ತಿ ಇಲ್ಲಿ ಉಳಿಸಿ',
                    style: GoogleFonts.tiroKannada(
                      fontSize: 14,
                      color: isDark ? const Color(0xFF5A4030) : const Color(0xFFCCAA77),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: VerseCard(
                    verse: favorites[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerseDetailScreen(
                          verse: favorites[index],
                          verseList: favorites,
                          initialIndex: index,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
