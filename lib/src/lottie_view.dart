import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'lottie_controller.dart';
import 'package:flutter/foundation.dart';

typedef void LottieViewCreatedCallback(LottieController controller);

class LottieView extends StatefulWidget {
  LottieView.fromURL(
      {@required this.onViewCreated,
      @required this.url,
      Key key,
      this.loop = false,
      this.autoPlay,
      this.reverse,
      this.autoFillSize,
      this.hardwareAcceleratedMode})
      : super(key: key);

  LottieView.fromFile(
      {Key key,
      @required this.onViewCreated,
      @required this.filePath,
      this.loop = false,
      this.autoPlay,
      this.reverse,
      this.imagesRes,
      this.autoFillSize,
      this.hardwareAcceleratedMode})
      : super(key: key);

  final bool loop;
  final bool autoPlay;
  final bool reverse;
  final bool hardwareAcceleratedMode;
  final bool autoFillSize;
  String url;
  String filePath;
  String imagesRes;

  @override
  _LottieViewState createState() => _LottieViewState();

  final LottieViewCreatedCallback onViewCreated;
}

class _LottieViewState extends State<LottieView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'convictiontech/flutter_lottie',
        creationParams: <String, dynamic>{
          "url": widget.url,
          "filePath": widget.filePath,
          "loop": widget.loop,
          "reverse": widget.reverse,
          "autoPlay": widget.autoPlay,
          "imagesRes": widget.imagesRes,
          "hardwareAcceleratedMode": widget.hardwareAcceleratedMode,
          "autoFillSize": widget.autoFillSize
        },
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: onPlatformCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'convictiontech/flutter_lottie',
        creationParams: <String, dynamic>{
          "url": widget.url,
          "filePath": widget.filePath,
          "loop": widget.loop,
          "reverse": widget.reverse,
          "autoPlay": widget.autoPlay,
          "hardwareAcceleratedMode": widget.hardwareAcceleratedMode,
          "autoFillSize": widget.autoFillSize
        },
        creationParamsCodec: StandardMessageCodec(),
        onPlatformViewCreated: onPlatformCreated,
      );
    }

    return new Text(
        '$defaultTargetPlatform is not yet supported by this plugin');
  }

  Future<void> onPlatformCreated(id) async {
    if (widget.onViewCreated == null) {
      return;
    }
    widget.onViewCreated(new LottieController(id));
  }
}
