import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameIntro extends StatefulWidget {
  const GameIntro({super.key});

  @override
  _GameIntroState createState() => _GameIntroState();
}

class _GameIntroState extends State<GameIntro> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://cdn.discordapp.com/attachments/917085960888528930/1002326625146384455/2022_07_28_11_36_02.mp4')
      ..initialize().then((_) {
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratio = height / width;
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: false,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    systemNavigationBarIconBrightness: Brightness.light,
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light),
                sized: false,
                child: Stack(children: [
                  SafeArea(
                      bottom: false,
                      top: ratio <= 2 ? false : true,
                      child: _controller.value.isInitialized
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: AspectRatio(
                                    aspectRatio: 9 / 16,
                                    child: VideoPlayer(_controller),
                                  )))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: AspectRatio(
                                aspectRatio: 9 / 16,
                                child: Image.network(
                                    'https://cdn.discordapp.com/attachments/823961764185505820/1002582506131955722/VideoCapture_20220729-092436.jpg'),
                              ))),
                  Visibility(
                      visible: true,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Do you wish to continue?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Row(children: [
                                SafeArea(
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 2),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: ClipRRect(
                                                    // Clip it cleanly.
                                                    child: BackdropFilter(
                                                        filter: ImageFilter.blur(
                                                            sigmaX: 10,
                                                            sigmaY: 10),
                                                        child: Container(
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.3),
                                                            height: 85,
                                                            width:
                                                                (width / 2) - 2,
                                                            child: const Center(
                                                                child: Text(
                                                                    "No",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            30)))))))))),
                                SafeArea(
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: ClipRRect(
                                                // Clip it cleanly.
                                                child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 10, sigmaY: 10),
                                                    child: Container(
                                                        color: Colors.blue
                                                            .withOpacity(0.3),
                                                        height: 85,
                                                        width: (width / 2) - 2,
                                                        child: const Center(
                                                            child: Text("Yes",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        30))))))))),
                              ]),
                            ],
                          ))),
                  const SafeArea(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: CupertinoNavigationBarBackButton())),
                  const SafeArea(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('The Zombie Apocalypse has started',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))))),
                ]))));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
