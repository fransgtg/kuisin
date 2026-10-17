import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Deretan nomor soal untuk melompat langsung ke soal tertentu.
/// Warna menandakan soal aktif, benar, salah, atau belum dijawab.
class QuestionNavigator extends StatelessWidget {
  const QuestionNavigator({
    super.key,
    required this.total,
    required this.currentIndex,
    required this.statusOf,
    required this.onSelect,
  });

  final int total;
  final int currentIndex;

  /// `null` = belum dijawab, `true` = benar, `false` = salah.
  final bool? Function(int index) statusOf;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = context.sp(38);

    return Wrap(
      spacing: context.sp(8),
      runSpacing: context.sp(8),
      children: List.generate(total, (i) {
        final status = statusOf(i);
        final active = i == currentIndex;
        final color = switch (status) {
          true => AppColors.success,
          false => AppColors.error,
          null => scheme.onSurfaceVariant,
        };

        return Tooltip(
          message: 'Soal ${i + 1}',
          child: InkWell(
            onTap: () => onSelect(i),
            borderRadius: BorderRadius.circular(context.sp(12)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: status == null
                    ? scheme.surface
                    : color.withValues(alpha: 0.15),
                gradient: active && status == null
                    ? AppColors.primaryGradient
                    : null,
                borderRadius: BorderRadius.circular(context.sp(12)),
                border: Border.all(
                  color: active
                      ? AppColors.primary
                      : (status == null ? scheme.outline : color),
                  width: active ? context.sp(2.2) : context.sp(1),
                ),
                boxShadow: active
                    ? AppColors.glow(AppColors.primary, context.sp(10))
                    : null,
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: context.sp(13),
                  color: active && status == null ? Colors.white : color,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
