import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_routes.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/explanation_panel.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_card.dart';
import '../widgets/question_navigator.dart';
import '../widgets/quiz_progress_header.dart';
import '../widgets/responsive_center.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman pengerjaan kuis.
///
/// StatelessWidget: seluruh state (soal aktif, jawaban) berada di
/// [QuizProvider] sehingga tetap utuh saat layar dirotasi.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> _confirmExit(BuildContext context) async {
    final ok = await showConfirmDialog(
      context,
      icon: Icons.pause_circle_rounded,
      title: 'Jeda kuis?',
      message:
          'Progres jawabanmu tetap tersimpan. Kamu bisa melanjutkannya '
          'dari halaman beranda.',
      confirmLabel: 'Keluar',
      cancelLabel: 'Lanjut main',
    );
    if (ok && context.mounted) Navigator.pop(context);
  }

  Future<void> _finish(BuildContext context) async {
    final quiz = context.read<QuizProvider>();
    final remaining = quiz.totalQuestions - quiz.answeredCount;
    if (remaining > 0) {
      final ok = await showConfirmDialog(
        context,
        icon: Icons.warning_amber_rounded,
        title: 'Akhiri kuis?',
        message:
            'Masih ada $remaining soal yang belum dijawab dan akan '
            'dihitung salah.',
        confirmLabel: 'Akhiri',
      );
      if (!ok || !context.mounted) return;
    }
    final result = quiz.finishQuiz();
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.result,
      arguments: result,
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    // Kuis sudah selesai / belum dimulai (mis. rute dibuka ulang).
    if (!quiz.inProgress) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Tidak ada kuis yang sedang berjalan')),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: context.sp(64),
          leading: IconButton(
            tooltip: 'Jeda',
            icon: const Icon(Icons.close_rounded),
            onPressed: () => _confirmExit(context),
          ),
          title: Text(quiz.category!.title),
          actions: [
            _ScoreBadge(correct: quiz.correctSoFar),
            SizedBox(width: context.sp(8)),
            const ThemeToggleButton(),
            SizedBox(width: context.sp(12)),
          ],
        ),
        body: SafeArea(
          child: AdaptiveLayout(
            compact: (context) => SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.sp(16)),
              child: ResponsiveCenter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _header(quiz),
                    SizedBox(height: context.sp(18)),
                    _question(quiz),
                    SizedBox(height: context.sp(18)),
                    _options(context, quiz),
                  ],
                ),
              ),
            ),
            expanded: (context) => ResponsiveCenter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: context.sp(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _header(quiz),
                          SizedBox(height: context.sp(18)),
                          _question(quiz),
                          SizedBox(height: context.sp(18)),
                          _navigator(quiz),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: context.wp(4)),
                  Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: context.sp(16)),
                      child: _options(context, quiz),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _BottomControls(onFinish: () => _finish(context)),
      ),
    );
  }

  Widget _header(QuizProvider quiz) => QuizProgressHeader(
    current: quiz.currentIndex + 1,
    total: quiz.totalQuestions,
    answered: quiz.answeredCount,
  );

  Widget _question(QuizProvider quiz) => QuestionCard(
    number: quiz.currentIndex + 1,
    question: quiz.currentQuestion.text,
    icon: quiz.category!.icon,
  );

  Widget _navigator(QuizProvider quiz) => _NavigatorCard(
    child: QuestionNavigator(
      total: quiz.totalQuestions,
      currentIndex: quiz.currentIndex,
      statusOf: (i) {
        final answer = quiz.answerAt(i);
        return answer == null ? null : quiz.questions[i].isCorrect(answer);
      },
      onSelect: quiz.goTo,
    ),
  );

  Widget _options(BuildContext context, QuizProvider quiz) {
    final question = quiz.currentQuestion;
    final selected = quiz.currentAnswer;
    final answered = selected != null;

    OptionState stateOf(int i) {
      if (!answered) return OptionState.idle;
      if (i == question.correctIndex) return OptionState.correct;
      if (i == selected) return OptionState.wrong;
      return OptionState.disabled;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < question.options.length; i++) ...[
          FadeSlideIn(
            key: ValueKey('${quiz.currentIndex}-$i'),
            index: i,
            offset: 16,
            child: OptionTile(
              index: i,
              text: question.options[i],
              state: stateOf(i),
              onTap: answered ? null : () => quiz.answer(i),
            ),
          ),
          SizedBox(height: context.sp(12)),
        ],
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) => SizeTransition(
            sizeFactor: anim,
            child: FadeTransition(opacity: anim, child: child),
          ),
          child: answered
              ? ExplanationPanel(
                  key: ValueKey(quiz.currentIndex),
                  isCorrect: question.isCorrect(selected),
                  explanation: question.explanation,
                  correctAnswer: question.options[question.correctIndex],
                )
              : const SizedBox.shrink(),
        ),
        if (context.isMobile && !context.isLandscape) ...[
          SizedBox(height: context.sp(20)),
          _navigator(quiz),
        ],
      ],
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  const _ScoreBadge({required this.correct});

  final int correct;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Jawaban benar',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.sp(10),
          vertical: context.sp(6),
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD66B), AppColors.accent],
          ),
          borderRadius: BorderRadius.circular(context.sp(20)),
          boxShadow: AppColors.glow(
            AppColors.accent,
            context.sp(10),
            alpha: 0.35,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rounded, size: context.sp(18), color: Colors.white),
            SizedBox(width: context.sp(4)),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Text(
                '$correct',
                key: ValueKey(correct),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: context.sp(13),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kartu pembungkus navigasi nomor soal beserta keterangan warnanya.
class _NavigatorCard extends StatelessWidget {
  const _NavigatorCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget legend(Color color, String label) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.sp(8),
          height: context.sp(8),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: context.sp(4)),
        Text(
          label,
          style: TextStyle(
            fontSize: context.sp(11),
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.sp(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.grid_view_rounded,
                  size: context.sp(16),
                  color: AppColors.primary,
                ),
                SizedBox(width: context.sp(6)),
                Expanded(
                  child: Text(
                    'Navigasi Soal',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: context.sp(13.5),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.sp(6)),
            Wrap(
              spacing: context.sp(12),
              runSpacing: context.sp(4),
              children: [
                legend(AppColors.primary, 'Aktif'),
                legend(AppColors.success, 'Benar'),
                legend(AppColors.error, 'Salah'),
              ],
            ),
            SizedBox(height: context.sp(12)),
            child,
          ],
        ),
      ),
    );
  }
}

class _BottomControls extends StatelessWidget {
  const _BottomControls({required this.onFinish});

  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final scheme = Theme.of(context).colorScheme;
    final showFinish = quiz.isLastQuestion || quiz.allAnswered;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.sp(26)),
        ),
        border: Border(top: BorderSide(color: scheme.outline)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: context.sp(24),
            offset: Offset(0, -context.sp(4)),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ResponsiveCenter(
          padding: EdgeInsets.symmetric(
            horizontal: context.pagePadding,
            vertical: context.sp(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton.outlined(
                  label: 'Sebelumnya',
                  icon: Icons.arrow_back_rounded,
                  onPressed: quiz.isFirstQuestion ? null : quiz.previous,
                ),
              ),
              SizedBox(width: context.sp(12)),
              Expanded(
                child: showFinish
                    ? PrimaryButton(
                        label: 'Selesai',
                        icon: Icons.flag_rounded,
                        onPressed: onFinish,
                      )
                    : PrimaryButton(
                        label: 'Berikutnya',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: quiz.isLastQuestion ? null : quiz.next,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
