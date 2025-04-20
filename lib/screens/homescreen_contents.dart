import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreenContents extends StatelessWidget {
  const HomeScreenContents({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "👋 Welcome, Amit",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Available Games",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),

          // Horizontal Game Tile List
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // example number of games
              itemBuilder: (context, index) {
                return _buildGameTile(
                  context,
                  gameName: "Sudoku",
                  description: "Classic logic puzzle",
                  imageUrl: "https://via.placeholder.com/150x100", // Replace with actual asset or network image
                  activeUsers: 123,
                );
              },
            ),
          ),

          const SizedBox(height: 30),
          const Text(
            "Previously Played",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),

          // Placeholder for previous games
          const Text(
            "No games played yet.",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildGameTile(BuildContext context,
      {required String gameName,
      required String description,
      required String imageUrl,
      required int activeUsers}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        children: [
          // Game Image with custom shape
          ClipPath(
            clipper: _PointedBottomClipper(),
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
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text("👁️ $activeUsers",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  // Heart icon
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3477411445.
                      onPressed: () {},
                      icon: const Icon(LineIcons.fire, size: 18, )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// For pointed bottom image clip
class _PointedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 10)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, size.height - 10)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
