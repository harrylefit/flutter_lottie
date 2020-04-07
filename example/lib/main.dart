import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'page_dragger.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LottieController controller;
  LottieController controller2;
  StreamController<double> newProgressStream;

  _MyAppState() {
    newProgressStream = new StreamController<double>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageDragger(
        stream: this.newProgressStream,
        child: Scaffold(
          body: Center(
            child: Container(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: LottieView.fromFile(
                  filePath: "animations/splash.json",
                  imagesRes: "sss",w
                  autoPlay: true,
                  loop: true,
                  reverse: true,
                  hardwareAcceleratedMode: true,
                  autoFillSize: true,
                  onViewCreated: onViewCreatedFile,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onViewCreated(LottieController controller) {
    this.controller = controller;

    // Listen for when the playback completes
    this.controller.onPlayFinished.listen((bool animationFinished) {
      print("Playback complete. Was Animation Finished? " +
          animationFinished.toString());
    });
  }

  void onViewCreatedFile(LottieController controller) {
    this.controller2 = controller;
    newProgressStream.stream.listen((double progress) {
      this.controller2.setAnimationProgress(progress);
    });
  }

  void dispose() {
    super.dispose();
    newProgressStream.close();
  }
}
