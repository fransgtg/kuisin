import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../data/models/quiz_result.dart';
import '../widgets/explanation_panel.dart';
import '../widgets/fade_slide_in.dart';
import '../widgets/option_tile.dart';
import '../widgets/responsive_center.dart';
import '../widgets/theme_toggle_button.dart';

enum _ReviewFilter { all, correct, wrong }

/// Halaman pembahasan: jawaban pengguna vs jawaban benar.
///
/// StatefulWidget karena menyimpan filter tampilan (lokal untuk halaman ini).
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.result});

  final QuizResult result;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  _ReviewFilter _filter = _ReviewFilter.all;

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final indexes = [
      for (var i = 0; i < result.questions.length; i++)
        if (switch (_filter) {
          _ReviewFilter.all => true,
          _ReviewFilter.correct => result.questions[i].isCorrect(
            result.answers[i],
          ),
          _ReviewFilter.wrong => !result.questions[i].isCorrect(
            result.answers[i],
          ),
        })
          i,
    ];
    final wide = !context.isMobile || context.isLandscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembahasan'),
        actions: [
          const ThemeToggleButton(),
          SizedBox(width: context.sp(12)),
        ],
      ),
      body: SafeArea(
        child: ResponsiveCenter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: context.sp(8)),
                child: SegmentedButton<_ReviewFilter>(
                  segments: [
                    ButtonSegment(
                      value: _ReviewFilter.all,
                      label: Text('Semua (${result.total})'),
                      icon: const Icon(Icons.list_rounded),
                    ),
                    ButtonSegment(
                      value: _ReviewFilter.correct,
                      label: Text('Benar (${result.correct})'),
                      icon: const Icon(Icons.check_rounded),
                    ),
                    ButtonSegment(
                      value: _ReviewFilter.wrong,
                      label: Text('Salah (${result.total - result.correct})'),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                  selected: {_filter},
                  onSelectionChanged: (s) => setState(() => _filter = s.first),
                ),
              ),
              Expanded(
                child: indexes.isEmpty
                    ? Center(
                        child: Text(
                          'Tidak ada soal pada filter ini',
                          style: TextStyle(fontSize: context.sp(14)),
                        ),
                      )
                    : _buildList(context, indexes, columns: wide ? 2 : 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Daftar pembahasan; pada layar lebar ditampilkan dua kolom.
  Widget _buildList(
    BuildContext context,
    List<int> indexes, {
    required int columns,
  }) {
    final gap = context.sp(14);
    final rowCount = (indexes.length / columns).ceil();

    return ListView.separated(
      padding: EdgeInsets.only(bottom: context.sp(24)),
      itemCount: rowCount,
      separatorBuilder: (_, _) => SizedBox(height: gap),
      itemBuilder: (_, row) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var c = 0; c < columns; c++) ...[
              if (c > 0) SizedBox(width: gap),
              Expanded(
                child: row * columns + c < indexes.length
                    ? FadeSlideIn(
                        key: ValueKey('$_filter-${indexes[row * columns + c]}'),
                        index: row,
                        child: _ReviewItem(
                          result: widget.result,
                          index: indexes[row * columns + c],
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
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({required this.result, required this.index});

  final QuizResult result;
  final int index;

  @override
  Widget build(BuildContext context) {
    final question = result.questions[index];
    final answer = result.answers[index];
    final correct = question.isCorrect(answer);
    final scheme = Theme.of(context).colorScheme;

    OptionState stateOf(int i) {
      if (i == question.correctIndex) return OptionState.correct;
      if (i == answer) return OptionState.wrong;
      return OptionState.disabled;
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.sp(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: context.sp(30),
                  height: context.sp(30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: correct
                        ? AppColors.successGradient
                        : AppColors.errorGradient,
                    borderRadius: BorderRadius.circular(context.sp(10)),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: context.sp(12.5),
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: context.sp(10)),
                Expanded(
                  child: Text(
                    question.text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: context.sp(14.5),
                    ),
                  ),
                ),
              ],
            ),
            if (answer == null)
              Padding(
                padding: EdgeInsets.only(top: context.sp(8)),
                child: Text(
                  'Tidak dijawab',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: scheme.onSurfaceVariant,
                    fontSize: context.sp(12.5),
                  ),
                ),
              ),
            SizedBox(height: context.sp(12)),
            for (var i = 0; i < question.options.length; i++) ...[
              OptionTile(
                index: i,
                text: question.options[i],
                state: stateOf(i),
              ),
              SizedBox(height: context.sp(8)),
            ],
            SizedBox(height: context.sp(4)),
            ExplanationPanel(
              isCorrect: correct,
              explanation: question.explanation,
            ),
          ],
        ),
      ),
    );
  }
}
