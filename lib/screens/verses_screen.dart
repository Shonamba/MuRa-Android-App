import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../data/verses.dart';
import '../widgets/verse_card.dart';
import '../widgets/category_filter.dart';
import 'verse_detail_screen.dart';

class VersesScreen extends StatelessWidget {
  const VersesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final verses = provider.filteredVerses;
    final isDark = provider.isDarkMode;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 130,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF3A2000), const Color(0xFF1A1208)]
                        : [const Color(0xFFFF9933), const Color(0xFFFFD580)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('🪔', style: TextStyle(fontSize: 28)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ಮುದ್ದುರಾಮನ ಮನಸು',
                                    style: GoogleFonts.tiroKannada(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? const Color(0xFFFFD580)
                                          : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Simple Verses, Profound Truths.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: isDark
                                          ? const Color(0xFFAA8040)
                                          : Colors.white.withOpacity(0.85),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Dark mode toggle
                            GestureDetector(
                              onTap: () => context.read<AppProvider>().toggleDarkMode(),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isDark ? Icons.light_mode : Icons.dark_mode,
                                  color: isDark
                                      ? const Color(0xFFFFD580)
                                      : Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Category filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: CategoryFilter(
                categories: verseCategories,
                selected: provider.selectedCategory,
                onSelect: (cat) => context.read<AppProvider>().setCategory(cat),
              ),
            ),
          ),

          // Verse count
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Text(
                '${verses.length} ಪದ್ಯಗಳು',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040),
                ),
              ),
            ),
          ),

          // Verses list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final verse = verses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: VerseCard(
                    verse: verse,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerseDetailScreen(
                          verse: verse,
                          verseList: verses,
                          initialIndex: index,
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: verses.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
