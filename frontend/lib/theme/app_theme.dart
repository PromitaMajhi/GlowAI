import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Theme Colors
  static const Color primaryPink = Color(0xFFFADADD); // Soft Pink
  static const Color secondaryBeige = Color(0xFFF5F5DC); // Light Beige
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF7A7A7A);
  static const Color accentColor = Color(0xFFFFB6C1); // Light Pink accent

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryPink,
      scaffoldBackgroundColor: white,
      colorScheme: ColorScheme.light(
        primary: primaryPink,
        secondary: accentColor,
        background: white,
        surface: white,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
            color: textDark, fontSize: 32, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.outfit(
            color: textDark, fontSize: 24, fontWeight: FontWeight.w600),
        bodyLarge: const TextStyle(color: textDark, fontSize: 16),
        bodyMedium: const TextStyle(color: textLight, fontSize: 14),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        elevation: 0,
        iconTheme: const IconThemeData(color: textDark),
        titleTextStyle: GoogleFonts.outfit(
            color: textDark, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPink,
          foregroundColor: textDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryBeige.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: primaryPink, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
