import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';

/// Judul bagian dengan aksi opsional di sisi kanan.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: context.sp(16),
            ),
          ),
        ),
        ?trailing,
      ],
    );
  }
}
