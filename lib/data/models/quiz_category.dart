import 'package:flutter/material.dart';

import 'question.dart';

class QuizCategory {
  const QuizCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.questions,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<Question> questions;
}
