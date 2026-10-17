import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Kartu kecil statistik (ikon + nilai + label).
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.sp(12),
        horizontal: context.sp(12),
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.sp(20)),
        border: Border.all(color: scheme.outline),
        boxShadow: AppColors.glow(color, context.sp(14), alpha: 0.12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.sp(9)),
            decoration: BoxDecoration(
              gradient: AppColors.tonal(color),
              borderRadius: BorderRadius.circular(context.sp(14)),
              boxShadow: AppColors.glow(color, context.sp(8), alpha: 0.35),
            ),
            child: Icon(icon, color: Colors.white, size: context.sp(20)),
          ),
          SizedBox(width: context.sp(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: context.sp(18),
                      height: 1.15,
                    ),
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.sp(11.5),
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
