import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool isSearching;
  final VoidCallback toggleSearch;

  const CustomAppBar({
    super.key,
    required this.showBackButton,
    required this.isSearching,
    required this.toggleSearch,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // Stack allows overlaying widgets, here used for the AppBar and potential background
      children: [
        // AppBar widget for the top app bar
        AppBar(
          automaticallyImplyLeading: false,
          // If the user is searching show the GestureDetector wrapping the search box in the title
          // otherwise null
          title:
              widget.isSearching
                  ? GestureDetector(
                    onTap: widget.toggleSearch,
                    child: _buildExpandedSearchBox(),
                  )
                  : null,
          backgroundColor: const Color(0xFF8C8AFA),
          elevation: 0,
          titleSpacing: 0,
          leading:
              widget
                      .isSearching // If is searching do not show the leading
                  ? null
                  : widget
                      .showBackButton // If is not searching, check if show the back button
                  ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  )
                  : IconButton(
                    // If is not showing the back button show the menu button
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
          actions:
              widget.isSearching
                  ? []
                  : [
                    // Search button
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Material(
                        color: const Color(0xFF01011F),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          splashColor: Colors.white24,
                          onTap:
                              widget
                                  .toggleSearch, // Toggle the search when the user press the button
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
                      padding: const EdgeInsets.only(
                        right: 12,
                      ), // Notifications button
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
                      padding: const EdgeInsets.only(
                        right: 10,
                      ), // Profile button
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/profile',
                          ); // Navigate to profile when the user press the button
                        },
                        child: const SizedBox(
                          width: 36,
                          height: 36,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/300',
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ], // closing actions list
        ),

        // Fullscreen overlay to catch outside taps
        if (widget.isSearching)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque, // ensures even transparent parts catch taps
              onTap: widget.toggleSearch, // dismiss search when tapped outside
              child: Container(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
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
                                color: Colors.black.withValues(),
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              // Your search logic
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.toggleSearch,
                          child: const Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExpandedSearchBox() {
    return Padding(
      // Search Box with padding
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
                // Search text field
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
              icon: const Icon(Icons.close, color: Colors.grey), // close button
              onPressed: widget.toggleSearch,
            ),
          ],
        ),
      ),
    );
  }
}
