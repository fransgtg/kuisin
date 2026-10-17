import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';

/// Panel umpan balik benar/salah beserta pembahasan soal.
class ExplanationPanel extends StatelessWidget {
  const ExplanationPanel({
    super.key,
    required this.isCorrect,
    required this.explanation,
    this.correctAnswer,
  });

  final bool isCorrect;
  final String explanation;

  /// Ditampilkan saat jawaban salah.
  final String? correctAnswer;

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? AppColors.success : AppColors.error;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.sp(14)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.sp(16)),
        border: Border(
          left: BorderSide(color: color, width: context.sp(4)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.sp(7)),
            decoration: BoxDecoration(
              gradient: isCorrect
                  ? AppColors.successGradient
                  : AppColors.errorGradient,
              shape: BoxShape.circle,
              boxShadow: AppColors.glow(color, context.sp(8), alpha: 0.35),
            ),
            child: Icon(
              isCorrect ? Icons.celebration_rounded : Icons.lightbulb_rounded,
              color: Colors.white,
              size: context.sp(18),
            ),
          ),
          SizedBox(width: context.sp(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? 'Jawaban kamu benar!' : 'Kurang tepat',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: context.sp(14),
                  ),
                ),
                if (!isCorrect && correctAnswer != null)
                  Padding(
                    padding: EdgeInsets.only(top: context.sp(2)),
                    child: Text(
                      'Jawaban benar: $correctAnswer',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: context.sp(13),
                      ),
                    ),
                  ),
                SizedBox(height: context.sp(4)),
                Text(
                  explanation,
                  style: TextStyle(fontSize: context.sp(13), height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
