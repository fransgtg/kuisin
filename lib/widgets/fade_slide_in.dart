import 'package:flutter/material.dart';

/// Animasi masuk sekali jalan: memudar sambil bergeser ke atas.
///
/// Gunakan [index] untuk efek bertahap (staggered) pada daftar.
class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.index = 0,
    this.offset = 24,
  });

  final Widget child;
  final int index;

  /// Jarak geser awal (piksel logis).
  final double offset;

  @override
  Widget build(BuildContext context) {
    final delay = (index * 70).clamp(0, 600);
    final total = 450 + delay;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: total),
      curve: Interval(delay / total, 1, curve: Curves.easeOutCubic),
      child: child,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * offset),
          child: child,
        ),
      ),
    );
  }
}
