// Tile model class - represents a single game card
class Tile {
  final String name;
  final String imagePath;
  bool isFlipped;
  bool isMatched;
  final int id;

  Tile({
    required this.name,
    required this.imagePath,
    this.isFlipped = false,
    this.isMatched = false,
    required this.id,
  });

  // Create a copy of the tile with updated properties
  Tile copyWith({
    String? name,
    String? imagePath,
    bool? isFlipped,
    bool? isMatched,
    int? id,
  }) {
    return Tile(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'Tile(name: $name, id: $id, isFlipped: $isFlipped, isMatched: $isMatched)';
  }
}
