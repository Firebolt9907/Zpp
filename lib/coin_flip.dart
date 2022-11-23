import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:overlay_support/overlay_support.dart';

class CoinFlip2p extends StatefulWidget {
  const CoinFlip2p({Key? key, this.devModeOn}) : super(key: key);
  final devModeOn;

  @override
  // ignore: no_logic_in_create_state
  CoinFlipState createState() => CoinFlipState(devModeOn);
}

class CoinFlipState extends State<CoinFlip2p> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: ui.Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  // ignore: prefer_typing_uninitialized_variables
  final devModeOn;

  bool var1 = false;
  bool var2 = false;
  bool win = false;
  bool shown = false;
  bool exited = false;
  var topWin = 0;
  var rng = Random();
  var random = 0;
  var rancount = 0;

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
        MediaQuery.of(context).padding.top;
    gesture() async {
      setState(() {
        while (rancount < 10) {
          random = Random().nextInt(2);
          rancount += 1;
        }
      });
      if (var1 == true) {
        if (var2 == true) {
          ("tapped");
          setState(() {
            randInt = random;
          });
          if (randInt == 0) {
            setState(() {
              topWin = 1;
              (topWin);
            });
          } else {
            setState(() {
              topWin = 2;
              (topWin);
            });
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
            ));
      });
    }
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return OverlaySupport.local(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light),
            sized: false,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CupertinoPageScaffold(
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
                                          var1 = true;
                                        }),
                                      }),
                                  onLongPressStart: ((details) => {
                                        Vibrate.feedback(FeedbackType.impact),
                                        setState(() {
                                          var1 = true;
                                        }),
                                        gesture(),
                                      }),
                                  onLongPressEnd: ((details) => {
                                        Vibrate.feedback(FeedbackType.impact),
                                        setState(() {
                                          var1 = true;
                                        }),
                                        gesture(),
                                      }),
                                  onLongPressCancel: () {
                                    Vibrate.feedback(FeedbackType.impact);
                                    setState(() {
                                      var1 = false;
                                    });
                                    gesture();
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: (height / 2) - 20,
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
                                                      const RotatedBox(
                                                        quarterTurns: 2,
                                                        child: Center(
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            30),
                                                                child: Text(
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
                                                                            30)))),
                                                      ),
                                                      Visibility(
                                                          visible: var1,
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
                                                                quarterTurns: 2,
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
                              Stack(children: [
                                CupertinoNavigationBar(
                                  middle: const Text('Coin Flip',
                                      style: TextStyle(color: Colors.white)),
                                  automaticallyImplyLeading: true,
                                  previousPageTitle: "Home",
                                  transitionBetweenRoutes: false,
                                  border: null,
                                  backgroundColor: Colors.black,
                                  trailing: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, right: 0),
                                      child: Bounceable(
                                          scaleFactor: 0.6,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200000),
                                                  color: const Color.fromARGB(
                                                          255, 204, 204, 204)
                                                      .withOpacity(0.8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  65,
                                                                  65,
                                                                  65)
                                                              .withOpacity(0.3),
                                                      spreadRadius: 10,
                                                      blurRadius: 7,
                                                      // changes position of shadow
                                                    ),
                                                  ]),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: const [
                                                    Text("Home",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 99, 99, 99),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        )),
                                                    SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child: Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            size: 25,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    99,
                                                                    99,
                                                                    99)))
                                                  ])))),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.only(top: 1.5),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Only on',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 7.5),
                                                      child: SizedBox(
                                                          height: 40,
                                                          width: 17.5,
                                                          child: ClipRect(
                                                              child: Transform.scale(
                                                                  scale: 1.4,
                                                                  child: const Image(
                                                                      image: AssetImage(
                                                                          'assets/bolt.png'),
                                                                      fit: BoxFit
                                                                          .cover))))),
                                                  const Text(
                                                    'Zpp',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ])))),
                              ]),
                              GestureDetector(
                                  onLongPressDown: ((details) => {
                                        setState(() {
                                          var2 = true;
                                        }),
                                      }),
                                  onLongPressStart: ((details) => {
                                        Vibrate.feedback(FeedbackType.impact),
                                        setState(() {
                                          var2 = true;
                                        }),
                                        gesture(),
                                      }),
                                  onLongPressEnd: ((details) => {
                                        Vibrate.feedback(FeedbackType.impact),
                                        setState(() {
                                          var2 = true;
                                        }),
                                        gesture(),
                                      }),
                                  onLongPressCancel: () {
                                    Vibrate.feedback(FeedbackType.impact);
                                    setState(() {
                                      var2 = false;
                                    });
                                    gesture();
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: (height / 2) - 20,
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
                                                      const Center(
                                                          child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30),
                                                              child: Text(
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
                                                                          30)))),
                                                      Visibility(
                                                          visible: var2,
                                                          child: Stack(
                                                              children: [
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
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 30)))
                                                              ])),
                                                    ],
                                                  )))))),
                              const Padding(
                                  padding: EdgeInsets.only(top: 7),
                                  child: Text(
                                    'Have everyone tap and hold a box',
                                    textAlign: ui.TextAlign.center,
                                    style: TextStyle(
                                        color: ui.Color.fromARGB(
                                            255, 169, 169, 169),
                                        fontSize: 10),
                                  )),
                            ],
                          ),
                        ))))));
  }
}

class Win extends StatelessWidget {
  final topWin;
  final devModeOn;

  const Win({super.key, required this.topWin, this.devModeOn});

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
                    systemNavigationBarIconBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light),
                sized: false,
                child: Scaffold(
                    backgroundColor: Colors.black,
                    extendBodyBehindAppBar: true,
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: GestureDetector(
                          onTap: () {
                            Vibrate.feedback(FeedbackType.impact);
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => CoinFlip2p(
                                    devModeOn: devModeOn,
                                  ),
                                ));
                          },
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context)
                                              .viewPadding
                                              .top >
                                          MediaQuery.of(context)
                                              .viewPadding
                                              .bottom
                                      ? MediaQuery.of(context).viewPadding.top
                                      : MediaQuery.of(context)
                                          .viewPadding
                                          .bottom),
                              child: Hero(
                                  tag: topWin == 1 ? 'top' : 'bottom',
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(22),
                                      child: Container(
                                        color: topWin == 1
                                            ? const ui.Color.fromARGB(
                                                255, 7, 69, 255)
                                            : const ui.Color.fromARGB(
                                                255, 255, 0, 0),
                                      ))))),
                    )))));
  }
}
