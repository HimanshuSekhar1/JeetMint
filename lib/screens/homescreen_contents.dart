import 'package:flutter/material.dart';
import 'game_detail_screen.dart';
import 'game_model.dart';
import 'package:get/get.dart';

class HomeScreenContents extends StatelessWidget {
  const HomeScreenContents({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "👋    Welcome, Himanshu",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Winning at One Place",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 10),

          // Horizontal Game Tile List
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // example number of games
              itemBuilder: (context, index) {
                return _buildGameTile(
                  context,
                  gameName: "Sudoku",
                  description: "Classic logic puzzle",
                  imageUrl:
                      "https://merideewar.com/cdn/shop/products/27_f8af5a8e-59aa-4314-82ff-06029aec418b.png?v=1649319451",
                  activeUsers: 123,
                );
              },
            ),
          ),

          const SizedBox(height: 30),
          const Text(
            "Previously Played",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 10),

          // Placeholder for previous games
          const Text("No games played yet."),
        ],
      ),
    );
  }

  Widget _buildGameTile(
    BuildContext context, {
    required String gameName,
    required String description,
    required String imageUrl,
    required int activeUsers,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => GameDetailScreen(
            game: GameModel(
              name: gameName,
              activeUsers: activeUsers,
              category: "Puzzle", // or pass dynamically
              rules: "Game rules go here...",
              howToPlay: "How to play info goes here...",
              videoUrl: imageUrl, // Replace with actual gif/video url
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF01011F),
          border: Border.all(color: Colors.white30),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: ClipPath(
                clipper: RoundedBottomEdgeClipper(radius: 16),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Eye with superscript
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF01011F),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "👀 $activeUsers",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Heart icon
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 28,
                          height: 28,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF01011F),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(child: LikeHeart()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gameName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// For rounded bottom image clip
class RoundedBottomEdgeClipper extends CustomClipper<Path> {
  final double radius;

  RoundedBottomEdgeClipper({this.radius = 16.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - radius);

    // Bottom left rounded corner
    path.quadraticBezierTo(0, size.height, radius, size.height);

    // Line to bottom right with rounded corner
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - radius,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// For heart icon
class LikeHeart extends StatefulWidget {
  const LikeHeart({super.key});

  @override
  State<LikeHeart> createState() => _LikeHeartState();
}

class _LikeHeartState extends State<LikeHeart> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
      child: Icon(
        Icons.favorite,
        color: isLiked ? Colors.red : Colors.white,
        size: 15,
      ),
    );
  }
}
