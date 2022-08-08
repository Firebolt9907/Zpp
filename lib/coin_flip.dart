import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class CoinFlip extends StatefulWidget {
  const CoinFlip({Key? key, this.devModeOn}) : super(key: key);
  final devModeOn;

  @override
  // ignore: no_logic_in_create_state
  CoinFlipState createState() => CoinFlipState(devModeOn);
}

class CoinFlipState extends State<CoinFlip> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  // ignore: prefer_typing_uninitialized_variables
  final devModeOn;

  bool top = false;
  bool bottom = false;
  bool win = false;
  var topWin = 0;
  var rng = Random();

  int randInt = 0;
  CoinFlipState(this.devModeOn);

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    double height = MediaQuery.of(context).size.height;
    gesture() async {
      if (top == true) {
        if (bottom == true) {
          print("tapped");
          setState(() {
            randInt = Random().nextInt(2);
          });
          if (randInt == 0) {
            setState(() {
              topWin = 1;
              print(topWin);
            });
          } else {
            setState(() {
              topWin = 2;
              print(topWin);
            });
          }
        }
      }
    }

    if (topWin == 0) {
      null;
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Win(
                topWin: topWin,
                height: height,
              ),
            )).then((value) {
          setState(() {
            top = false;
            bottom = false;
            topWin = 0;
          });
        });
      });
    }
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CupertinoPageScaffold(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: false,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light),
                sized: false,
                child: Scaffold(
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
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        top = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressEnd: ((details) => {
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        top = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressCancel: () {
                                  Vibration.vibrate(
                                      duration: 10, amplitude: 128);
                                  setState(() {
                                    top = false;
                                  });
                                  gesture();
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: (height / 2) - 60,
                                        child: Hero(
                                            tag: 'top',
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
                                                        visible: top,
                                                        child: Stack(children: [
                                                          Container(
                                                            color: const ui
                                                                    .Color.fromARGB(
                                                                255,
                                                                7,
                                                                69,
                                                                255),
                                                          ),
                                                          const RotatedBox(
                                                              quarterTurns: 2,
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
                            const CupertinoNavigationBar(
                              middle: Text('Coin Flip',
                                  style: TextStyle(color: Colors.white)),
                              automaticallyImplyLeading: true,
                              previousPageTitle: "Home",
                              transitionBetweenRoutes: true,
                              border: null,
                              backgroundColor: Colors.black,
                            ),
                            GestureDetector(
                                onLongPressDown: ((details) => {
                                      setState(() {
                                        bottom = true;
                                      }),
                                    }),
                                onLongPressStart: ((details) => {
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        bottom = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressEnd: ((details) => {
                                      Vibration.vibrate(
                                          duration: 10, amplitude: 128),
                                      setState(() {
                                        bottom = true;
                                      }),
                                      gesture(),
                                    }),
                                onLongPressCancel: () {
                                  Vibration.vibrate(
                                      duration: 10, amplitude: 128);
                                  setState(() {
                                    bottom = false;
                                  });
                                  gesture();
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: 55),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: (height / 2) - 60,
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

  const Win({super.key, required this.topWin, this.height});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CupertinoPageScaffold(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: false,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light),
                sized: false,
                child: Scaffold(
                    backgroundColor: Colors.black,
                    extendBodyBehindAppBar: true,
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: GestureDetector(
                          onTap: () {
                            Vibration.vibrate(duration: 10, amplitude: 128);
                            Navigator.pop(context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: SizedBox(
                                  width: double.infinity,
                                  height: height - 76,
                                  child: Hero(
                                      tag: topWin == 1 ? 'top' : 'bottom',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          child: Container(
                                            color: topWin == 1
                                                ? const ui.Color.fromARGB(
                                                    255, 7, 69, 255)
                                                : const ui.Color.fromARGB(
                                                    255, 255, 0, 0),
                                          )))))),
                    )))));
  }
}
