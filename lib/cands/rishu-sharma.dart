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

import 'package:Zpp/cand-views/rishu-sharma-slide.dart';
import 'package:Zpp/main.dart';

class RishuSharma extends StatefulWidget {
  const RishuSharma({Key? key}) : super(key: key);

  @override
  MySettingsState createState() => MySettingsState();
}

class MySettingsState extends State<RishuSharma> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  bool devModeOn = true;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      devModeOn = (prefs.getBool('devModeOn') ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: false,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.dark),
                sized: false,
                child: CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      trailing: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Rishu Sharma',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      previousPageTitle: 'Candidates',
                      automaticallyImplyLeading: true,
                    ),
                    child: ListView(
                        // physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                          ),
                          Row(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Hero(
                                                    tag: 'sus',
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        child: const Image(
                                                            image: AssetImage(
                                                                'assets/sus.jpg'),
                                                            fit:
                                                                BoxFit.cover))),
                                              ],
                                            ))))),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Rishu Sharma',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ]),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Slide()));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Hero(
                                      tag: 'rishu-sharma',
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/rishu-campaign.jpg'),
                                          ))))),
                        ])))));
  }
}
