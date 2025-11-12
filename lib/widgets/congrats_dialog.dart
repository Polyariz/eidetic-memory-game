import 'package:flutter/material.dart';
import '../utils/constants.dart';

// Congratulations modal after successful completion
class CongratsDialog extends StatelessWidget {
  final int score;
  final int guesses;
  final VoidCallback onPlayAgain;

  const CongratsDialog({
    Key? key,
    required this.score,
    required this.guesses,
    required this.onPlayAgain,
  }) : super(key: key);

  String _getFeedbackMessage() {
    if (guesses <= GameConstants.goodGuessThreshold) {
      return "Congratulations! You have a great memory. Keep working on your speed and accuracy.";
    } else {
      return "Next time, try to reduce your guesses. Focusing on specific elements such as contrast or patterns can be helpful. Keep up your practice!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: GameConstants.modalContentColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Great job!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: GameConstants.buttonColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your final score: $score',
              style: const TextStyle(
                fontSize: 18,
                color: GameConstants.buttonColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'How many guesses you made: $guesses',
              style: const TextStyle(
                fontSize: 18,
                color: GameConstants.buttonColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _getFeedbackMessage(),
              style: const TextStyle(
                fontSize: 16,
                color: GameConstants.buttonColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPlayAgain();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: GameConstants.buttonColor,
                foregroundColor: GameConstants.buttonTextColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: const Text(
                'Play again?',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
