import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/verse_card.dart';
import '../widgets/category_filter.dart';
import 'verse_detail_screen.dart';

class VersesScreen extends StatelessWidget {
  const VersesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isDark, provider),
          if (provider.loadState == LoadState.loaded) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: CategoryFilter(
                  categories: provider.categories,
                  selected: provider.selectedCategory,
                  onSelect: (cat) => context.read<AppProvider>().setCategory(cat),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                child: Text(
                  '${provider.filteredVerses.length} ಪದ್ಯಗಳು',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final verse = provider.filteredVerses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: VerseCard(
                      verse: verse,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerseDetailScreen(
                            verse: verse,
                            verseList: provider.filteredVerses,
                            initialIndex: index,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: provider.filteredVerses.length,
              ),
            ),
          ] else if (provider.loadState == LoadState.loading)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Color(0xFFFF9933)),
                    const SizedBox(height: 20),
                    Text(
                      'ಪದ್ಯಗಳನ್ನು ತರುತ್ತಿದ್ದೇವೆ...',
                      style: GoogleFonts.tiroKannada(
                        fontSize: 16,
                        color: const Color(0xFFAA8040),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Loading verses...',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFFAA8040),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (provider.loadState == LoadState.error)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🪔', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 16),
                    Text(
                      'ಲೋಡ್ ಆಗಲಿಲ್ಲ',
                      style: GoogleFonts.tiroKannada(
                        fontSize: 18,
                        color: const Color(0xFFAA8040),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Could not load verses.\nCheck your internet connection.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFFAA8040),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.read<AppProvider>().loadVerses(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9933),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark, AppProvider provider) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 110,
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
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  const Text('🪔', style: TextStyle(fontSize: 26)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ಮುದ್ದುರಾಮನ ಮನಸು',
                          style: GoogleFonts.tiroKannada(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDark ? const Color(0xFFFFD580) : Colors.white,
                          ),
                        ),
                        Text(
                          'Simple Verses, Profound Truths.',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: isDark
                                ? const Color(0xFFAA8040)
                                : Colors.white.withOpacity(0.85),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        color: isDark ? const Color(0xFFFFD580) : Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
