import 'dart:io';

import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_helper.dart';

class DetectAnomalyScreen extends StatefulWidget {
  final String imagePath;

  const DetectAnomalyScreen({super.key, required this.imagePath});

  @override
  State<DetectAnomalyScreen> createState() => _DetectAnomalyScreenState();
}

class _DetectAnomalyScreenState extends State<DetectAnomalyScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isButtonVisible = true;
  bool _isArrowWhite = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    // Listen to scroll changes
    _scrollController.addListener(() {
      final isScrollingDown = _scrollController.offset > 1; // Adjust threshold
      if (isScrollingDown != _isArrowWhite) {
        setState(() {
          _isArrowWhite = isScrollingDown;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onDetectAnomalyPressed() {
    setState(() {
      _isButtonVisible = false;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      final screenHeight = MediaQuery.of(context).size.height;
      _scrollController.animateTo(
        _scrollController.offset + screenHeight * 0.4,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    final screenPadding = ScreenPadding(context);
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              return true;
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: _isButtonVisible
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
              slivers: [
                // Sliver for the image
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _ImageHeaderDelegate(
                    imagePath: widget.imagePath,
                    expandedHeight: MediaQuery.of(context).size.height ,
                    collapsedHeight: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),

                // Sliver for the content
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ListTile(
                        title: Text('Detail line ${index + 1}'),
                      );
                    },
                    childCount: 30, // Number of lines in the content
                  ),
                ),
                /*SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenPadding.horizontal,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Scanned on Oct 24, 2024',
                          textAlign: TextAlign.start,
                          style: theme.textStyle.titleLarge,
                        ),
                        Text(
                          'Scanned on Oct 24, 2024',
                          textAlign: TextAlign.start,
                          style: theme.textStyle.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),

          // Back arrow button at the top
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white60.withOpacity(0.3),
                padding: const EdgeInsets.all(8),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: _isArrowWhite ? Colors.white : Colors.black,
                size: MediaQuery.of(context).size.width * 0.07,
              ),
            ),
          ),

          // "Detect Anomaly" button at the bottom
          if (_isButtonVisible)
            Positioned(
              bottom: screenSize.height * 0.01,
              left: screenPadding.horizontal,
              right: screenPadding.horizontal,
              child: ElevatedButton(
                onPressed: _onDetectAnomalyPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Detect Anomaly',
                  style: theme.textStyle.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Custom delegate to handle the image scrolling behavior
class _ImageHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String imagePath;
  final double expandedHeight;
  final double collapsedHeight;

  _ImageHeaderDelegate({
    required this.imagePath,
    required this.expandedHeight,
    required this.collapsedHeight,
  });

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image in the header
        Positioned.fill(
          child: Image.file(
            File(imagePath),
            fit: BoxFit.fitWidth,
          ),
        ),
        // Slight overlay when shrinking
        if (shrinkOffset > 0)
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
