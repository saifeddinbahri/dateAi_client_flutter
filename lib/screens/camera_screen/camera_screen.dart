import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:date_ai/screens/display_picture_screen/detect_anomaly_screen.dart';
import 'package:date_ai/utils/screen_padding.dart';
import 'package:date_ai/utils/screen_size.dart';
import 'package:date_ai/utils/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../display_picture_screen/display_picture_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  final ImagePicker _picker = ImagePicker();
  bool cameraIsReady = false;
  bool flashIsOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await _cameraController.initialize();
    log(_cameraController.value.aspectRatio.toString());
    setState(() {
      cameraIsReady = true;
    });

  }
  void _takePicture() async {
    try {
      final image = await _cameraController.takePicture();
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetectAnomalyScreen(
            imagePath: image.path,
          ),
        ),
      );
    } catch(e) {
      print(e);
    }
  }

  void _loadImageFromGallery() async {
    try  {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (!mounted) return;
      if (image != null) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetectAnomalyScreen(
              imagePath: image.path,
            ),
          ),
        );
      }
    } catch(e) {
      print(e);
    }
  }

  void _toggleFlash() async {

    if (flashIsOn) {
      _cameraController.setFlashMode(FlashMode.torch);
    } else {
      _cameraController.setFlashMode(FlashMode.off);
    }
    setState(() {
      flashIsOn = !flashIsOn;
    });
}

  @override
  Widget build(BuildContext context) {
    final theme = ThemeHelper(context);
    final screenSize = ScreenSize(context);
    final screenPadding = ScreenPadding(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: screenSize.height,
        width: double.infinity,
        child: cameraIsReady ? Column(
          children: [
            SizedBox(height: screenSize.height * 0.05,),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenPadding.horizontal
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleFlash,
                    child: Icon(
                      flashIsOn ? Icons.flash_on : Icons.flash_off,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02,),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CameraPreview(_cameraController),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: screenSize.height *0.03
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: _takePicture,
                        child: SizedBox(
                          height: screenSize.width * 0.13,
                          width: screenSize.width * 0.13,
                          child: const CircularProgressIndicator(
                            value: 1,
                            color: Colors.white,
                          ),
                        )
                    ),

                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: screenSize.height *0.03,
                    left: screenSize.width * 0.04,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                        onTap: _loadImageFromGallery,
                        child: Icon(
                          Icons.photo_library_outlined,
                          color: Colors.white,
                          size: screenSize.width * 0.13,
                        )
                    ),

                  ),
                ),
            ],
            ),
          ],
        ) : null,
      ),
    );
  }

}
