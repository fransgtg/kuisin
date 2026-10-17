import 'question.dart';

class QuizResult {
  const QuizResult({
    required this.playerName,
    required this.categoryId,
    required this.categoryTitle,
    required this.correct,
    required this.total,
    required this.duration,
    required this.finishedAt,
    required this.questions,
    required this.answers,
  });

  final String playerName;
  final String categoryId;
  final String categoryTitle;
  final int correct;
  final int total;
  final Duration duration;
  final DateTime finishedAt;

  /// Salinan soal (sesuai urutan acak) dan jawaban pengguna untuk pembahasan.
  final List<Question> questions;
  final List<int?> answers;

  int get unanswered => answers.where((a) => a == null).length;

  int get wrong => total - correct - unanswered;

  /// Skor 0–100.
  int get score => total == 0 ? 0 : (correct * 100 / total).round();

  String get grade {
    if (score >= 90) return 'A';
    if (score >= 75) return 'B';
    if (score >= 60) return 'C';
    if (score >= 40) return 'D';
    return 'E';
  }

  bool get isPassed => score >= 60;
}
