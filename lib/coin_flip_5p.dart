import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:Zpp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class CoinFlip5p extends StatefulWidget {
  const CoinFlip5p({Key? key, this.devModeOn}) : super(key: key);
  final devModeOn;

  @override
  // ignore: no_logic_in_create_state
  CoinFlipState createState() => CoinFlipState(devModeOn);
}

class CoinFlipState extends State<CoinFlip5p> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  // ignore: prefer_typing_uninitialized_variables
  final devModeOn;

  bool topLeft = false;
  bool topRight = false;
  bool middleLeft = false;
  bool middleRight = false;
  bool bottom = false;
  bool win = false;
  var topWin = 0;
  var rng = Random();

  int randInt = 0;
  CoinFlipState(this.devModeOn);
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    gesture() async {
      if (topLeft == true) {
        if (topRight == true) {
          if (middleLeft == true) {
            if (middleRight == true) {
              if (bottom == true) {
                ("tapped");
                setState(() {
                  randInt = Random().nextInt(4);
                });
                if (randInt == 0) {
                  setState(() {
                    topWin = 1;
                    (topWin);
                  });
                } else if (randInt == 1) {
                  setState(() {
                    topWin = 2;
                    (topWin);
                  });
                } else if (randInt == 2) {
                  setState(() {
                    topWin = 3;
                    (topWin);
                  });
                } else {
                  setState(() {
                    topWin = 4;
                    (topWin);
                  });
                }
              }
            }
          }
        }
      }
    }

    if (topWin == 0) {
      null;
    } else {
      Future.delayed(Duration.zero, () async {
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => Win(
                topWin: topWin,
                devModeOn: devModeOn,
              ),
            )); //.then((value) {
        //   setState(() {
        //     top = false;
        //     topRight= false;
        //     bottom = false;
        //     topWin = 0;
        //   });
        // });
      });
    }
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: false,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarContrastEnforced: false,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        sized: false,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CupertinoPageScaffold(
                child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    appBar: const CupertinoNavigationBar(
                      middle: Text('Coin Flip',
                          style: TextStyle(color: Colors.white)),
                      automaticallyImplyLeading: true,
                      previousPageTitle: "Home",
                      transitionBetweenRoutes: true,
                      border: null,
                      backgroundColor: Colors.black,
                    ),
                    backgroundColor: Colors.black,
                    extendBodyBehindAppBar: true,
                    body: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 3),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  topLeft = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  topLeft = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  topLeft = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              topLeft = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'topLeft',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              149, 47, 48, 84)),
                                                      Visibility(
                                                          visible: topLeft,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  69,
                                                                  255),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 3),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  topRight = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  topRight = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  topRight = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              topRight = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'topRight',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              148, 54, 84, 47)),
                                                      Visibility(
                                                          visible: topRight,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  0,
                                                                  255,
                                                                  0),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 3,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                            ]),
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 3),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  middleLeft = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  middleLeft = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  middleLeft = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              middleLeft = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'middleLeft',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              148, 79, 47, 84)),
                                                      Visibility(
                                                          visible: middleLeft,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  210,
                                                                  7,
                                                                  255),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 1,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 7, left: 7),
                                  child: SizedBox(
                                      width: (width / 2) - 18.5,
                                      height: (height / 3),
                                      child: GestureDetector(
                                          onLongPressDown: ((details) => {
                                                setState(() {
                                                  middleRight = true;
                                                }),
                                              }),
                                          onLongPressStart: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  middleRight = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressEnd: ((details) => {
                                                Platform.isMacOS
                                                    ? null
                                                    : Vibration.vibrate(
                                                        duration: 10,
                                                        amplitude: 128),
                                                setState(() {
                                                  middleRight = true;
                                                }),
                                                gesture(),
                                              }),
                                          onLongPressCancel: () {
                                            Platform.isMacOS
                                                ? null
                                                : Vibration.vibrate(
                                                    duration: 10,
                                                    amplitude: 128);
                                            setState(() {
                                              middleRight = false;
                                            });
                                            gesture();
                                          },
                                          child: Hero(
                                              tag: 'middleRight',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              147, 84, 47, 47)),
                                                      Visibility(
                                                          visible: middleRight,
                                                          child:
                                                              Stack(children: [
                                                            Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  0,
                                                                  0),
                                                            ),
                                                            const RotatedBox(
                                                                quarterTurns: 3,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Ready',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30))))
                                                          ])),
                                                    ],
                                                  )))))),
                            ]),
                            GestureDetector(
                                onLongPressDown: ((details) => {
                                      setState(() {
                                        bottom = true;
                                      }),
                                    }),
                                onLongPressStart: ((details) => {
                                      Platform.isMacOS
                                          ? null
                                          : Vibration.vibrate(
                                              duration: 10, amplitude: 128),
                                      setState(() {
                                        bottom = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressEnd: ((details) => {
                                      Platform.isMacOS
                                          ? null
                                          : Vibration.vibrate(
                                              duration: 10, amplitude: 128),
                                      setState(() {
                                        bottom = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressCancel: () {
                                  Platform.isMacOS
                                      ? null
                                      : Vibration.vibrate(
                                          duration: 10, amplitude: 128);
                                  setState(() {
                                    bottom = false;
                                  });
                                  gesture();
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: (height / 3),
                                        child: Hero(
                                            tag: 'bottom',
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                        color: const ui
                                                                .Color.fromARGB(
                                                            146, 79, 61, 38)),
                                                    Visibility(
                                                        visible: bottom,
                                                        child: Stack(children: [
                                                          Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  123,
                                                                  0)),
                                                          const Center(
                                                              child: Text(
                                                                  'Ready',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          30)))
                                                        ])),
                                                  ],
                                                )))))),
                          ],
                        ))))));
  }
}

class Win extends StatelessWidget {
  final topWin;
  final height;
  final devModeOn;

  const Win({super.key, required this.topWin, this.height, this.devModeOn});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;
    return GestureDetector(
        onTap: () {
          Platform.isMacOS == true
              ? null
              : Vibration.vibrate(duration: 10, amplitude: 128);
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => CoinFlip5p(
                  devModeOn: devModeOn,
                ),
              ));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CupertinoPageScaffold(
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                        systemStatusBarContrastEnforced: false,
                        systemNavigationBarColor: Colors.transparent,
                        systemNavigationBarDividerColor: Colors.transparent,
                        systemNavigationBarIconBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light),
                    sized: false,
                    child: Scaffold(
                      backgroundColor: Colors.black,
                      extendBodyBehindAppBar: true,
                      body: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: height,
                                  child: Hero(
                                      tag: topWin == 1
                                          ? 'topLeft'
                                          : topWin == 2
                                              ? 'topRight'
                                              : topWin == 3
                                                  ? 'middleLeft'
                                                  : topWin == 4
                                                      ? 'middleRight'
                                                      : 'bottom',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          child: Container(
                                            color: topWin == 1
                                                ? const ui.Color.fromARGB(
                                                    255, 7, 69, 255)
                                                : topWin == 2
                                                    ? const ui.Color.fromARGB(
                                                        255, 0, 255, 0)
                                                    : topWin == 3
                                                        ? const ui
                                                                .Color.fromARGB(
                                                            255, 210, 7, 255)
                                                        : const ui
                                                                .Color.fromARGB(
                                                            255, 255, 0, 0),
                                          )))))),
                    )))));
  }
}
