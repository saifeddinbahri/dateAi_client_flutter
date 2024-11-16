import 'dart:io';

import 'package:date_ai/utils/screen_size.dart';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSize(context);
    return Scaffold(
      body:
      Column(
        children: [
          Stack(
            children: [
              Image.file(File(imagePath)),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height * 0.05,
                    left: screenSize.width * 0.05
                  ),
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
                      color: Colors.white,
                      size: screenSize.width*0.07,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
