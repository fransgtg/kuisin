import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opsibenar/app.dart';
import 'package:opsibenar/data/dummy/question_bank.dart';
import 'package:opsibenar/providers/quiz_provider.dart';
import 'package:opsibenar/widgets/option_tile.dart';

void main() {
  group('QuizProvider', () {
    test('menghitung skor dan menyimpan riwayat', () {
      final quiz = QuizProvider(random: Random(1))
        ..setPlayerName('Budi')
        ..startQuiz(QuestionBank.categories.first);

      for (var i = 0; i < quiz.totalQuestions; i++) {
        quiz.goTo(i);
        // Jawab benar hanya soal genap.
        final q = quiz.currentQuestion;
        quiz.answer(i.isEven ? q.correctIndex : (q.correctIndex + 1) % 4);
      }

      final result = quiz.finishQuiz();
      expect(result.playerName, 'Budi');
      expect(result.correct, quiz.totalQuestions ~/ 2);
      expect(result.score, 50);
      expect(quiz.history, hasLength(1));
      expect(quiz.inProgress, isFalse);
    });

    test('jawaban terkunci setelah dipilih', () {
      final quiz = QuizProvider()..startQuiz(QuestionBank.categories.first);
      quiz.answer(0);
      quiz.answer(1);
      expect(quiz.currentAnswer, 0);
    });

    test('acak pilihan tetap menjaga jawaban benar', () {
      final quiz = QuizProvider(random: Random(7))
        ..startQuiz(QuestionBank.categories.first);
      final original = QuestionBank.categories.first.questions;
      for (final q in quiz.questions) {
        final source = original.firstWhere((o) => o.text == q.text);
        expect(q.options[q.correctIndex], source.options[source.correctIndex]);
      }
    });
  });

  testWidgets('progres jawaban tidak hilang saat layar dirotasi', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(390, 844)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const KuisinApp());
    await tester.enterText(find.byType(TextFormField), 'Rani');
    await tester.ensureVisible(find.text('Teknologi'));
    await tester.tap(find.text('Teknologi'));
    await tester.ensureVisible(find.text('Mulai Kuis'));
    await tester.tap(find.text('Mulai Kuis'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(OptionTile).first);
    await tester.pumpAndSettle();
    expect(find.textContaining('1 terjawab'), findsOneWidget);

    // Rotasi ke landscape.
    tester.view.physicalSize = const Size(844, 390);
    await tester.pumpAndSettle();
    expect(find.textContaining('1 terjawab'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });

  for (final size in const [Size(390, 844), Size(844, 390), Size(1280, 800)]) {
    testWidgets('alur halaman awal → kuis pada layar $size', (tester) async {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await _startFlow(tester);
    });
  }
}

Future<void> _startFlow(WidgetTester tester) async {
  {
    await tester.pumpWidget(const KuisinApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Mulai Kuis'));
    await tester.tap(find.text('Mulai Kuis'));
    await tester.pump();
    expect(find.text('Nama tidak boleh kosong'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Sari');
    await tester.ensureVisible(find.text('Sains'));
    await tester.tap(find.text('Sains'));
    await tester.pump();
    await tester.ensureVisible(find.text('Mulai Kuis'));
    await tester.tap(find.text('Mulai Kuis'));
    await tester.pumpAndSettle();

    expect(find.text('Pertanyaan 1'), findsOneWidget);

    // Jawab semua soal lalu selesaikan.
    for (var i = 0; i < 8; i++) {
      await tester.tap(find.byType(OptionTile).first);
      await tester.pumpAndSettle();
      final next = find.text(i == 7 ? 'Selesai' : 'Berikutnya');
      await tester.tap(next);
      await tester.pumpAndSettle();
    }
    expect(find.text('Hasil Kuis'), findsOneWidget);

    await tester.ensureVisible(find.text('Lihat Pembahasan'));
    await tester.tap(find.text('Lihat Pembahasan'));
    await tester.pumpAndSettle();
    expect(find.text('Pembahasan'), findsOneWidget);
  }
}
