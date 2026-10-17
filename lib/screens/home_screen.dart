import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_assets.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/dummy/question_bank.dart';
import '../providers/quiz_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_center.dart';
import '../widgets/section_title.dart';
import '../widgets/svg_illustration.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman awal: memasukkan nama dan memilih kategori kuis.
///
/// StatefulWidget karena mengelola [TextEditingController] dan [GlobalKey]
/// form yang memiliki siklus hidup sendiri.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: context.read<QuizProvider>().playerName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final quiz = context.read<QuizProvider>();
    final category = quiz.selectedCategory;
    if (category == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Pilih kategori kuis terlebih dahulu')),
        );
      return;
    }

    if (quiz.inProgress) {
      final ok = await showConfirmDialog(
        context,
        icon: Icons.restart_alt_rounded,
        title: 'Mulai kuis baru?',
        message:
            'Progres kuis "${quiz.category!.title}" yang belum selesai '
            'akan dihapus.',
        confirmLabel: 'Mulai baru',
      );
      if (!ok || !mounted) return;
    }

    quiz
      ..setPlayerName(_nameController.text)
      ..startQuiz(category);
    Navigator.pushNamed(context, AppRoutes.quiz);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: AdaptiveLayout(
            compact: (context) => SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.sp(24)),
              child: ResponsiveCenter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FadeSlideIn(child: _HomeHeader()),
                    SizedBox(height: context.sp(8)),
                    FadeSlideIn(
                      index: 1,
                      child: _HeroCard(illustrationHeight: context.hp(14)),
                    ),
                    SizedBox(height: context.sp(20)),
                    FadeSlideIn(index: 2, child: _buildNameField(context)),
                    SizedBox(height: context.sp(24)),
                    const FadeSlideIn(index: 3, child: _CategoryTitle()),
                    SizedBox(height: context.sp(12)),
                    const _CategoryGrid(),
                    SizedBox(height: context.sp(24)),
                    FadeSlideIn(index: 8, child: _buildStartButton()),
                  ],
                ),
              ),
            ),
            expanded: (context) => ResponsiveCenter(
              child: Column(
                children: [
                  const FadeSlideIn(child: _HomeHeader()),
                  SizedBox(height: context.sp(8)),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: context.sp(24)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FadeSlideIn(
                                  index: 1,
                                  child: _HeroCard(
                                    illustrationHeight: math.min(
                                      context.hp(24),
                                      context.wp(14),
                                    ),
                                  ),
                                ),
                                SizedBox(height: context.sp(20)),
                                FadeSlideIn(
                                  index: 2,
                                  child: _buildNameField(context),
                                ),
                                SizedBox(height: context.sp(20)),
                                FadeSlideIn(
                                  index: 3,
                                  child: _buildStartButton(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: context.wp(4)),
                        Expanded(
                          flex: 6,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: context.sp(24)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const FadeSlideIn(
                                  index: 2,
                                  child: _CategoryTitle(),
                                ),
                                SizedBox(height: context.sp(12)),
                                const _CategoryGrid(),
                              ],
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
        ),
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Siapa namamu?',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: context.sp(14),
          ),
        ),
        SizedBox(height: context.sp(8)),
        TextFormField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          maxLength: 20,
          onChanged: context.read<QuizProvider>().setPlayerName,
          onFieldSubmitted: (_) => _start(),
          style: TextStyle(
            fontSize: context.sp(15),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'Tulis nama panggilanmu',
            counterText: '',
            prefixIcon: Padding(
              padding: EdgeInsets.all(context.sp(10)),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(context.sp(10)),
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: context.sp(18),
                  color: Colors.white,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints.tight(
              Size.square(context.sp(54)),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: context.sp(16),
              horizontal: context.sp(16),
            ),
          ),
          validator: (value) {
            final name = value?.trim() ?? '';
            if (name.isEmpty) return 'Nama tidak boleh kosong';
            if (name.length < 2) return 'Nama minimal 2 karakter';
            return null;
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: context.sp(6), left: context.sp(4)),
          child: Text(
            'Namamu akan tampil di papan skor.',
            style: TextStyle(
              fontSize: context.sp(11.5),
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        const _ResumeBanner(),
      ],
    );
  }

  Widget _buildStartButton() => PrimaryButton(
    label: 'Mulai Kuis',
    icon: Icons.play_arrow_rounded,
    onPressed: _start,
  );
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sp(8)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.sp(4)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(context.sp(14)),
              boxShadow: AppColors.glow(
                AppColors.primary,
                context.sp(14),
                alpha: 0.2,
              ),
            ),
            child: SvgIllustration(AppAssets.logo, height: context.sp(36)),
          ),
          SizedBox(width: context.sp(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: AppColors.primaryGradient.createShader,
                  child: Text(
                    'Kuisin',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: context.sp(22),
                      height: 1.1,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Kuis pilihan ganda',
                  style: TextStyle(
                    fontSize: context.sp(11.5),
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Riwayat & papan skor',
            iconSize: context.sp(22),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
            icon: const Icon(Icons.leaderboard_rounded),
          ),
          SizedBox(width: context.sp(8)),
          const ThemeToggleButton(),
        ],
      ),
    );
  }
}

