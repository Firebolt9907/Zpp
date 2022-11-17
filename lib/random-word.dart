import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:Zpp/main.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;

class RandomWord extends StatefulWidget {
  const RandomWord(
      {Key? key, this.darkDynamic, this.lightDynamic, this.topPadding})
      : super(key: key);
  final darkDynamic;
  final lightDynamic;
  final topPadding;

  @override
  State<RandomWord> createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  late Future<Album> futureAlbum;

  bool _executeFuture = true;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  void dispose() {
    Future.delayed(const Duration(milliseconds: 200), () {});
    super.dispose();
  }

  // late RiveAnimationController<dynamic> _controller;
  Future<Album> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('https://fireboltwotd.herokuapp.com/word'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;
    bool visible = true;
    var _offsetToArmed = 90.0;
    final key = GlobalKey<CustomRefreshIndicatorState>();
    bool _startedManually = false;
    final controller = IndicatorController(refreshEnabled: true);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: false,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        sized: false,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 10),
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      height: 5,
                      width: 55))),
          SizedBox(
              height:
                  MediaQuery.of(context).size.height - widget.topPadding - 25,
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18)),
                  child: CupertinoPageScaffold(
                      // navigationBar: CupertinoNavigationBar(
                      //   middle: const Text('Random Word Generator'),
                      //   automaticallyImplyLeading: true,
                      //   transitionBetweenRoutes: false,
                      //   previousPageTitle: "Home",
                      //   backgroundColor: context.isDarkMode == true
                      //       ? widget.darkDynamic?.background ?? Colors.black
                      //       : widget.lightDynamic?.background ?? Colors.white,
                      //   border: Border.all(color: const Color.fromARGB(0, 255, 255, 255)),
                      // ),
                      backgroundColor: Colors.transparent,
                      /*context.isDarkMode == true
                ? widget.darkDynamic?.background ?? Colors.black
                : widget.lightDynamic?.background ?? Colors.white,*/
                      // navigationBar:
                      //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
                      child: SafeArea(
                          bottom: false,
                          child:
                              Stack(alignment: Alignment.topRight, children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(18),
                                    topLeft: Radius.circular(18)),
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 20, sigmaY: 20),
                                    child: Container(
                                        color: Colors.white.withOpacity(0.1)))),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(25, 18, 130, 0),
                                    child: FittedBox(
                                        child: Text("Random Word Generator",
                                            style: TextStyle(
                                                color: context.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight:
                                                    FontWeight.bold))))),
                            Column(children: [
                              CustomRefreshIndicator(
                                controller: controller,
                                key: key,
                                trigger: IndicatorTrigger.trailingEdge,
                                onRefresh: () {
                                  Future.delayed(
                                      const Duration(milliseconds: 200), () {
                                    if (_executeFuture) {
                                      setState(() {
                                        futureAlbum = fetchAlbum();
                                      });
                                    }
                                  });
                                  Platform.isWindows
                                      ? null
                                      : Vibrate.feedback(FeedbackType.impact);
                                  return Future.delayed(
                                      const Duration(milliseconds: 0));
                                },
                                offsetToArmed: _offsetToArmed,
                                onStateChanged: (IndicatorStateChange change) {
                                  if (change.didChange(
                                      from: IndicatorState.dragging,
                                      to: IndicatorState.armed)) {
                                    Platform.isWindows
                                        ? null
                                        : Vibrate.feedback(FeedbackType.impact);
                                  }
                                  //else if (change.didChange(
                                  //     from: IndicatorState.armed, to: IndicatorState.loading)) {
                                  //   _vibrate();
                                  // }
                                },
                                builder: (context, child, controller) =>
                                    AnimatedBuilder(
                                        animation: controller,
                                        child: child,
                                        builder: (context, child) {
                                          return Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.fromLTRB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        18.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        18.0)),
                                                        child: SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                _offsetToArmed *
                                                                    controller
                                                                        .value *
                                                                    4,
                                                            child:
                                                                const RiveAnimation
                                                                    .asset(
                                                              "assets/falling.riv",
                                                              fit: BoxFit.cover,

                                                              // artboard:
                                                              // stateMachines: ['numDrag'],
                                                              // controllers: [_controller],
                                                            )))),
                                                Transform.translate(
                                                    offset: Offset(
                                                        0.0,
                                                        _offsetToArmed *
                                                            controller.value *
                                                            -0.5),
                                                    child: child),
                                              ]);
                                        }),
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        widget.topPadding -
                                        25,
                                    child: Stack(children: [
                                      ListView(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 100),
                                          ),
                                          Center(
                                            child: FutureBuilder<Album>(
                                              future: futureAlbum,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30,
                                                              right: 30),
                                                      child: FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: Text(
                                                              snapshot
                                                                  .data!.word,
                                                              style: TextStyle(
                                                                  color: context
                                                                          .isDarkMode
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontSize: 60,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))));
                                                }
                                                // By default, show a loading spinner.
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 50),
                                                    child:
                                                        LoadingAnimationWidget
                                                            .threeRotatingDots(
                                                      color: Colors.white,
                                                      size: 50,
                                                    ));
                                              },
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 40),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: Center(
                                                child: FutureBuilder<Album>(
                                                  future: futureAlbum,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                          snapshot
                                                              .data!.definition,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: context
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: 25,
                                                          ));
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error} | Please take screenshot and send feedback');
                                                    }

                                                    // By default, show a loading spinner.
                                                    return const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 50));
                                                  },
                                                ),
                                              )),
                                        ],
                                      ),
                                      Opacity(
                                          key: UniqueKey(),
                                          opacity: 1.0 - controller.value,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Only on',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 7.5),
                                                          child: SizedBox(
                                                              height: 40,
                                                              width: 17.5,
                                                              child: ClipRect(
                                                                  child: Transform.scale(
                                                                      scale:
                                                                          1.4,
                                                                      child: Image(
                                                                          image: AssetImage(
                                                                              'assets/bolt.png'),
                                                                          fit: BoxFit
                                                                              .cover))))),
                                                      Text(
                                                        'Zpp',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: context
                                                                  .isDarkMode
                                                              ? Colors.white
                                                              : Colors.black,
                                                        ),
                                                      ),
                                                    ]),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        left: 90,
                                                        right: 90,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .viewPadding
                                                                .bottom +
                                                            20),
                                                    child: SizedBox(
                                                        width: double.infinity,
                                                        height: 60,
                                                        child: Bounceable(
                                                            onTap: () {},
                                                            child:
                                                                CupertinoButton
                                                                    .filled(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                              onPressed: () {
                                                                key.currentState!
                                                                    .refresh(
                                                                  draggingCurve:
                                                                      Curves
                                                                          .easeOutBack,
                                                                );
                                                              },
                                                              child: const Text(
                                                                  'Refresh',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                            )))),
                                              ])),
                                    ])),
                              ),
                            ]),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, right: 15),
                                child: Bounceable(
                                    scaleFactor: 0.6,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(200000),
                                            color: const Color.fromARGB(
                                                    255, 204, 204, 204)
                                                .withOpacity(0.8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: context.isDarkMode ==
                                                        true
                                                    ? const Color.fromARGB(
                                                            255, 65, 65, 65)
                                                        .withOpacity(0.3)
                                                    : const Color.fromARGB(
                                                            255, 204, 204, 204)
                                                        .withOpacity(0.6),
                                                spreadRadius: 10,
                                                blurRadius: 7,
                                                // changes position of shadow
                                              ),
                                            ]),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text("Home",
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 99, 99, 99),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  )),
                                              SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: RotatedBox(
                                                      quarterTurns: 1,
                                                      child: Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          size: 25,
                                                          color: Color.fromARGB(
                                                              255,
                                                              99,
                                                              99,
                                                              99))))
                                            ])))),
                          ])))))
        ]));
  }
}

class Album {
  final String word;
  final String definition;

  const Album({
    required this.word,
    required this.definition,
  });

  factory Album.fromJson(List<dynamic> json) {
    return Album(
      word: json[0]['word'],
      definition: json[0]['definition'],
    );
  }
}
