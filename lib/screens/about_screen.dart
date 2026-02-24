import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;
    final accent = const Color(0xFFFF9933);
    final cardColor = isDark ? const Color(0xFF2A1E0F) : Colors.white;
    final textColor = isDark ? const Color(0xFFFFF0D0) : const Color(0xFF2C1A00);
    final subtleColor = isDark ? const Color(0xFF7A6040) : const Color(0xFFAA8040);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ಕುರಿತು',
          style: GoogleFonts.tiroKannada(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Switch.adaptive(
              value: isDark,
              onChanged: (_) => context.read<AppProvider>().toggleDarkMode(),
              activeColor: accent,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF3A2000), const Color(0xFF1A1208)]
                      : [const Color(0xFFFF9933), const Color(0xFFFFD580)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text('🪔', style: TextStyle(fontSize: 52)),
                  const SizedBox(height: 16),
                  Text(
                    'ಮುದ್ದುರಾಮನ ಮನಸು',
                    style: GoogleFonts.tiroKannada(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Simple Verses, Profound Truths.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.85),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'v1.0.0',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // About text
            _Card(
              cardColor: cardColor,
              accent: accent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle('ಕುರಿತು (About)', accent),
                  const SizedBox(height: 12),
                  Text(
                    'ಮುದ್ದುರಾಮನ ಮನಸು ಉಪದೇಶಾತ್ಮಕ ಸಾಹಿತ್ಯದ ಜ್ಞಾನಸಂಪತ್ತಿಗಿರುವ ಮೃದುವಾದ ಬಾಗಿಲು.',
                    style: GoogleFonts.tiroKannada(
                      fontSize: 16, height: 1.9, color: textColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'ಮುದ್ದುರಾಮನ ಮನಸು is a gentle doorway to the timeless wisdom of instructive literature. Though inspired by the philosophical depth of Mankuthimmana Kagga, the verses here are extremely simple and easy to internalize.',
                    style: GoogleFonts.poppins(
                      fontSize: 14, height: 1.7, color: subtleColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Author
            _Card(
              cardColor: cardColor,
              accent: accent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle('ಕವಿ (Author)', accent),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accent.withOpacity(0.1),
                          border: Border.all(color: accent.withOpacity(0.3)),
                        ),
                        child: const Center(
                          child: Text('✍️', style: TextStyle(fontSize: 26)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ಕೆ. ಸಿ. ಶಿವಪ್ಪ',
                              style: GoogleFonts.tiroKannada(
                                fontSize: 18, fontWeight: FontWeight.w600, color: textColor,
                              ),
                            ),
                            Text(
                              'K. C. Shivappa',
                              style: GoogleFonts.poppins(
                                fontSize: 13, color: subtleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'K. C. Shivappa, a distinguished Kannada poet and writer, has poured the essence of his lifetime experiences into "ಮುದ್ದುರಾಮನ ಮನಸು." His literature stands out for its unique ability to convey profound philosophical truths through remarkably simple and accessible language.',
                    style: GoogleFonts.poppins(
                      fontSize: 13.5, height: 1.7, color: subtleColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Actions
            _Card(
              cardColor: cardColor,
              accent: accent,
              child: Column(
                children: [
                  _ActionTile(
                    icon: Icons.share_rounded,
                    label: 'ಹಂಚಿಕೊಳ್ಳಿ (Share App)',
                    accent: accent,
                    textColor: textColor,
                    onTap: () => Share.share(
                      'ಮುದ್ದುರಾಮನ ಮನಸು — Simple Verses, Profound Truths.\n\nhttps://hangyoicream.github.io/MuRa-Web-App/',
                    ),
                  ),
                  Divider(color: accent.withOpacity(0.1)),
                  _ActionTile(
                    icon: Icons.language_rounded,
                    label: 'ವೆಬ್‌ಸೈಟ್ (Web App)',
                    accent: accent,
                    textColor: textColor,
                    onTap: () => launchUrl(
                      Uri.parse('https://hangyoicream.github.io/MuRa-Web-App/'),
                    ),
                  ),
                  Divider(color: accent.withOpacity(0.1)),
                  _ActionTile(
                    icon: Icons.dark_mode_rounded,
                    label: isDark ? 'ಬೆಳಕಿನ ಮೋಡ್ (Light Mode)' : 'ಕತ್ತಲ ಮೋಡ್ (Dark Mode)',
                    accent: accent,
                    textColor: textColor,
                    trailing: Switch.adaptive(
                      value: isDark,
                      onChanged: (_) => context.read<AppProvider>().toggleDarkMode(),
                      activeColor: accent,
                    ),
                    onTap: () => context.read<AppProvider>().toggleDarkMode(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'ಕನ್ನಡಕ್ಕಾಗಿ ವಿನ್ಯಾಸಗೊಳಿಸಲಾಗಿದೆ\nDesigned for Kannada ❤️',
              style: GoogleFonts.tiroKannada(
                fontSize: 13, color: subtleColor, height: 1.8,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final Color cardColor;
  final Color accent;

  const _Card({required this.child, required this.cardColor, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  final Color color;
  const _SectionTitle(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.tiroKannada(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accent;
  final Color textColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.accent,
    required this.textColor,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.tiroKannada(fontSize: 15, color: textColor),
              ),
            ),
            trailing ??
                Icon(Icons.chevron_right_rounded,
                    color: accent.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }
}
