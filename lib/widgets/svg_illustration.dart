import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Menampilkan ilustrasi SVG dari folder aset dengan tinggi dinamis.
class SvgIllustration extends StatelessWidget {
  const SvgIllustration(this.asset, {super.key, required this.height});

  final String asset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(asset, height: height, fit: BoxFit.contain);
  }
}
