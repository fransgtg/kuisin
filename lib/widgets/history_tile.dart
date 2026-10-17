import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/formatters.dart';
import '../core/utils/responsive.dart';
import '../data/models/quiz_result.dart';

/// Satu baris riwayat / papan skor.
class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.result, this.rank});

  final QuizResult result;

  /// Jika diisi, tampilkan peringkat (papan skor) alih-alih nilai huruf.
  final int? rank;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = result.isPassed ? AppColors.success : AppColors.error;
    final medal = switch (rank) {
      1 => const Color(0xFFFFC542),
      2 => const Color(0xFFB8C0CC),
      3 => const Color(0xFFD08A4E),
      _ => null,
    };

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.sp(12)),
        child: Row(
          children: [
            Container(
              width: context.sp(46),
              height: context.sp(46),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: medal == null ? color.withValues(alpha: 0.15) : null,
                gradient: medal == null ? null : AppColors.tonal(medal),
                borderRadius: BorderRadius.circular(context.sp(14)),
                boxShadow: medal == null
                    ? null
                    : AppColors.glow(medal, context.sp(10), alpha: 0.4),
              ),
              child: medal != null
                  ? Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white,
                      size: context.sp(26),
                    )
                  : Text(
                      rank != null ? '#$rank' : result.grade,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: context.sp(16),
                        color: rank != null ? scheme.onSurfaceVariant : color,
                      ),
                    ),
            ),
            SizedBox(width: context.sp(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.playerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: context.sp(14.5),
                    ),
                  ),
                  SizedBox(height: context.sp(2)),
                  Text(
                    '${result.categoryTitle} • ${formatDuration(result.duration)}'
                    ' • ${formatTime(result.finishedAt)}',
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
            SizedBox(width: context.sp(8)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${result.score}',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: context.sp(20),
                    color: color,
                  ),
                ),
                Text(
                  '${result.correct}/${result.total} benar',
                  style: TextStyle(
                    fontSize: context.sp(11),
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
