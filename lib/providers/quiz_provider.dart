import 'dart:math';

import 'package:flutter/foundation.dart';

import '../data/dummy/question_bank.dart';
import '../data/models/question.dart';
import '../data/models/quiz_category.dart';
import '../data/models/quiz_result.dart';

/// State global kuis. Disimpan di atas [MaterialApp] sehingga progres jawaban
/// tidak hilang saat layar dirotasi maupun saat berpindah halaman.
class QuizProvider extends ChangeNotifier {
  QuizProvider({Random? random}) : _random = random ?? Random();

  final Random _random;

  String _playerName = '';
  String? _selectedCategoryId;

  QuizCategory? _category;
  List<Question> _questions = const [];
  List<int?> _answers = const [];
  int _currentIndex = 0;
  DateTime? _startedAt;
  bool _inProgress = false;

  QuizResult? _lastResult;
  final List<QuizResult> _history = [];

  // ---------------------------------------------------------------- getters
  String get playerName => _playerName;
  String? get selectedCategoryId => _selectedCategoryId;
  QuizCategory? get selectedCategory => _selectedCategoryId == null
      ? null
      : QuestionBank.byId(_selectedCategoryId!);

  QuizCategory? get category => _category;
  List<Question> get questions => List.unmodifiable(_questions);
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  Question get currentQuestion => _questions[_currentIndex];
  int? get currentAnswer => _answers[_currentIndex];
  int? answerAt(int index) => _answers[index];
  bool isAnswered(int index) => _answers[index] != null;
  bool get isCurrentAnswered => currentAnswer != null;

  bool get inProgress => _inProgress;
  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == _questions.length - 1;
  int get answeredCount => _answers.where((a) => a != null).length;
  bool get allAnswered => answeredCount == _questions.length;
  double get progress =>
      _questions.isEmpty ? 0 : answeredCount / _questions.length;
  int get correctSoFar => [
    for (var i = 0; i < _questions.length; i++)
      if (_questions[i].isCorrect(_answers[i])) 1,
  ].length;

  QuizResult? get lastResult => _lastResult;
  List<QuizResult> get history => List.unmodifiable(_history.reversed);

  /// Peringkat skor terbaik (urut skor, lalu waktu tercepat).
  List<QuizResult> get leaderboard {
    final sorted = [..._history]
      ..sort((a, b) {
        final byScore = b.score.compareTo(a.score);
        return byScore != 0 ? byScore : a.duration.compareTo(b.duration);
      });
    return sorted;
  }

  // ---------------------------------------------------------------- actions
  void setPlayerName(String name) {
    _playerName = name.trim();
    notifyListeners();
  }

  void selectCategory(String id) {
    _selectedCategoryId = id;
    notifyListeners();
  }

  /// Memulai kuis baru: urutan soal & pilihan jawaban diacak.
  void startQuiz(QuizCategory category) {
    _category = category;
    _selectedCategoryId = category.id;
    _questions = (List.of(
      category.questions,
    )..shuffle(_random)).map(_shuffleOptions).toList();
    _answers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
    _startedAt = DateTime.now();
    _inProgress = true;
    notifyListeners();
  }

  void restart() {
    if (_category != null) startQuiz(_category!);
  }

  /// Jawaban dikunci setelah dipilih agar umpan balik benar/salah konsisten.
  void answer(int optionIndex) {
    if (!_inProgress || isCurrentAnswered) return;
    _answers = List.of(_answers)..[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (!isLastQuestion) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previous() {
    if (!isFirstQuestion) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void goTo(int index) {
    if (index >= 0 && index < _questions.length && index != _currentIndex) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  QuizResult finishQuiz() {
    final result = QuizResult(
      playerName: _playerName.isEmpty ? 'Pemain' : _playerName,
      categoryId: _category!.id,
      categoryTitle: _category!.title,
      correct: correctSoFar,
      total: _questions.length,
      duration: DateTime.now().difference(_startedAt ?? DateTime.now()),
      finishedAt: DateTime.now(),
      questions: List.unmodifiable(_questions),
      answers: List.unmodifiable(_answers),
    );
    _lastResult = result;
    _history.add(result);
    _inProgress = false;
    notifyListeners();
    return result;
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  Question _shuffleOptions(Question q) {
    final order = List<int>.generate(q.options.length, (i) => i)
      ..shuffle(_random);
    return Question(
      text: q.text,
      options: [for (final i in order) q.options[i]],
      correctIndex: order.indexOf(q.correctIndex),
      explanation: q.explanation,
    );
  }
}
