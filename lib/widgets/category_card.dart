import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/models/quiz_category.dart';
import 'pressable_scale.dart';

/// Kartu kategori kuis yang dapat dipilih.
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final QuizCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.sp(22));
    final color = category.color;

    return PressableScale(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: scheme.surface,
          gradient: selected
              ? LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.18),
                    color.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: radius,
          border: Border.all(
            color: selected ? color : scheme.outline,
            width: selected ? context.sp(2) : context.sp(1),
          ),
          boxShadow: selected
              ? AppColors.glow(color, context.sp(18), alpha: 0.3)
              : AppColors.glow(Colors.black, context.sp(12), alpha: 0.04),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Stack(
              children: [
                // Ikon besar samar sebagai aksen latar.
                Positioned(
                  right: -context.sp(14),
                  bottom: -context.sp(14),
                  child: Icon(
                    category.icon,
                    size: context.sp(72),
                    color: color.withValues(alpha: selected ? 0.14 : 0.06),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(context.sp(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.sp(10)),
                            decoration: BoxDecoration(
                              gradient: AppColors.tonal(color),
                              borderRadius: BorderRadius.circular(
                                context.sp(14),
                              ),
                              boxShadow: AppColors.glow(
                                color,
                                context.sp(10),
                                alpha: 0.35,
                              ),
                            ),
                            child: Icon(
                              category.icon,
                              color: Colors.white,
                              size: context.sp(22),
                            ),
                          ),
                          const Spacer(),
                          AnimatedScale(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutBack,
                            scale: selected ? 1 : 0,
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: color,
                              size: context.sp(22),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.sp(12)),
                      Text(
                        category.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: context.sp(15),
                        ),
                      ),
                      SizedBox(height: context.sp(2)),
                      Text(
                        category.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: scheme.onSurfaceVariant,
                          fontSize: context.sp(11.5),
                          height: 1.35,
                        ),
                      ),
                      SizedBox(height: context.sp(10)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.sp(8),
                          vertical: context.sp(3),
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(context.sp(20)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.help_outline_rounded,
                              size: context.sp(13),
                              color: color,
                            ),
                            SizedBox(width: context.sp(4)),
                            Flexible(
                              child: Text(
                                '${category.questions.length} soal',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: context.sp(11),
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
