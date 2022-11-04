import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:Zpp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:vibration/vibration.dart';

class CoinFlip3p extends StatefulWidget {
  const CoinFlip3p({Key? key, this.devModeOn}) : super(key: key);
  final devModeOn;

  @override
  // ignore: no_logic_in_create_state
  CoinFlipState createState() => CoinFlipState(devModeOn);
}

class CoinFlipState extends State<CoinFlip3p> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  // ignore: prefer_typing_uninitialized_variables
  final devModeOn;

  bool var1 = false;
  bool var2 = false;
  bool var3 = false;
  bool win = false;
  bool shown = false;
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
    gesture() async {
      if (var1 == true) {
        if (var2 == true) {
          if (var3 == true) {
            ("tapped");
            setState(() {
              randInt = Random().nextInt(3);
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
            } else {
              setState(() {
                topWin = 3;
                (topWin);
              });
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
        //     var1= false;
        //     var2= false;
        //     var3= false;
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
                child: Stack(children: [
              Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: const CupertinoNavigationBar(
                    middle: Text('Coin Flip',
                        style: TextStyle(color: Colors.white)),
                    automaticallyImplyLeading: true,
                    previousPageTitle: "Home",
                    transitionBetweenRoutes: false,
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
                          GestureDetector(
                              onLongPressDown: ((details) => {
                                    setState(() {
                                      var1 = true;
                                    }),
                                  }),
                              onLongPressStart: ((details) => {
                                    Platform.isMacOS
                                        ? null
                                        : Vibration.vibrate(
                                            duration: 10, amplitude: 128),
                                    setState(() {
                                      var1 = true;
                                    }),
                                    gesture(),
                                  }),
                              onLongPressEnd: ((details) => {
                                    Platform.isMacOS
                                        ? null
                                        : Vibration.vibrate(
                                            duration: 10, amplitude: 128),
                                    setState(() {
                                      var1 = true;
                                    }),
                                    gesture(),
                                  }),
                              onLongPressCancel: () {
                                Platform.isMacOS
                                    ? null
                                    : Vibration.vibrate(
                                        duration: 10, amplitude: 128);
                                setState(() {
                                  var1 = false;
                                });
                                gesture();
                              },
                              child: SizedBox(
                                  width: double.infinity,
                                  height: (height / 3),
                                  child: Hero(
                                      tag: 'top',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          child: Stack(
                                            children: [
                                              Container(
                                                  color:
                                                      const ui.Color.fromARGB(
                                                          149, 47, 48, 84)),
                                              const RotatedBox(
                                                  quarterTurns: 2,
                                                  child: Center(
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30),
                                                          child: Text(
                                                              maxLines: 10,
                                                              'Tap and Hold to Ready Up',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      30))))),
                                              Visibility(
                                                  visible: var1,
                                                  child: Stack(children: [
                                                    Container(
                                                      color: const ui
                                                              .Color.fromARGB(
                                                          255, 7, 69, 255),
                                                    ),
                                                    const RotatedBox(
                                                        quarterTurns: 2,
                                                        child: Center(
                                                            child: Text('Ready',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        30))))
                                                  ])),
                                            ],
                                          ))))),
                          GestureDetector(
                              onLongPressDown: ((details) => {
                                    setState(() {
                                      var2 = true;
                                    }),
                                  }),
                              onLongPressStart: ((details) => {
                                    Platform.isMacOS
                                        ? null
                                        : Vibration.vibrate(
                                            duration: 10, amplitude: 128),
                                    setState(() {
                                      var2 = true;
                                    }),
                                    gesture(),
                                  }),
                              onLongPressEnd: ((details) => {
                                    Platform.isMacOS
                                        ? null
                                        : Vibration.vibrate(
                                            duration: 10, amplitude: 128),
                                    setState(() {
                                      var2 = true;
                                    }),
                                    gesture(),
                                  }),
                              onLongPressCancel: () {
                                Platform.isMacOS
                                    ? null
                                    : Vibration.vibrate(
                                        duration: 10, amplitude: 128);
                                setState(() {
                                  var2 = false;
                                });
                                gesture();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: SizedBox(
                                      width: double.infinity,
                                      height: (height / 3),
                                      child: Hero(
                                          tag: 'middle',
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                      color: const ui
                                                              .Color.fromARGB(
                                                          148, 54, 84, 47)),
                                                  const RotatedBox(
                                                      quarterTurns: 1,
                                                      child: Center(
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30),
                                                              child: Text(
                                                                  maxLines: 10,
                                                                  'Tap and Hold to Ready Up',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          30))))),
                                                  Visibility(
                                                      visible: var2,
                                                      child: Stack(children: [
                                                        Container(
                                                          color: const ui
                                                                  .Color.fromARGB(
                                                              255, 0, 255, 0),
                                                        ),
                                                        const RotatedBox(
                                                            quarterTurns: 3,
                                                            child: Center(
                                                                child: Text(
                                                                    'Ready',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            30))))
                                                      ])),
                                                ],
                                              )))))),
                          GestureDetector(
                              onLongPressDown: ((details) => {
                                    setState(() {
                                      var3 = true;
                                    }),
                                  }),
                              onLongPressStart: ((details) => {
                                    Platform.isMacOS
                                        ? null
                                        : Vibration.vibrate(
                                            duration: 10, amplitude: 128),
                                    setState(() {
                                      var3 = true;
                                    }),
                                    gesture(),
                                  }),
                              onLongPressEnd: ((details) => {
                                    Platform.isMacOS
                                        ? null
                                        : Vibration.vibrate(
                                            duration: 10, amplitude: 128),
                                    setState(() {
                                      var3 = true;
                                    }),
                                    gesture(),
                                  }),
                              onLongPressCancel: () {
                                Platform.isMacOS
                                    ? null
                                    : Vibration.vibrate(
                                        duration: 10, amplitude: 128);
                                setState(() {
                                  var3 = false;
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
                                                          147, 79, 38, 38)),
                                                  const RotatedBox(
                                                      quarterTurns: 4,
                                                      child: Center(
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30),
                                                              child: Text(
                                                                  maxLines: 10,
                                                                  'Tap and Hold to Ready Up',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          30))))),
                                                  Visibility(
                                                      visible: var3,
                                                      child: Stack(children: [
                                                        Container(
                                                            color: const ui
                                                                    .Color.fromARGB(
                                                                255,
                                                                255,
                                                                0,
                                                                0)),
                                                        const Center(
                                                            child: Text('Ready',
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
                          const Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Text(
                                'Have everyone tap and hold a box',
                                textAlign: ui.TextAlign.center,
                                style: TextStyle(
                                    color:
                                        ui.Color.fromARGB(255, 169, 169, 169),
                                    fontSize: 10),
                              )),
                        ],
                      ))),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top,
                      bottom: MediaQuery.of(context).viewPadding.bottom + 15,
                      left: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.only(top: 1.5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Only on',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 7.5),
                                    child: SizedBox(
                                        height: 40,
                                        width: 17.5,
                                        child: ClipRect(
                                            child: Transform.scale(
                                                scale: 1.4,
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/bolt.png'),
                                                    fit: BoxFit.cover))))),
                                Text(
                                  'Zpp',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ])))),
            ]))));
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
                builder: (context) => CoinFlip3p(
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
                                          ? 'top'
                                          : topWin == 2
                                              ? 'middle'
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
                                                    : const ui.Color.fromARGB(
                                                        255, 255, 0, 0),
                                          )))))),
                    )))));
  }
}
