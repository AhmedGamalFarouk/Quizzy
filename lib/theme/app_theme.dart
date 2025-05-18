import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF5C6BC0); // Indigo
  static const Color accentColor = Color(0xFF26C6DA); // Cyan
  static const Color errorColor = Color(0xFFEF5350); // Red
  static const Color successColor = Color(0xFF66BB6A); // Green
  static const Color warningColor = Color(0xFFFFCA28); // Amber
  static const Color surfaceColor = Color(0xFFF5F5F5); // Light Gray
  static const Color darkSurfaceColor = Color(0xFF1E1E1E); // Dark Gray

  // Text Styles
  static TextStyle get headingStyle => GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      );

  static TextStyle get titleStyle => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.25,
      );

  static TextStyle get subtitleStyle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  static TextStyle get bodyStyle => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  static TextStyle get buttonTextStyle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  // Card styles
  static final CardTheme _baseCardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    clipBehavior: Clip.antiAlias,
    elevation: 3,
  );

  // Button styles
  static final ButtonStyle _elevatedButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 3,
  );

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: accentColor,
      onSecondary: Colors.black,
      error: errorColor,
      onError: Colors.white,
      surface: surfaceColor,
      onSurface: Colors.black87,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: headingStyle.copyWith(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _elevatedButtonStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(primaryColor),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(buttonTextStyle),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: buttonTextStyle,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      hintStyle: bodyStyle.copyWith(color: Colors.grey[400]),
      prefixIconColor: primaryColor,
    ),
    cardTheme: _baseCardTheme.copyWith(
      color: Colors.white,
      shadowColor: Colors.black12,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: headingStyle,
      headlineLarge: headingStyle,
      headlineMedium: headingStyle.copyWith(fontSize: 24),
      headlineSmall: headingStyle.copyWith(fontSize: 22),
      titleLarge: titleStyle,
      titleMedium: titleStyle.copyWith(fontSize: 18),
      titleSmall: titleStyle.copyWith(fontSize: 16),
      bodyLarge: bodyStyle.copyWith(fontSize: 16),
      bodyMedium: bodyStyle,
      bodySmall: bodyStyle.copyWith(fontSize: 12),
      labelLarge: buttonTextStyle,
    ).apply(
      displayColor: Colors.black87,
      bodyColor: Colors.black87,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.black12,
      thickness: 1,
      space: 24,
    ),
    iconTheme: const IconThemeData(
      color: primaryColor,
      size: 24,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: primaryColor.withOpacity(0.1),
      labelStyle: bodyStyle.copyWith(color: primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
      linearTrackColor: Colors.black12,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: accentColor,
      onPrimary: Colors.black,
      secondary: primaryColor,
      onSecondary: Colors.white,
      error: errorColor,
      onError: Colors.white,
      surface: darkSurfaceColor,
      onSurface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurfaceColor,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: headingStyle.copyWith(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _elevatedButtonStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(accentColor),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        textStyle: WidgetStateProperty.all(buttonTextStyle),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        textStyle: buttonTextStyle,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF303030),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
      hintStyle: bodyStyle.copyWith(color: Colors.grey[600]),
      prefixIconColor: accentColor,
    ),
    cardTheme: _baseCardTheme.copyWith(
      color: const Color(0xFF2C2C2C),
      shadowColor: Colors.black45,
    ),
    scaffoldBackgroundColor: darkSurfaceColor,
    textTheme: TextTheme(
      displayLarge: headingStyle,
      headlineLarge: headingStyle,
      headlineMedium: headingStyle.copyWith(fontSize: 24),
      headlineSmall: headingStyle.copyWith(fontSize: 22),
      titleLarge: titleStyle,
      titleMedium: titleStyle.copyWith(fontSize: 18),
      titleSmall: titleStyle.copyWith(fontSize: 16),
      bodyLarge: bodyStyle.copyWith(fontSize: 16),
      bodyMedium: bodyStyle,
      bodySmall: bodyStyle.copyWith(fontSize: 12),
      labelLarge: buttonTextStyle,
    ).apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.white24,
      thickness: 1,
      space: 24,
    ),
    iconTheme: const IconThemeData(
      color: accentColor,
      size: 24,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: accentColor.withOpacity(0.2),
      labelStyle: bodyStyle.copyWith(color: accentColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentColor,
      linearTrackColor: Colors.white24,
    ),
  );
}
