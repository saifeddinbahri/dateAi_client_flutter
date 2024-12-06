import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AnomalyDescriptionScreen extends StatelessWidget {
  const AnomalyDescriptionScreen({
    super.key,
    required this.imageURL,
    required this.title
  });
  final String imageURL;
  final String title;

  @override
  Widget build(BuildContext context) {
    final screenPadding = ScreenPadding(context);
    final screenSize = ScreenSize(context);
    final theme = ThemeHelper(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
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
            size: screenSize.width * 0.07,
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: theme.textStyle.headlineMedium!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        height: screenSize.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.network(
              imageURL,
              fit: BoxFit.cover,
              height: screenSize.height * 0.5,
              width: screenSize.width ,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loading) {
                if (loading != null) {
                  return Shimmer.fromColors(
                    baseColor: theme.colorScheme.inversePrimary.withOpacity(0.1),
                    highlightColor: theme.colorScheme.inversePrimary!.withOpacity(0.03),
                    child: Container(
                      height: screenSize.height * 0.4,
                      width: screenSize.width,
                      color: Colors.white,
                    ),
                  );
                }
                return child;
              },
            ),
            Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.2),),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: screenPadding.horizontal,
                  right: screenPadding.horizontal,
                  top: screenSize.height * 0.02
                ),
                constraints: BoxConstraints(
                  maxHeight: screenSize.height * 0.55
                ),
                height: screenSize.height * 0.55,
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Description',
                        style: theme.textStyle.titleLarge,
                      ),
                      SizedBox(height: screenSize.height * 0.01,),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: theme.textStyle.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