/// Kartu sambutan bergradien dengan ilustrasi dan statistik singkat.
class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.illustrationHeight});

  final double illustrationHeight;

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final name = quiz.playerName.trim();
    const categories = QuestionBank.categories;
    final totalQuestions = categories.fold<int>(
      0,
      (sum, c) => sum + c.questions.length,
    );
    final radius = BorderRadius.circular(context.sp(28));

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: radius,
        boxShadow: AppColors.glow(AppColors.primary, context.sp(24)),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            // Cincin dekoratif.
            Positioned(
              right: -context.sp(40),
              top: -context.sp(50),
              child: _Ring(size: context.sp(160)),
            ),
            Positioned(
              left: -context.sp(30),
              bottom: -context.sp(60),
              child: _Ring(size: context.sp(120)),
            ),
            Padding(
              padding: EdgeInsets.all(context.sp(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.sp(10),
                                vertical: context.sp(4),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(
                                  context.sp(20),
                                ),
                              ),
                              child: Text(
                                name.isEmpty ? 'Halo!' : 'Halo, $name!',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: context.sp(12),
                                ),
                              ),
                            ),
                            SizedBox(height: context.sp(10)),
                            Text(
                              'Siap uji wawasanmu?',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: context.sp(21),
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: context.sp(6)),
                            Text(
                              'Pilih kategori, jawab semua soal, dan raih '
                              'skor tertinggi!',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: context.sp(12.5),
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: context.sp(8)),
                      SvgIllustration(
                        AppAssets.hero,
                        height: illustrationHeight,
                      ),
                    ],
                  ),
                  SizedBox(height: context.sp(16)),
                  Row(
                    children: [
                      Expanded(
                        child: _HeroStat(
                          icon: Icons.category_rounded,
                          value: '${categories.length}',
                          label: 'Kategori',
                        ),
                      ),
                      SizedBox(width: context.sp(8)),
                      Expanded(
                        child: _HeroStat(
                          icon: Icons.quiz_rounded,
                          value: '$totalQuestions',
                          label: 'Soal',
                        ),
                      ),
                      SizedBox(width: context.sp(8)),
                      Expanded(
                        child: _HeroStat(
                          icon: Icons.sports_esports_rounded,
                          value: '${quiz.history.length}',
                          label: 'Dimainkan',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: size * 0.12,
        ),
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sp(10),
        vertical: context.sp(8),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(context.sp(14)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: context.sp(18)),
          SizedBox(width: context.sp(6)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: context.sp(14),
                    height: 1.1,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: context.sp(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTitle extends StatelessWidget {
  const _CategoryTitle();

  @override
  Widget build(BuildContext context) {
    return SectionTitle(
      'Pilih Kategori',
      trailing: Text(
        '${QuestionBank.categories.length} tersedia',
        style: TextStyle(
          fontSize: context.sp(12),
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Muncul jika ada kuis yang belum selesai, agar pengguna bisa melanjutkan.
class _ResumeBanner extends StatelessWidget {
  const _ResumeBanner();

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    if (!quiz.inProgress) return const SizedBox.shrink();
    final radius = BorderRadius.circular(context.sp(18));

    return Padding(
      padding: EdgeInsets.only(top: context.sp(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(
            colors: [
              AppColors.accent.withValues(alpha: 0.25),
              AppColors.accent.withValues(alpha: 0.08),
            ],
          ),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: radius,
            onTap: () => Navigator.pushNamed(context, AppRoutes.quiz),
            child: Padding(
              padding: EdgeInsets.all(context.sp(14)),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(context.sp(8)),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(context.sp(12)),
                    ),
                    child: Icon(
                      Icons.history_toggle_off_rounded,
                      color: Colors.white,
                      size: context.sp(22),
                    ),
                  ),
                  SizedBox(width: context.sp(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lanjutkan kuis ${quiz.category!.title}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: context.sp(14),
                          ),
                        ),
                        SizedBox(height: context.sp(6)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(context.sp(4)),
                          child: LinearProgressIndicator(
                            value: quiz.progress,
                            minHeight: context.sp(5),
                            backgroundColor: AppColors.accent.withValues(
                              alpha: 0.2,
                            ),
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.accent,
                            ),
                          ),
                        ),
                        SizedBox(height: context.sp(4)),
                        Text(
                          '${quiz.answeredCount} dari ${quiz.totalQuestions} '
                          'soal sudah dijawab',
                          style: TextStyle(fontSize: context.sp(11.5)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: context.sp(8)),
                  Icon(Icons.arrow_forward_ios_rounded, size: context.sp(16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Grid kategori dengan jumlah kolom yang menyesuaikan lebar yang tersedia.
class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    const categories = QuestionBank.categories;
    final spacing = context.sp(12);

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = math.max(
          2,
          (constraints.maxWidth / context.sp(190)).floor(),
        );
        final rows = <Widget>[];
        for (var i = 0; i < categories.length; i += columns) {
          rows.add(
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var j = i; j < i + columns; j++) ...[
                    if (j > i) SizedBox(width: spacing),
                    Expanded(
                      child: j < categories.length
                          ? FadeSlideIn(
                              index: 3 + j,
                              child: CategoryCard(
                                category: categories[j],
                                selected:
                                    quiz.selectedCategoryId == categories[j].id,
                                onTap: () =>
                                    quiz.selectCategory(categories[j].id),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            for (var r = 0; r < rows.length; r++) ...[
              if (r > 0) SizedBox(height: spacing),
              rows[r],
            ],
          ],
        );
      },
    );
  }
}
