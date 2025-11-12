import 'package:flutter/material.dart';
import '../utils/constants.dart';

// Modal dialog that displays the word to remember
class MemoryWordDialog extends StatelessWidget {
  final String word;

  const MemoryWordDialog({
    Key? key,
    required this.word,
  }) : super(key: key);

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
              'Do your best to remember this word:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: GameConstants.buttonColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              word,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: GameConstants.buttonColor,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
