import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF7C5CFF);
  static const Color primaryDark = Color(0xFF5A3FE0);
  static const Color secondary = Color(0xFF4F8BFF);
  static const Color accent = Color(0xFFFFC542);
  static const Color pink = Color(0xFFFF7EB3);
  static const Color success = Color(0xFF3DD598);
  static const Color error = Color(0xFFFF5C7A);

  // Light
  static const Color lightBackground = Color(0xFFF6F5FF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E1B3A);
  static const Color lightSubtext = Color(0xFF6E6B8A);
  static const Color lightBorder = Color(0xFFE4E1F5);

  // Dark
  static const Color darkBackground = Color(0xFF12111F);
  static const Color darkSurface = Color(0xFF1E1C33);
  static const Color darkText = Color(0xFFF2F0FF);
  static const Color darkSubtext = Color(0xFFA9A6C7);
  static const Color darkBorder = Color(0xFF2F2C4D);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradien kartu hero (beranda & hasil) yang lebih kaya warna.
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF6A4CFF), primary, Color(0xFF4F8BFF)],
    stops: [0, 0.45, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF3DD598), Color(0xFF1FB5A8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFFF7E8F), error],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradien dua nada dari satu warna (untuk ikon kategori, dll).
  static LinearGradient tonal(Color color) => LinearGradient(
    colors: [Color.lerp(color, Colors.white, 0.25)!, color],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Bayangan lembut berwarna untuk kartu yang menonjol.
  static List<BoxShadow> glow(Color color, double blur, {double alpha = 0.3}) =>
      [
        BoxShadow(
          color: color.withValues(alpha: alpha),
          blurRadius: blur,
          offset: Offset(0, blur * 0.4),
        ),
      ];
}
