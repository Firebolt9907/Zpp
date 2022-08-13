import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:Zpp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class CoinFlip3p extends StatefulWidget {
  const CoinFlip3p({Key? key, this.devModeOn}) : super(key: key);
  final devModeOn;

  @override
  // ignore: no_logic_in_create_state
  CoinFlipState createState() => CoinFlipState(devModeOn);
}

class CoinFlipState extends State<CoinFlip3p> {
  static SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  // ignore: prefer_typing_uninitialized_variables
  final devModeOn;

  bool top = false;
  bool middle = false;
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
    gesture() async {
      if (top == true) {
        if (middle == true) {
          if (bottom == true) {
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
        //     top = false;
        //     middle = false;
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
                            GestureDetector(
                                onLongPressDown: ((details) => {
                                      setState(() {
                                        top = true;
                                      }),
                                    }),
                                onLongPressStart: ((details) => {
                                      Platform.isMacOS
                                          ? null
                                          : Vibration.vibrate(
                                              duration: 10, amplitude: 128),
                                      setState(() {
                                        top = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressEnd: ((details) => {
                                      Platform.isMacOS
                                          ? null
                                          : Vibration.vibrate(
                                              duration: 10, amplitude: 128),
                                      setState(() {
                                        top = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressCancel: () {
                                  Platform.isMacOS
                                      ? null
                                      : Vibration.vibrate(
                                          duration: 10, amplitude: 128);
                                  setState(() {
                                    top = false;
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
                                                Visibility(
                                                    visible: top,
                                                    child: Stack(children: [
                                                      Container(
                                                        color: const ui
                                                                .Color.fromARGB(
                                                            255, 7, 69, 255),
                                                      ),
                                                      const RotatedBox(
                                                          quarterTurns: 2,
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
                                            ))))),
                            GestureDetector(
                                onLongPressDown: ((details) => {
                                      setState(() {
                                        middle = true;
                                      }),
                                    }),
                                onLongPressStart: ((details) => {
                                      Platform.isMacOS
                                          ? null
                                          : Vibration.vibrate(
                                              duration: 10, amplitude: 128),
                                      setState(() {
                                        middle = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressEnd: ((details) => {
                                      Platform.isMacOS
                                          ? null
                                          : Vibration.vibrate(
                                              duration: 10, amplitude: 128),
                                      setState(() {
                                        middle = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressCancel: () {
                                  Platform.isMacOS
                                      ? null
                                      : Vibration.vibrate(
                                          duration: 10, amplitude: 128);
                                  setState(() {
                                    middle = false;
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
                                                    Visibility(
                                                        visible: middle,
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
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              30))))
                                                        ])),
                                                  ],
                                                )))))),
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
                                    padding: const EdgeInsets.only(
                                        top: 7, bottom: 55),
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
                                                    Visibility(
                                                        visible: bottom,
                                                        child: Stack(children: [
                                                          Container(
                                                              color: const ui
                                                                      .Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  0,
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
