// Theme configuration for JobConnect app
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand colors
  static const primaryColor = Color(0xFF2563EB); // Primary blue
  static const secondaryColor = Color(0xFF1E40AF); // Darker blue
  static const accentColor = Color(0xFF22C55E); // Success green

  // Text colors
  static const textPrimaryColor = Color(0xFF1F2937);
  static const textSecondaryColor = Color(0xFF6B7280);

  // Background colors
  static const backgroundColor = Color(0xFFF9FAFB);
  static const surfaceColor = Colors.white;

  // Light theme configuration
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: GoogleFonts.inter().fontFamily,

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textPrimaryColor),
      titleTextStyle: TextStyle(
        color: textPrimaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: textPrimaryColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        color: textSecondaryColor,
      ),
    ),
  );
}
