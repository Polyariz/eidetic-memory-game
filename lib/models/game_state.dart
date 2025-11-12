import 'dart:math';
import 'package:flutter/foundation.dart';
import 'tile.dart';
import '../utils/constants.dart';

// Game state management class - handles all game logic
class GameState extends ChangeNotifier {
  List<Tile> tiles = [];
  String? firstGuessName;
  String? secondGuessName;
  int? firstGuessId;
  int? secondGuessId;
  int count = 0;
  int score = 0;
  int guesses = 0;
  String memoryWord = '';
  bool isProcessing = false;

  // Initialize the game with tiles
  void initializeGame() {
    // Create the base tiles array
    final baseTiles = [
      {'name': 'hf1', 'img': 'assets/images/hf_1.jpg'},
      {'name': 'hf2', 'img': 'assets/images/hf_2.jpg'},
      {'name': 'hf3', 'img': 'assets/images/hf_3.jpg'},
      {'name': 'hf4', 'img': 'assets/images/hf_4.jpg'},
      {'name': 'hf5', 'img': 'assets/images/hf_5.jpg'},
      {'name': 'hf6', 'img': 'assets/images/hf_6.jpg'},
      {'name': 'hf7', 'img': 'assets/images/hf_7.jpg'},
      {'name': 'hf8', 'img': 'assets/images/hf_8.jpg'},
    ];

    // Duplicate tiles to create pairs
    tiles = [];
    int idCounter = 0;
    for (var tileData in baseTiles) {
      // First tile
      tiles.add(Tile(
        name: tileData['name']!,
        imagePath: tileData['img']!,
        id: idCounter++,
      ));
      // Second tile (pair)
      tiles.add(Tile(
        name: tileData['name']!,
        imagePath: tileData['img']!,
        id: idCounter++,
      ));
    }

    // Shuffle tiles randomly
    tiles.shuffle(Random());

    // Select random memory word
    memoryWord = GameConstants.wordArray1[
        Random().nextInt(GameConstants.wordArray1.length)];

    // Reset game state
    score = 0;
    guesses = 0;
    count = 0;
    firstGuessName = null;
    secondGuessName = null;
    firstGuessId = null;
    secondGuessId = null;
    isProcessing = false;

    notifyListeners();
  }

  // Handle card selection
  Future<void> selectCard(int index) async {
    if (isProcessing) return;
    if (tiles[index].isMatched) return;
    if (tiles[index].isFlipped) return;
    if (count >= 2) return;

    // Flip the card
    tiles[index] = tiles[index].copyWith(isFlipped: true);
    count++;
    guesses++; // Increment guesses on EVERY card click, matching original behavior

    if (count == 1) {
      // First card selected
      firstGuessName = tiles[index].name;
      firstGuessId = tiles[index].id;
      notifyListeners();
    } else if (count == 2) {
      // Second card selected
      secondGuessName = tiles[index].name;
      secondGuessId = tiles[index].id;
      isProcessing = true;
      notifyListeners();

      // Wait for animation
      await Future.delayed(
          const Duration(milliseconds: GameConstants.delayMilliseconds));

      // Check for match
      if (firstGuessName == secondGuessName && firstGuessId != secondGuessId) {
        // Match found!
        _handleMatch();
      } else {
        // No match, flip cards back
        _resetGuesses();
      }

      isProcessing = false;
    }
  }

  // Handle matching cards
  void _handleMatch() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].isFlipped && !tiles[i].isMatched) {
        tiles[i] = tiles[i].copyWith(isMatched: true);
      }
    }
    score++;
    _resetGuesses();
  }

  // Reset guesses after checking
  void _resetGuesses() {
    firstGuessName = null;
    secondGuessName = null;
    firstGuessId = null;
    secondGuessId = null;
    count = 0;

    // Flip back non-matched cards
    for (int i = 0; i < tiles.length; i++) {
      if (!tiles[i].isMatched && tiles[i].isFlipped) {
        tiles[i] = tiles[i].copyWith(isFlipped: false);
      }
    }

    notifyListeners();
  }

  // Check if all pairs are matched
  bool get allMatched {
    return tiles.where((tile) => tile.isMatched).length == GameConstants.totalCards;
  }

  // Get random words for the recall challenge
  List<String> getRecallWords() {
    final random = Random();
    final word1 = GameConstants.wordArray2[
        random.nextInt(GameConstants.wordArray2.length)];
    final word3 = GameConstants.wordArray3[
        random.nextInt(GameConstants.wordArray3.length)];

    // Return shuffled list with memory word included
    final words = [word1, memoryWord, word3];
    words.shuffle(random);
    return words;
  }

  // Reset game for new round
  void resetGame() {
    initializeGame();
  }
}
