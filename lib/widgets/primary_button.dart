import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'pressable_scale.dart';

enum ButtonVariant { filled, outlined }

/// Tombol utama aplikasi dengan gradien (filled) atau garis tepi (outlined).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = ButtonVariant.filled,
    this.expand = true,
  });

  const PrimaryButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
  }) : variant = ButtonVariant.outlined;

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonVariant variant;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final filled = variant == ButtonVariant.filled;
    final radius = BorderRadius.circular(context.sp(16));
    final scheme = Theme.of(context).colorScheme;
    final foreground = filled
        ? Colors.white
        : (enabled ? AppColors.primary : scheme.onSurfaceVariant);

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, color: foreground, size: context.sp(20)),
          SizedBox(width: context.sp(8)),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: foreground,
              fontWeight: FontWeight.w600,
              fontSize: context.sp(15),
            ),
          ),
        ),
      ],
    );

    return PressableScale(
      enabled: enabled,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1 : 0.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: filled ? AppColors.heroGradient : null,
            color: filled ? null : AppColors.primary.withValues(alpha: 0.06),
            border: filled
                ? null
                : Border.all(color: foreground, width: context.sp(1.5)),
            boxShadow: filled && enabled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: context.sp(16),
                      offset: Offset(0, context.sp(6)),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: radius,
              onTap: onPressed,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.sp(15),
                  horizontal: context.sp(20),
                ),
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
