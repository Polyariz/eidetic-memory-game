import 'package:flutter/material.dart';
import '../utils/constants.dart';

// Modal dialog shown when wrong word is selected
class TryAgainDialog extends StatelessWidget {
  final VoidCallback onTryAgain;

  const TryAgainDialog({
    Key? key,
    required this.onTryAgain,
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
              'Not Quite!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: GameConstants.buttonColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onTryAgain();
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
                'Try Again!',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
