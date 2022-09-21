import 'dart:io';

import 'package:Zpp/main.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:state_persistence/state_persistence.dart';
import 'package:dynamic_color/dynamic_color.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:dynamic_color/dynamic_color.dart';

import 'refresh_home.dart';
import 'settings.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.i}) : super(key: key);
  final i;
  final Future<FirebaseApp>? _fbApp =
      Platform.isWindows ? null : Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PersistedAppState(
        storage: const JsonFileStorage(),
        child: Container(
            color: Colors.black,
            child: Padding(
                padding: i == false
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(bottom: 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: DynamicColorBuilder(builder:
                        (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                      return CupertinoApp(
                        scrollBehavior: const MaterialScrollBehavior(
                          androidOverscrollIndicator:
                              AndroidOverscrollIndicator.stretch,
                        ),
                        theme: const CupertinoThemeData(
                          primaryContrastingColor:
                              CupertinoDynamicColor.withBrightness(
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
                                  ('Error: ${snapshot.error.toString()}');
                                  return const CupertinoScaffold(
                                      body: MySettings());
                                } else if (snapshot.hasData) {
                                  return CupertinoScaffold(
                                      body: RefreshHome(
                                    darkDynamic: darkDynamic,
                                    lightDynamic: lightDynamic,
                                  ));
                                } else if (Platform.isWindows) {
                                  return CupertinoScaffold(
                                      body: RefreshHome(
                                    darkDynamic: darkDynamic,
                                    lightDynamic: lightDynamic,
                                  ));
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                          '/settings': (BuildContext context) =>
                              const CupertinoScaffold(body: MySettings()),
                        },
                      );
                    })))));
  }
}
