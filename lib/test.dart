import 'dart:convert';

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

class YoMomma extends StatefulWidget {
  const YoMomma({Key? key, this.darkDynamic, this.lightDynamic})
      : super(key: key);
  final darkDynamic;
  final lightDynamic;
  @override
  State<YoMomma> createState() => _YoMommaState();
}

class _YoMommaState extends State<YoMomma> {
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
    final response = await http.get(Uri.parse('https://api.yomomma.info/'));

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
        MediaQuery.of(context).padding.top -
        55;
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
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        sized: false,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 14),
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      height: 5,
                      width: 55))),
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: const Text('Yo Momma'),
                    automaticallyImplyLeading: false,
                    transitionBetweenRoutes: false,
                    trailing: Padding(
                        padding: EdgeInsets.only(top: 12.5),
                        child: ClipRect(
                            child: RotatedBox(
                                quarterTurns: 1,
                                child: CupertinoNavigationBarBackButton()))),
                    previousPageTitle: "My Friends",
                    backgroundColor: context.isDarkMode == true
                        ? widget.darkDynamic?.background ?? Colors.black
                        : widget.lightDynamic?.background ?? Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(0, 255, 255, 255)),
                  ),
                  backgroundColor: context.isDarkMode == true
                      ? widget.darkDynamic?.background ?? Colors.black
                      : widget.lightDynamic?.background ?? Colors.white,
                  // navigationBar:
                  //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
                  child: SafeArea(
                      bottom: false,
                      child: Column(children: [
                        CustomRefreshIndicator(
                          controller: controller,
                          key: key,
                          onRefresh: () => Future.delayed(
                              const Duration(milliseconds: 200), () {
                            setState(() {
                              futureAlbum = fetchAlbum();
                            });
                          }),
                          offsetToArmed: _offsetToArmed,
                          onStateChanged: (IndicatorStateChange change) {
                            if (change.didChange(
                                from: IndicatorState.dragging,
                                to: IndicatorState.armed)) {
                              Vibrate.feedback(FeedbackType.impact);
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
                                      Container(
                                          color: CupertinoTheme.of(context)
                                              .scaffoldBackgroundColor,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 0.0, 0.0),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15.0)),
                                                  child: SizedBox(
                                                      width: double.infinity,
                                                      height: _offsetToArmed *
                                                          controller.value *
                                                          4,
                                                      child: const RiveAnimation
                                                          .asset(
                                                        "assets/falling.riv",
                                                        fit: BoxFit.cover,

                                                        // artboard:
                                                        // stateMachines: ['numDrag'],
                                                        // controllers: [_controller],
                                                      ))))),
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
                              height: height -
                                  MediaQuery.of(context).viewPadding.bottom -
                                  MediaQuery.of(context).viewPadding.top -
                                  kToolbarHeight -
                                  136,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: /*FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: */
                                                  Text(snapshot.data!.joke,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              context.isDarkMode ==
                                                                      true
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                          fontSize: 30,
                                                          fontWeight: FontWeight
                                                              .bold))) /*)*/;
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
                                ],
                              )),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewPadding.bottom),
                            child: Bounceable(
                                onTap: () {},
                                child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      SizedBox(
                                          width: double.infinity,
                                          height: 180,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40),
                                              child: Bounceable(
                                                  onTap: () {
                                                    key.currentState!.refresh(
                                                      draggingCurve:
                                                          Curves.easeOutBack,
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Hero(
                                                          tag: 'rohan',
                                                          child: Image.asset(
                                                            "assets/rohan.jpg",
                                                            fit: BoxFit.cover,
                                                          )))))),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text('Refresh',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25)))
                                    ]))),
                      ]))))
        ]));
  }
}

class Album {
  final String joke;

  const Album({
    required this.joke,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      joke: json['joke'],
    );
  }
}
