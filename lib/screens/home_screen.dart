import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
import 'homescreen_contents.dart';
import 'package:myapp/widgets/custom_appbar.dart';

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

    return GestureDetector(
      behavior: HitTestBehavior.translucent, // Detects taps on empty space
    onTap: () {
      if (_isSearching) {
        _toggleSearch(); // Close search
        FocusScope.of(context).unfocus(); // Dismiss keyboard
      }
    },
    child: Scaffold(
        appBar: CustomAppBar(showBackButton: false, isSearching: _isSearching, toggleSearch: _toggleSearch,),
        body: const HomeScreenContents(),
      )
    );
  }

  // Widget _buildExpandedSearchBox() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12),
  //     child: Container(
  //       height: 40,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 12),
  //       child: Row(
  //         children: [
  //           const Icon(Icons.search, color: Colors.grey),
  //           const SizedBox(width: 8),
  //           Expanded(
  //             child: TextField(
  //               autofocus: true,
  //               decoration: InputDecoration(
  //                 hintText: 'Search',
  //                 hintStyle: TextStyle(
  //                   color: Colors.black.withAlpha((0.4 * 255).toInt()),
  //                 ),
  //                 border: InputBorder.none,
  //               ),
  //               onSubmitted: (value) {
  //                 // implement search logic with database
  //               },
  //             ),
  //           ),
  //           IconButton(
  //             icon: const Icon(Icons.close, color: Colors.grey),
  //             onPressed: _toggleSearch,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
