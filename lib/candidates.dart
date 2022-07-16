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
import 'cands/rishu-sharma.dart';

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

_vibrate() {
  Vibration.vibrate(duration: 10, amplitude: 128);
}

class CandidatesPage extends StatelessWidget {
  CandidatesPage({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
    statusBarBrightness: ui.Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  @override
  var devMode = 0;
  final _offsetToArmed = 75.0;
  Widget build(BuildContext context) {
    // Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: DismissiblePage(
            onDismissed: () {
              _vibrate();
              Navigator.of(context).pop();
            },
            direction: DismissiblePageDismissDirection.down,
            isFullScreen: true,
            maxRadius: 15.0,
            minRadius: 15.0,
            minScale: 0.1,
            child: Scaffold(
                appBar: CupertinoNavigationBar(
                    backgroundColor: Color(0x00000000),
                    border: Border.all(color: Colors.transparent),
                    previousPageTitle: "Home",
                    middle: const Text("Candidates")),
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
                    child: CupertinoPageScaffold(
                        resizeToAvoidBottomInset: false,
                        child: ListView(
                            padding: const EdgeInsets.only(top: 30),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (BuildContext context) =>
                                              const RishuSharma()));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    const Hero(
                                        tag: 'sus',
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    ui.Radius.circular(15.0),
                                                bottomRight:
                                                    ui.Radius.circular(15.0)),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/amogus.jpg'),
                                            ))),
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                                ui.Radius.circular(15.0),
                                            bottomRight:
                                                ui.Radius.circular(15.0)),
                                        child: ClipRRect(
                                            // Clip it cleanly.
                                            child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            color: Colors.grey.withOpacity(0.1),
                                            alignment: Alignment.center,
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Text(
                                                'Rishu Sharma',
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color:
                                                        CupertinoColors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ))),
                                  ],
                                ),
                              ),
                              //bottom padding below
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                              )
                            ]))))));
  }
}
