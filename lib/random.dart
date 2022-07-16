import 'dart:ui' as ui;
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'dart:io';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  void initState() {
    super.initState();
    _ranInt();
  }

  var rng = Random();
  int randInt = 0;

  void randomInt() {
    setState(() {
      // var randInt = Random().nextInt(100);
      randInt = Random().nextInt(100);
      randInt++;
    });
  }

  Future<void> _ranInt() async {
    randomInt();
    // setState(() {
    //   var randInt = Random().nextInt(100);
    //   randInt++;
    //   print(randInt);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var _offsetToArmed = 90.0;

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemStatusBarContrastEnforced: false,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            sized: false,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text("Random Number Generator"),
                      previousPageTitle: "About Us",
                      border: Border(),
                    ),
                    child: SafeArea(
                        child: CustomRefreshIndicator(
                            onRefresh: _ranInt,
                            offsetToArmed: _offsetToArmed,
                            onStateChanged: (IndicatorStateChange change) {
                              if (change.didChange(
                                  from: IndicatorState.dragging,
                                  to: IndicatorState.armed)) {
                                Vibration.vibrate(duration: 5, amplitude: 255);
                              } else if (change.didChange(
                                  from: IndicatorState.armed,
                                  to: IndicatorState.loading)) {
                                Vibration.vibrate(duration: 10, amplitude: 128);
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
                                                        child:
                                                            const RiveAnimation
                                                                .asset(
                                                          "assets/falling.riv",
                                                          fit: BoxFit.cover,
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
                            child: GestureDetector(
                                onTap: () => _ranInt(),
                                child: CupertinoPageScaffold(
                                    child: ListView(
                                  children: <Widget>[
                                    Center(
                                        child: Text(
                                            randInt == 0
                                                ? 'Pull Down to Generate Number'
                                                : '$randInt',
                                            style: TextStyle(
                                              fontSize: 80,
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            )))
                                  ],
                                )))))))));
  }
}
