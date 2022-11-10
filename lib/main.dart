// import 'dart:js';
//import 'package:flutter/material.dart';
//import 'dart:html';
// import 'package:flutter/painting.dart';
//import 'package:flutter/widgets.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shake/shake.dart';
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
import 'package:wc_flutter_share/wc_flutter_share.dart';

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

final GlobalKey _key = GlobalKey();
void _share() async {
  RenderRepaintBoundary boundary =
      _key.currentContext!.findRenderObject() as RenderRepaintBoundary;

  ui.Image image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData != null) {
    Uint8List pngBytes = byteData.buffer.asUint8List();
    await WcFlutterShare.share(
        text: 'Download Zpp Now! ',
        sharePopupTitle: 'share',
        fileName: 'ZppShare.png',
        mimeType: 'image/png',
        iPadConfig: IPadConfig(
          originX: 0,
          originY: 0,
          originHeight: 0,
          originWidth: 0,
        ),
        bytesOfFile: Uint8List.fromList(pngBytes));
  }
}

void main() async {
  // imageCache.clear();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  Platform.isWindows ? null : await Firebase.initializeApp();
  Platform.isWindows
      ? null
      : await FirebaseMessaging.instance.setAutoInitEnabled(true);
  Platform.isWindows
      ? null
      : await flutterLocalNotificationsPlugin
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
  ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
    _share();
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Platform.isAndroid ? addBoolToSF('devModeOn', false) : null;
  bool i = (prefs.getBool('devModeOn') ?? true);
  print(i);
  Platform.isWindows ? null : detector.startListening;
  runApp(OverlaySupport.global(
    child: Phoenix(
      child: RepaintBoundary(key: _key, child: MyApp(i: i)),
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
  ('wrote to prefs');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(second, first);
}

getBoolValuesSF(second) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ("accessed prefs");
  //Return bool
  bool? second = prefs.getBool('devModeOn');
}

_vibrate() {
  Vibration.vibrate(duration: 10, amplitude: 128);
}

class FutureCamera extends StatefulWidget {
  /// Default Constructor
  const FutureCamera({Key? key, this.topPadding}) : super(key: key);
  final topPadding;

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
            ('Handle other errors.');
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
    devModeOn == false ? controller.dispose() : null;
    super.dispose();
  }

  var visibility = true;
  bool loaded = false;
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/skull.png'), context);
    precacheImage(const AssetImage('assets/editor.png'), context);
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height - 60;
    if (!controller.value.isInitialized) {
      return Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 10),
            child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    height: 5,
                    width: 55))),
        SizedBox(
            height: MediaQuery.of(context).size.height - widget.topPadding - 25,
            child: CupertinoPageScaffold(
                backgroundColor: Colors.transparent,
                // navigationBar:
                //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                      systemStatusBarContrastEnforced: false,
                      systemNavigationBarContrastEnforced: false,
                      systemNavigationBarColor: Colors.transparent,
                      systemNavigationBarDividerColor: Colors.transparent,
                      systemNavigationBarIconBrightness: Brightness.dark,
                    ),
                    sized: false,
                    child: SafeArea(
                        bottom: false,
                        child: Stack(alignment: Alignment.topRight, children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                  child: Container(
                                      color: Colors.white.withOpacity(0.1)))),
                          Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topLeft: Radius.circular(18.0),
                                      topRight: Radius.circular(18.0)),
                                  child: Container(
                                      height: height,
                                      width: double.infinity,
                                      color: Colors.transparent))),
                          Stack(
                            alignment: Alignment.topRight,
                            // Platform.isAndroid ? Future.delayed(Duration(seconds: 5)) : null;
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const SafeArea(
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Image(
                                            image: AssetImage('assets/wow.png'),
                                          )))),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, right: 15),
                                      child: Bounceable(
                                          scaleFactor: 0.6,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200000),
                                                  color: const Color.fromARGB(
                                                          255, 204, 204, 204)
                                                      .withOpacity(0.8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  65,
                                                                  65,
                                                                  65)
                                                              .withOpacity(0.3),
                                                      spreadRadius: 10,
                                                      blurRadius: 7,
                                                      // changes position of shadow
                                                    ),
                                                  ]),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text("Home",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 99, 99, 99),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        )),
                                                    SizedBox(
                                                        height: 30,
                                                        width: 30,
                                                        child: RotatedBox(
                                                            quarterTurns: 1,
                                                            child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios_rounded,
                                                                size: 25,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        99,
                                                                        99,
                                                                        99))))
                                                  ]))))),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(25, 18, 115, 0),
                                      child: FittedBox(
                                          child: Text(
                                              "See Yourself in 200 years",
                                              style: TextStyle(
                                                  color: context.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.bold))))),
                            ],
                          ),
                        ])))))
      ]);
    } else if (visibility == true) {
      return Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 10),
            child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    height: 5,
                    width: 55))),
        SizedBox(
            height: MediaQuery.of(context).size.height - widget.topPadding - 25,
            child: CupertinoPageScaffold(
                backgroundColor: Colors.transparent,
                // navigationBar:
                //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                      systemStatusBarContrastEnforced: false,
                      systemNavigationBarColor: Colors.transparent,
                      systemNavigationBarDividerColor: Colors.transparent,
                      systemNavigationBarIconBrightness: Brightness.dark,
                    ),
                    sized: false,
                    child: Stack(alignment: Alignment.topRight, children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                  color: Colors.white.withOpacity(0.1)))),
                      Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                  color: Colors.black,
                                  height: double.infinity,
                                  width: double.infinity))),
                      Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Stack(
                            // Platform.isAndroid ? Future.delayed(Duration(seconds: 5)) : null;
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topLeft: Radius.circular(18.0),
                                      topRight: Radius.circular(18.0)),
                                  child: ClipRect(
                                    child: Transform.scale(
                                      scale: (height /
                                              controller
                                                  .value.previewSize!.height) *
                                          1.5,
                                      child: Center(
                                        child: AspectRatio(
                                          aspectRatio:
                                              1 / controller.value.aspectRatio,
                                          child: CameraPreview(controller),
                                        ),
                                      ),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      visibility = false;
                                      devModeOn == false
                                          ? controller.dispose()
                                          : null;
                                      Future.delayed(
                                          Duration(
                                              milliseconds: Platform.isIOS
                                                  ? 2500
                                                  : 750), () {
                                        setState(() {
                                          loaded = true;
                                        });
                                      });
                                    });
                                  },
                                  child: const SafeArea(
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Image(
                                            image: AssetImage('assets/wow.png'),
                                          )))),
                            ],
                          )),
                      // const Padding(
                      //     padding: EdgeInsets.only(top: 15, right: 8),
                      //     child: Align(
                      //         alignment: Alignment.topRight,
                      //         child: Padding(
                      //             padding: EdgeInsets.only(top: 8),
                      //             child: RotatedBox(
                      //                 quarterTurns: 1,
                      //                 child: CupertinoNavigationBarBackButton(
                      //                     // previousPageTitle: "Home",
                      //                     ))))),
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, right: 15),
                              child: Bounceable(
                                  scaleFactor: 0.6,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200000),
                                          color: const Color.fromARGB(
                                                  255, 204, 204, 204)
                                              .withOpacity(0.8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 65, 65, 65)
                                                  .withOpacity(0.3),
                                              spreadRadius: 10,
                                              blurRadius: 7,
                                              // changes position of shadow
                                            ),
                                          ]),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("Home",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 99, 99, 99),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                )),
                                            SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 25,
                                                        color: Color.fromARGB(
                                                            255, 99, 99, 99))))
                                          ]))))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(25, 18, 115, 0),
                              child: FittedBox(
                                  child: Text("See Yourself in 200 years",
                                      style: TextStyle(
                                          color: context.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))))),
                    ]))))
      ]);
    } else {
      return Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 10),
            child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    height: 5,
                    width: 55))),
        SizedBox(
            height: MediaQuery.of(context).size.height - widget.topPadding - 25,
            child: CupertinoPageScaffold(
                backgroundColor: Colors.transparent,
                // navigationBar:
                //     CupertinoNavigationBar(middle: Text("See yourself in 200 years")),
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                      systemStatusBarContrastEnforced: false,
                      systemNavigationBarColor: Colors.transparent,
                      systemNavigationBarDividerColor: Colors.transparent,
                      systemNavigationBarIconBrightness: Brightness.dark,
                    ),
                    sized: false,
                    child: Stack(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Container(
                                  color: Colors.white.withOpacity(0.1)))),
                      Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                  color: Colors.black,
                                  height: double.infinity,
                                  width: double.infinity))),
                      Stack(
                        // Platform.isAndroid ? Future.delayed(Duration(seconds: 5)) : null;
                        children: [
                          Center(
                              child: LoadingAnimationWidget.inkDrop(
                                  color: Colors.white, size: 50)),
                          Visibility(
                              visible: loaded,
                              child: const Center(
                                  child: Image(
                                      image: AssetImage('assets/skull.png'),
                                      fit: BoxFit.cover))),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, right: 15),
                                  child: Bounceable(
                                      scaleFactor: 0.6,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200000),
                                              color: const Color.fromARGB(
                                                      255, 204, 204, 204)
                                                  .withOpacity(0.8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                          255, 65, 65, 65)
                                                      .withOpacity(0.3),
                                                  spreadRadius: 10,
                                                  blurRadius: 7,
                                                  // changes position of shadow
                                                ),
                                              ]),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text("Home",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 99, 99, 99),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    )),
                                                SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: RotatedBox(
                                                        quarterTurns: 1,
                                                        child: Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            size: 25,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    99,
                                                                    99,
                                                                    99))))
                                              ]))))),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(25, 18, 115, 0),
                                  child: FittedBox(
                                      child: Text("See Yourself in 200 years",
                                          style: TextStyle(
                                              color: context.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))))),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: () {
                                  showOverlayNotification((context) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .viewPadding
                                                    .top +
                                                15),
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                150,
                                            height: 50,
                                            child: Stack(children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          112328),
                                                  child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 20,
                                                          sigmaY: 20),
                                                      child: Container(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.1)))),
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "No editing for u Bozo",
                                                                style: TextStyle(
                                                                    color: context.isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20))
                                                          ])))
                                            ])));
                                  }, duration: Duration(milliseconds: 4000));
                                },
                                child: Visibility(
                                    visible: loaded,
                                    child: SizedBox(
                                        width: 60,
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 65),
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/snap-edit.png'),
                                                fit: BoxFit.cover))))),
                          ),
                          Visibility(
                              visible: loaded,
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 40 +
                                              MediaQuery.of(context)
                                                  .viewPadding
                                                  .bottom),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                padding:
                                                    EdgeInsets.only(left: 7.5),
                                                child: SizedBox(
                                                    height: 40,
                                                    width: 17.5,
                                                    child: ClipRect(
                                                        child: Transform.scale(
                                                            scale: 1.4,
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'assets/bolt.png'),
                                                                fit: BoxFit
                                                                    .cover))))),
                                            Text(
                                              'Zpp',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ]))))
                        ],
                      ),
                    ]))))
      ]);
    }
  }
}
