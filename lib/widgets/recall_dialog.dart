import 'package:flutter/material.dart';
import '../utils/constants.dart';

// Modal dialog for word recall challenge
class RecallDialog extends StatelessWidget {
  final List<String> words;
  final String correctWord;
  final VoidCallback onCorrect;
  final VoidCallback onIncorrect;

  const RecallDialog({
    Key? key,
    required this.words,
    required this.correctWord,
    required this.onCorrect,
    required this.onIncorrect,
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
              'Do you remember your word?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: GameConstants.buttonColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...words.map((word) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (word == correctWord) {
                          onCorrect();
                        } else {
                          onIncorrect();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GameConstants.buttonColor,
                        foregroundColor: GameConstants.buttonTextColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        word,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
