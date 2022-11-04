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
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rive/rive.dart';
import 'package:vibration/vibration.dart';
import 'package:http/http.dart' as http;

class RandomWord extends StatefulWidget {
  const RandomWord({Key? key, this.darkDynamic, this.lightDynamic})
      : super(key: key);
  final darkDynamic;
  final lightDynamic;

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
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(18), topLeft: Radius.circular(18)),
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
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarContrastEnforced: false,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
                sized: false,
                child: SafeArea(
                    bottom: false,
                    child: Stack(alignment: Alignment.topRight, children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18),
                              topLeft: Radius.circular(18)),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                  color: Colors.white.withOpacity(0.1)))),
                      Column(children: [
                        CustomRefreshIndicator(
                          controller: controller,
                          key: key,
                          onRefresh: () {
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              if (_executeFuture) {
                                setState(() {
                                  futureAlbum = fetchAlbum();
                                });
                              }
                            });
                            Platform.isWindows
                                ? null
                                : Vibration.vibrate(
                                    duration: 10, amplitude: 128);
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
                                  : Vibration.vibrate(
                                      duration: 5, amplitude: 255);
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
                                    return Stack(children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 0.0, 0.0, 0.0),
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(18.0),
                                                      bottomRight:
                                                          Radius.circular(
                                                              18.0)),
                                              child: SizedBox(
                                                  width: double.infinity,
                                                  height: _offsetToArmed *
                                                      controller.value *
                                                      4,
                                                  child:
                                                      const RiveAnimation.asset(
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
                                                  4),
                                          child: child),
                                    ]);
                                  }),
                          child: SizedBox(
                              height: height - 150,
                              child: ListView(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 60),
                                  ),
                                  Center(
                                    child: FutureBuilder<Album>(
                                      future: futureAlbum,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30, right: 30),
                                              child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                      snapshot.data!.word,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 60,
                                                          fontWeight: FontWeight
                                                              .bold))));
                                        }
                                        // By default, show a loading spinner.
                                        return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: LoadingAnimationWidget
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
                                                  snapshot.data!.definition,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  ));
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }

                                            // By default, show a loading spinner.
                                            return const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 50));
                                          },
                                        ),
                                      )),
                                ],
                              )),
                        ),
                      ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Only on',
                                    style: TextStyle(
                                      fontSize: 20,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    left: 40,
                                    right: 40,
                                    bottom: MediaQuery.of(context)
                                            .viewPadding
                                            .bottom +
                                        20),
                                child: SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: CupertinoButton.filled(
                                      onPressed: () {
                                        key.currentState!.refresh(
                                          draggingCurve: Curves.easeOutBack,
                                        );
                                      },
                                      child: const Text('Refresh',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ))),
                          ]),
                      Padding(
                          padding: const EdgeInsets.only(top: 15, right: 15),
                          child: Bounceable(
                              scaleFactor: 0.6,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                      color: const Color.fromARGB(
                                          255, 204, 204, 204),
                                      child: const Icon(Icons.close_rounded,
                                          size: 30,
                                          color: Color.fromARGB(
                                              255, 99, 99, 99)))))),
                    ])))));
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
