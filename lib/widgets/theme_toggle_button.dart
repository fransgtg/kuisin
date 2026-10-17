import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/responsive.dart';
import '../providers/theme_provider.dart';

/// Tombol untuk berpindah antara Light Mode dan Dark Mode.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final dark = themeProvider.isDark(context);

    return IconButton(
      tooltip: dark ? 'Mode terang' : 'Mode gelap',
      iconSize: context.sp(24),
      onPressed: () => themeProvider.toggle(context),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) =>
            RotationTransition(turns: anim, child: child),
        child: Icon(
          dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(dark),
        ),
      ),
    );
  }
}
