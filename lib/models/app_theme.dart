import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color saffron = Color(0xFFFF9933);
  static const Color deepSaffron = Color(0xFFE07B20);
  static const Color cream = Color(0xFFFFF8EC);
  static const Color darkBg = Color(0xFF1A1208);
  static const Color darkSurface = Color(0xFF2A1E0F);
  static const Color darkCard = Color(0xFF3A2A15);
  static const Color goldAccent = Color(0xFFD4A017);
  static const Color mutedText = Color(0xFF8B7355);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: cream,
      colorScheme: const ColorScheme.light(
        primary: saffron,
        secondary: goldAccent,
        surface: Colors.white,
        background: cream,
        onPrimary: Colors.white,
        onBackground: Color(0xFF2C1A00),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: cream,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF2C1A00)),
        titleTextStyle: GoogleFonts.tiroKannada(
          color: const Color(0xFF2C1A00),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: _textTheme(Brightness.light),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      colorScheme: const ColorScheme.dark(
        primary: saffron,
        secondary: goldAccent,
        surface: darkSurface,
        background: darkBg,
        onPrimary: Colors.white,
        onBackground: Color(0xFFFFF0D0),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFFFF0D0)),
        titleTextStyle: GoogleFonts.tiroKannada(
          color: const Color(0xFFFFF0D0),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: _textTheme(Brightness.dark),
      useMaterial3: true,
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final baseColor = brightness == Brightness.light
        ? const Color(0xFF2C1A00)
        : const Color(0xFFFFF0D0);
    return GoogleFonts.tiroKannadaTextTheme().copyWith(
      bodyLarge: GoogleFonts.tiroKannada(color: baseColor, fontSize: 18, height: 1.8),
      bodyMedium: GoogleFonts.tiroKannada(color: baseColor, fontSize: 15, height: 1.7),
      bodySmall: GoogleFonts.tiroKannada(color: baseColor.withOpacity(0.6), fontSize: 13),
      titleLarge: GoogleFonts.tiroKannada(color: baseColor, fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.tiroKannada(color: baseColor, fontSize: 18, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.poppins(color: baseColor.withOpacity(0.5), fontSize: 11),
    );
  }
}
