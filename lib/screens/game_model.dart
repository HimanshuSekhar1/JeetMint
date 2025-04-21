class GameModel {
  final String name;
  final int activeUsers;
  final String category;
  final String rules;
  final String howToPlay;
  final String videoUrl; // Can be gif, asset, or network
  final bool isLiked; // For heart icon
  final String playButtonText;

  GameModel({
    required this.name,
    required this.activeUsers,
    required this.category,
    required this.rules,
    required this.howToPlay,
    required this.videoUrl,
    this.isLiked = false,
    this.playButtonText = "Play",
  });
}
