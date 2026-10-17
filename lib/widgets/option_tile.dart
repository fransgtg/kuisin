import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'pressable_scale.dart';

/// Status visual sebuah pilihan jawaban.
enum OptionState { idle, correct, wrong, disabled }

/// Satu pilihan jawaban (A, B, C, D) pada soal kuis.
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.index,
    required this.text,
    required this.state,
    this.onTap,
  });

  final int index;
  final String text;
  final OptionState state;
  final VoidCallback? onTap;

  static String letterFor(int index) => String.fromCharCode(65 + index);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.sp(16));

    final (
      Color border,
      Color background,
      Color badge,
      IconData? trailing,
    ) = switch (state) {
      OptionState.correct => (
        AppColors.success,
        AppColors.success.withValues(alpha: 0.12),
        AppColors.success,
        Icons.check_circle_rounded,
      ),
      OptionState.wrong => (
        AppColors.error,
        AppColors.error.withValues(alpha: 0.12),
        AppColors.error,
        Icons.cancel_rounded,
      ),
      OptionState.idle || OptionState.disabled => (
        scheme.outline,
        scheme.surface,
        AppColors.primary,
        null,
      ),
    };
    final highlighted =
        state == OptionState.correct || state == OptionState.wrong;

    return PressableScale(
      enabled: onTap != null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: state == OptionState.disabled ? 0.55 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: background,
            borderRadius: radius,
            border: Border.all(
              color: border,
              width: highlighted ? context.sp(2) : context.sp(1),
            ),
            boxShadow: highlighted
                ? AppColors.glow(border, context.sp(14), alpha: 0.22)
                : AppColors.glow(Colors.black, context.sp(10), alpha: 0.04),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: radius,
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.sp(14),
                  vertical: context.sp(13),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: context.sp(36),
                      height: context.sp(36),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: highlighted
                            ? null
                            : badge.withValues(alpha: 0.12),
                        gradient: highlighted ? AppColors.tonal(badge) : null,
                        borderRadius: BorderRadius.circular(context.sp(12)),
                      ),
                      child: Text(
                        letterFor(index),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: context.sp(15),
                          color: highlighted ? Colors.white : badge,
                        ),
                      ),
                    ),
                    SizedBox(width: context.sp(12)),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: context.sp(14.5),
                          fontWeight: FontWeight.w500,
                          height: 1.35,
                        ),
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: context.sp(8)),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.elasticOut,
                        builder: (context, t, child) =>
                            Transform.scale(scale: t, child: child),
                        child: Icon(
                          trailing,
                          color: border,
                          size: context.sp(24),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
