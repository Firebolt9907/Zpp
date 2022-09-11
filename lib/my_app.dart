import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:state_persistence/state_persistence.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:dynamic_color/dynamic_color.dart';

import 'refresh_home.dart';
import 'settings.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PersistedAppState(
        storage: const JsonFileStorage(),
        child: Container(
            color: Colors.black,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CupertinoApp(
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
                            return const CupertinoScaffold(body: MySettings());
                          } else if (snapshot.hasData) {
                            return const CupertinoScaffold(body: RefreshHome());
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                    '/settings': (BuildContext context) =>
                        const CupertinoScaffold(body: MySettings()),
                  },
                ))));
  }
}
