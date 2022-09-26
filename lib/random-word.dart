import 'dart:convert';

import 'package:Zpp/main.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // late RiveAnimationController<dynamic> _controller;
  Future<Album> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('https://random-words-api.vercel.app/word'));

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
        borderRadius: BorderRadius.circular(10.0),
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Random Word Generator'),
              automaticallyImplyLeading: true,
              transitionBetweenRoutes: false,
              previousPageTitle: "Home",
              backgroundColor: context.isDarkMode == true
                  ? widget.darkDynamic?.background ?? Colors.black
                  : widget.lightDynamic?.background ?? Colors.white,
              border: Border.all(color: const Color.fromARGB(0, 255, 255, 255)),
            ),
            backgroundColor: context.isDarkMode == true
                ? widget.darkDynamic?.background ?? Colors.black
                : widget.lightDynamic?.background ?? Colors.white,
            // navigationBar:
            //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarContrastEnforced: false,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
                sized: false,
                child: SafeArea(
                    child: Column(children: [
                  CustomRefreshIndicator(
                    controller: controller,
                    key: key,
                    reversed: false,
                    onRefresh: () {
                      Future.delayed(const Duration(milliseconds: 200), () {
                        setState(() {
                          futureAlbum = fetchAlbum();
                        });
                      });
                      return Vibration.vibrate(duration: 10, amplitude: 128);
                    },
                    offsetToArmed: _offsetToArmed,
                    onStateChanged: (IndicatorStateChange change) {
                      if (change.didChange(
                          from: IndicatorState.dragging,
                          to: IndicatorState.armed)) {
                        Vibration.vibrate(duration: 5, amplitude: 255);
                      }
                      //else if (change.didChange(
                      //     from: IndicatorState.armed, to: IndicatorState.loading)) {
                      //   _vibrate();
                      // }
                    },
                    builder: (context, child, controller) => AnimatedBuilder(
                        animation: controller,
                        child: child,
                        builder: (context, child) {
                          return Stack(children: <Widget>[
                            Container(
                                color: CupertinoTheme.of(context)
                                    .scaffoldBackgroundColor,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 0.0),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15.0),
                                            bottomRight: Radius.circular(15.0)),
                                        child: SizedBox(
                                            width: double.infinity,
                                            height: _offsetToArmed *
                                                controller.value *
                                                4,
                                            child: const RiveAnimation.asset(
                                              "assets/falling.riv",
                                              fit: BoxFit.cover,

                                              // artboard:
                                              // stateMachines: ['numDrag'],
                                              // controllers: [_controller],
                                            ))))),
                            Transform.translate(
                                offset: Offset(
                                    0.0, _offsetToArmed * controller.value * 4),
                                child: child),
                          ]);
                        }),
                    child: SizedBox(
                        height: height - 140,
                        child: ListView(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 40),
                            ),
                            Center(
                              child: FutureBuilder<Album>(
                                future: futureAlbum,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(snapshot.data!.word,
                                                style: TextStyle(
                                                    color: context.isDarkMode ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 60,
                                                    fontWeight:
                                                        FontWeight.bold))));
                                  }

                                  // By default, show a loading spinner.
                                  return LoadingAnimationWidget
                                      .threeRotatingDots(
                                    color: context.isDarkMode == true
                                        ? Colors.white
                                        : Colors.black,
                                    size: 50,
                                  );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 40),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Center(
                                  child: FutureBuilder<Album>(
                                    future: futureAlbum,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(snapshot.data!.definition,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: context.isDarkMode == true
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 25,
                                            ));
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }

                                      // By default, show a loading spinner.
                                      return const Padding(
                                          padding: EdgeInsets.only(top: 50));
                                    },
                                  ),
                                )),
                          ],
                        )),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: CupertinoButton.filled(
                            onPressed: () {
                              key.currentState!.refresh(
                                draggingCurve: Curves.easeOutBack,
                              );
                            },
                            child: const Text('Refresh',
                                style: TextStyle(color: Colors.white)),
                          ))),
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
