import 'package:flutter/material.dart';

// Word arrays from original JavaScript
class GameConstants {
  static const List<String> wordArray1 = [
    "breathe",
    "shoulder",
    "revoke",
    "application",
    "copper",
    "arrest",
    "singer",
    "history",
    "urgency"
  ];

  static const List<String> wordArray2 = [
    "toast",
    "affinity",
    "replace",
    "delicate",
    "intention",
    "speech",
    "fluctuation",
    "congress"
  ];

  static const List<String> wordArray3 = [
    "thesis",
    "faint",
    "tent",
    "unite",
    "explain",
    "fold",
    "extract",
    "theater",
    "apology",
    "cottage"
  ];

  // Colors from original CSS
  static const Color backgroundColor = Color(0xFFFFE1C6);
  static const Color primaryTextColor = Color(0x8009404C); // rgba(9, 64, 76, 0.5)
  static const Color secondaryTextColor = Color(0xCC55777D); // rgba(85, 119, 125, 0.8)
  static const Color buttonColor = Color(0xFF09404C);
  static const Color buttonTextColor = Color(0xFFDCC7AA);
  static const Color cardFrontColor = Color(0xFFDDF4FF);
  static const Color cardBackColor = Color(0xFFFFE1C6);
  static const Color gridBackgroundColor = Color(0xFFDCC7AA);
  static const Color modalOverlayColor = Color(0xB309404C); // rgba(9, 64, 76, 0.7)
  static const Color modalContentColor = Color(0xFFFFEEE0);
  static const Color buttonHoverColor = Color(0xCC6B7A8F); // rgba(107, 122, 143, 0.8)

  // Game settings
  static const int delayMilliseconds = 500;
  static const int wordDisplayMilliseconds = 1000;
  static const int totalPairs = 8;
  static const int totalCards = 16;
  static const int goodGuessThreshold = 25;
}
