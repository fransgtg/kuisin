import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/formatters.dart';
import '../core/utils/responsive.dart';
import '../data/models/quiz_result.dart';
import '../providers/quiz_provider.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/score_ring.dart';
import '../widgets/stat_card.dart';
import '../widgets/svg_illustration.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman skor akhir pengguna.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.result});

  final QuizResult result;

  String get _headline => switch (result.grade) {
    'A' => 'Luar biasa',
    'B' => 'Hebat',
    'C' => 'Bagus',
    'D' => 'Lumayan',
    _ => 'Jangan menyerah',
  };

  String get _message => result.isPassed
      ? 'Kamu menguasai kategori ${result.categoryTitle} dengan baik. '
            'Pertahankan!'
      : 'Pelajari pembahasannya lalu coba lagi. Kamu pasti bisa!';

  void _goHome(BuildContext context) =>
      Navigator.popUntil(context, ModalRoute.withName(AppRoutes.home));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hasil Kuis'),
        actions: [
          const ThemeToggleButton(),
          SizedBox(width: context.sp(12)),
        ],
      ),
      body: SafeArea(
        child: AdaptiveLayout(
          compact: (context) => SingleChildScrollView(
            padding: EdgeInsets.only(bottom: context.sp(24)),
            child: ResponsiveCenter(
              child: Column(
                children: [
                  _summary(context, illustrationHeight: context.hp(11)),
                  SizedBox(height: context.sp(20)),
                  _stats(context),
                  SizedBox(height: context.sp(24)),
                  _actions(context),
                ],
              ),
            ),
          ),
          expanded: (context) => SingleChildScrollView(
            padding: EdgeInsets.only(bottom: context.sp(24)),
            child: ResponsiveCenter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _summary(
                      context,
                      illustrationHeight: math.min(
                        context.hp(16),
                        context.wp(18),
                      ),
                    ),
                  ),
                  SizedBox(width: context.wp(4)),
                  Expanded(
                    child: Column(
                      children: [
                        _stats(context),
                        SizedBox(height: context.sp(24)),
                        _actions(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _summary(BuildContext context, {required double illustrationHeight}) {
    final radius = BorderRadius.circular(context.sp(28));
    return FadeSlideIn(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.heroGradient,
          borderRadius: radius,
          boxShadow: AppColors.glow(AppColors.primary, context.sp(24)),
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Stack(
            children: [
              Positioned(
                left: -context.sp(50),
                top: -context.sp(50),
                child: _Bubble(size: context.sp(160)),
              ),
              Positioned(
                right: -context.sp(40),
                bottom: -context.sp(40),
                child: _Bubble(size: context.sp(130)),
              ),
              Padding(
                padding: EdgeInsets.all(context.sp(20)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(context.sp(10)),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: SvgIllustration(
                        result.isPassed
                            ? AppAssets.trophy
                            : AppAssets.encourage,
                        height: illustrationHeight,
                      ),
                    ),
                    SizedBox(height: context.sp(14)),
                    Text(
                      '$_headline, ${result.playerName}!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: context.sp(22),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: context.sp(6)),
                    Text(
                      _message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: context.sp(13.5),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: context.sp(20)),
                    ScoreRing(
                      score: result.score,
                      diameter: context.sp(140),
                      onGradient: true,
                    ),
                    SizedBox(height: context.sp(14)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.sp(14),
                        vertical: context.sp(6),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(context.sp(20)),
                      ),
                      child: Text(
                        '${result.categoryTitle} • '
                        '${result.correct}/${result.total} benar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: context.sp(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stats(BuildContext context) {
    final cards = [
      StatCard(
        icon: Icons.check_rounded,
        label: 'Benar',
        value: '${result.correct}',
        color: AppColors.success,
      ),
      StatCard(
        icon: Icons.close_rounded,
        label: 'Salah',
        value: '${result.wrong}',
        color: AppColors.error,
      ),
      StatCard(
        icon: Icons.workspace_premium_rounded,
        label: 'Nilai',
        value: result.grade,
        color: AppColors.primary,
      ),
      StatCard(
        icon: Icons.timer_rounded,
        label: 'Waktu',
        value: formatDuration(result.duration),
        color: AppColors.secondary,
      ),
    ];
    final gap = context.sp(10);
    Widget cell(int i) => Expanded(
      child: FadeSlideIn(index: i + 1, child: cards[i]),
    );

    return Column(
      children: [
        Row(
          children: [
            cell(0),
            SizedBox(width: gap),
            cell(1),
          ],
        ),
        SizedBox(height: gap),
        Row(
          children: [
            cell(2),
            SizedBox(width: gap),
            cell(3),
          ],
        ),
      ],
    );
  }

  Widget _actions(BuildContext context) {
    return FadeSlideIn(
      index: 5,
      child: Column(
        children: [
          PrimaryButton(
            label: 'Lihat Pembahasan',
            icon: Icons.menu_book_rounded,
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.review,
              arguments: result,
            ),
          ),
          SizedBox(height: context.sp(12)),
          PrimaryButton.outlined(
            label: 'Ulangi Kuis',
            icon: Icons.replay_rounded,
            onPressed: () {
              context.read<QuizProvider>().restart();
              Navigator.pushReplacementNamed(context, AppRoutes.quiz);
            },
          ),
          SizedBox(height: context.sp(4)),
          TextButton.icon(
            onPressed: () => _goHome(context),
            icon: Icon(Icons.home_rounded, size: context.sp(20)),
            label: Text(
              'Kembali ke Beranda',
              style: TextStyle(fontSize: context.sp(14)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.08),
      ),
    );
  }
}
