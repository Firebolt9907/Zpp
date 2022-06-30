import 'dart:ui' as ui;
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
import 'package:resize/resize.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'refresh_home.dart';
import 'settings.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Resize(builder: () {
          return CupertinoApp(
            theme: const CupertinoThemeData(
              primaryContrastingColor: CupertinoDynamicColor.withBrightness(
                  color: Colors.black, darkColor: Colors.white),
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  color: CupertinoDynamicColor.withBrightness(
                    color: Color(0xFF000000),
                    darkColor: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => FutureBuilder(
                  future: _fbApp,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('Error: ${snapshot.error.toString()}');
                      return const CupertinoScaffold(body: MySettings());
                    } else if (snapshot.hasData) {
                      return CupertinoScaffold(body: RefreshHome());
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              '/settings': (BuildContext context) =>
                  const CupertinoScaffold(body: MySettings()),
            },
          );
        }));
  }
}
