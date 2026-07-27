import 'package:flutter/material.dart';

class AppTheme {
  static const Color purple = Color(0xFF6C3FF5);
  static const Color purpleLight = Color(0xFFEDE8FF);
  static const Color purpleMid = Color(0xFFA98BFA);
  static const Color teal = Color(0xFF0EC4A0);
  static const Color tealLight = Color(0xFFD8FBF4);
  static const Color coral = Color(0xFFFF6B6B);
  static const Color coralLight = Color(0xFFFFE8E8);
  static const Color amber = Color(0xFFFFB830);
  static const Color amberLight = Color(0xFFFFF4D6);
  static const Color blue = Color(0xFF3B8BFF);
  static const Color blueLight = Color(0xFFE0EEFF);
  static const Color pink = Color(0xFFFF5EAB);
  static const Color pinkLight = Color(0xFFFFE0F2);
  static const Color green = Color(0xFF34C759);
  static const Color greenLight = Color(0xFFDFFAEB);
  static const Color bg = Color(0xFFF7F5FF);
  static const Color textPrimary = Color(0xFF1A1040);
  static const Color textMuted = Color(0xFF7B6FA0);
  static const Color border = Color(0xFFE8E2FF);

  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: border, width: 1.5),
  );

  static BoxDecoration gradientDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF6C3FF5), Color(0xFF9B5FF5)],
    ),
    borderRadius: BorderRadius.circular(16),
  );

  static TextStyle get label => const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.8,
    color: textMuted,
  );

  static TextStyle get muted => const TextStyle(
    fontSize: 13,
    color: textMuted,
  );
}
