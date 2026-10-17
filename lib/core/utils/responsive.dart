import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Jenis perangkat berdasarkan lebar layar.
enum DeviceType { mobile, tablet, desktop }

/// Helper ukuran dinamis agar elemen UI menyesuaikan ukuran layar
/// (tidak memakai angka piksel yang di-hardcode).
extension Responsive on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  bool get isLandscape => screenWidth > screenHeight;

  DeviceType get deviceType {
    if (screenWidth >= 1024) return DeviceType.desktop;
    if (screenWidth >= 600) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  bool get isMobile => deviceType == DeviceType.mobile;

  /// Lebar konten maksimum supaya tampilan tetap proporsional di tablet/web.
  double get contentMaxWidth => switch (deviceType) {
    DeviceType.mobile => screenWidth,
    DeviceType.tablet => screenWidth * 0.85,
    DeviceType.desktop => math.min(screenWidth * 0.7, 1100),
  };

  /// Persentase dari lebar konten.
  double wp(double percent) =>
      math.min(screenWidth, contentMaxWidth) * percent / 100;

  /// Persentase dari tinggi layar.
  double hp(double percent) => screenHeight * percent / 100;

  /// Skala ukuran (font, ikon, radius) relatif terhadap sisi terpendek layar.
  /// Desain acuan: lebar 375 (ponsel standar), dibatasi agar tidak berlebihan.
  double sp(double size) {
    final shortest = math.min(screenWidth, screenHeight);
    final scale = (shortest / 375).clamp(0.85, 1.35);
    return size * scale;
  }

  /// Jarak horizontal standar halaman.
  double get pagePadding => sp(20);
}
