import 'dart:io';

import 'package:date_ai/services/scan_image_service.dart';
import 'package:date_ai/utils/api/api_response.dart';
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
  final _scanImageService = ScanImageService();
  bool _loading = false;
  ApiResponse? _scanRes;

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

  void _onDetectAnomalyPressed() async{
    setState(() {
      _isButtonVisible = false;
      _loading = true;
    });
    final screenHeight = MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      _scrollController.offset + screenHeight * 0.4,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    var res = await _scanImageService.execute(widget.imagePath);
    _loading = false;
    _scanRes = res;
    setState(() {
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
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: screenSize.height * 0.3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenPadding.horizontal,
                      ),
                      child: _loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.primary,
                              ),
                            )
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: screenSize.height * 0.02,),
                          Text(
                            _scanRes != null
                                ? _scanRes!.data == null
                                  ? _scanRes!.error
                                  : _scanRes!.data['disease'] == null
                                    ? 'Healthy'
                                    : _scanRes!.data['disease']['name']
                                : 'Something went wrong',
                            textAlign: TextAlign.center,
                            style: theme.textStyle.headlineMedium
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Back arrow button at the top
          Positioned(
            top: 30,
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
              bottom: 0,
              left: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: _onDetectAnomalyPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.02,
                  ),
                  shape: const RoundedRectangleBorder(),
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

List<Widget> _detail(BuildContext context, String title, String body) {
  final theme = ThemeHelper(context);
  final screenSize = ScreenSize(context);

  return [
    Text(
      title,
      textAlign: TextAlign.start,
      style: theme.textStyle.titleMedium,
    ),
    Text(
      body,
      textAlign: TextAlign.start,
      style: theme.textStyle.bodyMedium,
    ),
    const Divider(),
    SizedBox(height: screenSize.height * 0.015,)
  ];
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
