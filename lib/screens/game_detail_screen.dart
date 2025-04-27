import 'package:flutter/material.dart';
import 'game_model.dart';
import 'homescreen_contents.dart';
import 'package:myapp/widgets/custom_appbar.dart';

class GameDetailScreen extends StatefulWidget {
  final GameModel game;

  const GameDetailScreen({super.key, required this.game});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  bool _isSearching = false;

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // Detects taps on empty space
    onTap: () {
      if (_isSearching) {
        _toggleSearch(); // Close search
        FocusScope.of(context).unfocus(); // Dismiss keyboard
      }
    },
    child: Scaffold(
        appBar: CustomAppBar(showBackButton: true, isSearching: _isSearching, toggleSearch: _toggleSearch,),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "🎮    Browse the game",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'widget.game.name',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),

              Text("🔥 ${widget.game.activeUsers} players", style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              const LikeHeart(), // Reusable
              Text("Category: ${widget.game.category}", style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _showPopup(context, "Rules", widget.game.rules),
                    child: const Text("Rules"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _showPopup(context, "How to Play", widget.game.howToPlay),
                    child: const Text("How to Play"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Game Tile with video/gif and play button
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF01011F),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          widget.game.videoUrl,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          // Navigate to game lobby
                        },
                        child: Text(widget.game.playButtonText),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  void _showPopup(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            content: Text(content),
          ),
    );
  }
}
