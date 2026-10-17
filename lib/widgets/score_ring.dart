import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Lingkaran skor beranimasi (0–100).
class ScoreRing extends StatelessWidget {
  const ScoreRing({
    super.key,
    required this.score,
    required this.diameter,
    this.onGradient = false,
  });

  final int score;
  final double diameter;

  /// `true` jika diletakkan di atas latar bergradien (teks & jalur putih).
  final bool onGradient;

  Color get _color {
    if (score >= 75) return AppColors.success;
    if (score >= 50) return AppColors.accent;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textColor = onGradient ? Colors.white : scheme.onSurface;
    final subColor = onGradient
        ? Colors.white.withValues(alpha: 0.8)
        : scheme.onSurfaceVariant;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score / 100),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) => Container(
        width: diameter,
        height: diameter,
        padding: EdgeInsets.all(diameter * 0.06),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: onGradient ? Colors.white.withValues(alpha: 0.12) : null,
          boxShadow: AppColors.glow(_color, diameter * 0.18, alpha: 0.35),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: value,
              strokeWidth: diameter * 0.08,
              strokeCap: StrokeCap.round,
              backgroundColor: onGradient
                  ? Colors.white.withValues(alpha: 0.25)
                  : scheme.outline,
              valueColor: AlwaysStoppedAnimation(_color),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(value * 100).round()}',
                    style: TextStyle(
                      fontSize: diameter * 0.28,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: textColor,
                    ),
                  ),
                  Text(
                    'SKOR',
                    style: TextStyle(
                      fontSize: context.sp(11),
                      letterSpacing: context.sp(2),
                      fontWeight: FontWeight.w600,
                      color: subColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
