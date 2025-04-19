import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDFFA5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEDFFA5),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(LineIcons.bars, size: 24,),
          onPressed: () {
            // Implement drawer open logic
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Menu tapped")),
            );
          },
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 12),
           child: SearchBoxWidget(),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                // Navigate to user profile page
                Navigator.pushNamed(context, '/profile');
              },
              child: SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300', // Replace with user's actual image URL
                  ),
                  backgroundColor: Colors.transparent,
                  // If no image, use child:
                  // child: Text("A", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to JeetMint!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// For tappable search box
class SearchBoxWidget extends StatefulWidget {
  const SearchBoxWidget({super.key});

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      firstChild: _buildSearchIcon(),
      secondChild: _buildSearchBar(),
      crossFadeState:
          _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }

  Widget _buildSearchIcon() {
    return Material(
      color: const Color(0xFF01011F),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          setState(() {
            _isExpanded = true;
          });
        },
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.search, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black.withAlpha((0.4 * 255).toInt())),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                // Handle search
              },
            ),
          ),
        ],
      ),
    );
  }
}

