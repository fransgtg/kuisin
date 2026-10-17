class Question {
  const Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String text;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  bool isCorrect(int? selected) => selected == correctIndex;
}
