import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'homescreen_contents.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false; // Controls search state

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8C8AFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C8AFA),
        elevation: 0,
        titleSpacing: 0,
        title: _isSearching ? _buildExpandedSearchBox() : null,
        leading:
            _isSearching
                ? null
                : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: const Icon(LineIcons.bars, size: 30),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Menu tapped")),
                      );
                    },
                  ),
                ),
        actions:
            _isSearching
                ? []
                : [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Material(
                      color: const Color(0xFF01011F),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        splashColor: Colors.white24,
                        onTap: _toggleSearch,
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Material(
                          color: const Color(0xFF01011F),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            splashColor: Colors.white24,
                            onTap: () {
                              // Handle notification tap
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        // Badge
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 10,
                              minHeight: 10,
                            ),
                            child: const Text(
                              '3', // Replace this with your dynamic notification count
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: const NetworkImage(
                            'https://i.pravatar.cc/300',
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
      ),
      body: const HomeScreenContents(),
    );
  }

  Widget _buildExpandedSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.black.withAlpha((0.4 * 255).toInt()),
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  // implement search logic with database
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: _toggleSearch,
            ),
          ],
        ),
      ),
    );
  }
}
