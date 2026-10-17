import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Header progres kuis: nomor soal, jumlah terjawab, dan progress bar.
class QuizProgressHeader extends StatelessWidget {
  const QuizProgressHeader({
    super.key,
    required this.current,
    required this.total,
    required this.answered,
  });

  final int current;
  final int total;
  final int answered;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final progress = total == 0 ? 0.0 : answered / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Soal $current',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: context.sp(16),
                      ),
                    ),
                    TextSpan(
                      text: ' / $total',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: context.sp(14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.task_alt_rounded,
              size: context.sp(16),
              color: AppColors.success,
            ),
            SizedBox(width: context.sp(4)),
            Text(
              '$answered terjawab',
              maxLines: 1,
              style: TextStyle(
                fontSize: context.sp(12.5),
                fontWeight: FontWeight.w500,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        SizedBox(height: context.sp(10)),
        TweenAnimationBuilder<double>(
          tween: Tween(end: progress),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) => Container(
            height: context.sp(10),
            decoration: BoxDecoration(
              color: scheme.outline.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(context.sp(8)),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(context.sp(8)),
                  boxShadow: value > 0
                      ? AppColors.glow(
                          AppColors.primary,
                          context.sp(8),
                          alpha: 0.4,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
