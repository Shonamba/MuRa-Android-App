import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/verses.dart';
import '../providers/app_provider.dart';

class VerseCard extends StatelessWidget {
  final Verse verse;
  final VoidCallback onTap;

  const VerseCard({super.key, required this.verse, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;
    final isFav = provider.isFavorite(verse.id);
    final accent = const Color(0xFFFF9933);
    final cardColor = isDark ? const Color(0xFF2A1E0F) : Colors.white;
    final textColor = isDark ? const Color(0xFFFFF0D0) : const Color(0xFF2C1A00);
    final subtleColor = isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040);

    // Responsive font size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final kannadadFontSize = screenWidth < 360 ? 14.0 : screenWidth < 400 ? 15.0 : 17.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accent.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Verse number badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '#${verse.id}',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Category — FIXED: wrapped in Flexible to prevent row overflow
                  Flexible(
                    child: Text(
                      verse.category.split(' ').first,
                      style: GoogleFonts.tiroKannada(
                        fontSize: 11,
                        color: subtleColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Favorite button
                  GestureDetector(
                    onTap: () => provider.toggleFavorite(verse.id),
                    child: Icon(
                      isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      size: 18,
                      color: isFav ? Colors.red : subtleColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Decorative divider
              Container(
                width: 30,
                height: 1.5,
                color: accent.withOpacity(0.4),
              ),
              const SizedBox(height: 12),

              // Kannada verse — FIXED: removed maxLines+ellipsis, added softWrap+constrained width+responsive size
              SizedBox(
                width: double.infinity,
                child: Text(
                  verse.kannada,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.tiroKannada(
                    fontSize: kannadadFontSize,
                    height: 1.9,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Read more row
              Row(
                children: [
                  Text(
                    'ಓದಿ / Read',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded, size: 14, color: accent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
