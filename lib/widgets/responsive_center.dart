import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Membatasi lebar konten di tengah layar agar tetap proporsional
/// pada tablet dan browser.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.contentMaxWidth),
        child: Padding(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: context.pagePadding),
          child: child,
        ),
      ),
    );
  }
}

/// Memilih tata letak berdasarkan ruang yang tersedia:
/// satu kolom untuk ponsel portrait, dua kolom untuk layar lebar.
class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.compact,
    required this.expanded,
  });

  final WidgetBuilder compact;
  final WidgetBuilder expanded;

  @override
  Widget build(BuildContext context) {
    final useExpanded = !context.isMobile || context.isLandscape;
    return useExpanded ? expanded(context) : compact(context);
  }
}
