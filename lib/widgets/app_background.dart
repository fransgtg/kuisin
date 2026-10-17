import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Latar belakang halaman dengan gumpalan warna lembut di sudut-sudut layar.
///
/// Bungkus [Scaffold] dengan widget ini; scaffold otomatis dibuat transparan
/// lewat [Theme] agar dekorasi terlihat.
class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final strength = dark ? 0.22 : 0.16;

    return DecoratedBox(
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: LayoutBuilder(
                builder: (context, c) {
                  final size = c.biggest.shortestSide;
                  return Stack(
                    children: [
                      _Blob(
                        color: AppColors.primary.withValues(alpha: strength),
                        diameter: size * 1.1,
                        left: -size * 0.45,
                        top: -size * 0.5,
                      ),
                      _Blob(
                        color: AppColors.secondary.withValues(alpha: strength),
                        diameter: size * 0.9,
                        right: -size * 0.4,
                        top: c.maxHeight * 0.25,
                      ),
                      _Blob(
                        color: AppColors.pink.withValues(alpha: strength * 0.8),
                        diameter: size,
                        left: -size * 0.3,
                        bottom: -size * 0.55,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Theme(
            data: theme.copyWith(scaffoldBackgroundColor: Colors.transparent),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.color,
    required this.diameter,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });

  final Color color;
  final double diameter;
  final double? left, top, right, bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
