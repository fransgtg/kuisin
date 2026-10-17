import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Dialog konfirmasi yang dipakai ulang (keluar kuis, hapus riwayat, dll).
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required IconData icon,
  String confirmLabel = 'Ya',
  String cancelLabel = 'Batal',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Container(
        padding: EdgeInsets.all(context.sp(14)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
          boxShadow: AppColors.glow(AppColors.primary, context.sp(16)),
        ),
        child: Icon(icon, size: context.sp(32), color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: context.sp(18)),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: context.sp(14)),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}
