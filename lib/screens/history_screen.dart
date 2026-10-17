import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_routes.dart';
import '../core/utils/responsive.dart';
import '../data/models/quiz_result.dart';
import '../providers/quiz_provider.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/history_tile.dart';
import '../widgets/responsive_center.dart';
import '../widgets/theme_toggle_button.dart';

/// Riwayat permainan dan papan skor (tersimpan selama aplikasi berjalan).
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat & Skor'),
          actions: [
            if (quiz.history.isNotEmpty)
              IconButton(
                tooltip: 'Hapus riwayat',
                icon: const Icon(Icons.delete_sweep_rounded),
                onPressed: () async {
                  final ok = await showConfirmDialog(
                    context,
                    icon: Icons.delete_forever_rounded,
                    title: 'Hapus semua riwayat?',
                    message: 'Seluruh riwayat dan papan skor akan dihapus.',
                    confirmLabel: 'Hapus',
                  );
                  if (ok) quiz.clearHistory();
                },
              ),
            SizedBox(width: context.sp(8)),
            const ThemeToggleButton(),
            SizedBox(width: context.sp(12)),
          ],
          bottom: TabBar(
            padding: EdgeInsets.symmetric(
              horizontal: context.pagePadding,
              vertical: context.sp(4),
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: context.sp(14),
              fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.history_rounded), text: 'Riwayat'),
              Tab(icon: Icon(Icons.emoji_events_rounded), text: 'Papan Skor'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _ResultList(results: quiz.history),
              _ResultList(results: quiz.leaderboard, ranked: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  const _ResultList({required this.results, this.ranked = false});

  final List<QuizResult> results;
  final bool ranked;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const EmptyState(
        icon: Icons.inbox_rounded,
        title: 'Belum ada data',
        message: 'Selesaikan satu kuis untuk melihat skor di sini.',
      );
    }

    return ResponsiveCenter(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: context.sp(16)),
        itemCount: results.length,
        separatorBuilder: (_, _) => SizedBox(height: context.sp(10)),
        itemBuilder: (context, i) => FadeSlideIn(
          index: i,
          child: InkWell(
            borderRadius: BorderRadius.circular(context.sp(20)),
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.review,
              arguments: results[i],
            ),
            child: HistoryTile(result: results[i], rank: ranked ? i + 1 : null),
          ),
        ),
      ),
    );
  }
}
