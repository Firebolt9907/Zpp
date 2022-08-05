// import 'dart:js';
//import 'package:flutter/material.dart';
//import 'dart:html';
// import 'package:flutter/painting.dart';
//import 'package:flutter/widgets.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';
import 'package:overlay_support/overlay_support.dart';
// import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'my_app.dart';
import 'my_social.dart';
import 'refresh_home.dart';

late List<CameraDescription> _cameras;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'update_channel', // id
  'Update Notifications', // title
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

extension DarkMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

void main() async {
  // imageCache.clear();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  Platform.isMacOS
      ? null
      : Platform.isWindows
          ? null
          : Platform.isLinux
              ? null
              : _cameras = await availableCameras();
  FlutterNativeSplash.remove();
  runApp(OverlaySupport.global(
    child: Phoenix(
      child: MyApp(),
    ),
  ));
}

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<bool> _Developer;

addBoolToSF(second, bool first) async {
  print('wrote to prefs');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(second, first);
}

getBoolValuesSF(second) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("accessed prefs");
  //Return bool
  bool? second = prefs.getBool('devModeOn');
}

_vibrate() {
  Vibration.vibrate(duration: 10, amplitude: 128);
}

class FutureCamera extends StatefulWidget {
  /// Default Constructor
  const FutureCamera({Key? key}) : super(key: key);

  @override
  State<FutureCamera> createState() => _FutureCameraState();
}

class _FutureCameraState extends State<FutureCamera> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    controller = Platform.isIOS
        ? CameraController(_cameras[1], ResolutionPreset.low, enableAudio: true)
        : CameraController(_cameras[1], ResolutionPreset.max,
            enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            const CupertinoAlertDialog(
              content: Text("Camera Access Denied"),
            );
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  bool devModeOn = true;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Platform.isAndroid ? addBoolToSF('devModeOn', false) : null;
    setState(() {
      devModeOn = (prefs.getBool('devModeOn') ?? true);
    });
  }

  @override
  void dispose() {
    devModeOn == false ? null : controller.dispose();
    super.dispose();
  }

  var visibility = true;
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/skull.png'), context);
    precacheImage(const AssetImage('assets/editor.png'), context);
    var size = MediaQuery.of(context).size;
    if (!controller.value.isInitialized) {
      return CupertinoPageScaffold(
          // navigationBar:
          //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark),
              sized: false,
              child: Stack(children: [
                Container(
                    color: Colors.black,
                    height: double.infinity,
                    width: double.infinity),
                Stack(
                  // Platform.isAndroid ? Future.delayed(Duration(seconds: 5)) : null;
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Image(
                              image: AssetImage('assets/wow.png'),
                            ))),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: CupertinoNavigationBarBackButton(
                                // previousPageTitle: "Home",
                                ))),
                    const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Text("Yourself in 200 years",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))),
                  ],
                ),
              ])));
    } else if (visibility == true) {
      return CupertinoPageScaffold(
          // navigationBar:
          //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark),
              sized: false,
              child: Stack(children: [
                Container(
                    color: Colors.black,
                    height: double.infinity,
                    width: double.infinity),
                Stack(
                  // Platform.isAndroid ? Future.delayed(Duration(seconds: 5)) : null;
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ClipRect(
                          child: Transform.scale(
                            scale: 1.16,
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: 1 / controller.value.aspectRatio,
                                child: CameraPreview(controller),
                              ),
                            ),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            visibility = false;
                            devModeOn == false ? null : controller.dispose();
                          });
                        },
                        child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Image(
                              image: AssetImage('assets/wow.png'),
                            ))),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: CupertinoNavigationBarBackButton(
                                // previousPageTitle: "Home",
                                ))),
                    const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Text("Yourself in 200 years",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))),
                  ],
                ),
              ])));
    } else {
      return CupertinoPageScaffold(
          // navigationBar:
          //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark),
              sized: false,
              child: Stack(children: [
                Container(
                    color: Colors.black,
                    height: double.infinity,
                    width: double.infinity),
                Stack(
                  // Platform.isAndroid ? Future.delayed(Duration(seconds: 5)) : null;
                  children: const [
                    Center(
                        child: Image(
                            image: AssetImage('assets/skull.png'),
                            fit: BoxFit.cover)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Image(
                          image: AssetImage('assets/editor.png'),
                          fit: BoxFit.cover),
                    ),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Text("Yourself in 200 years",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: CupertinoNavigationBarBackButton(
                            color: Colors.transparent
                            // previousPageTitle: "Home",
                            )),
                  ],
                ),
              ])));
    }
  }
}
