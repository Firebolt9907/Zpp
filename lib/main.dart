// import 'dart:js';
//import 'package:flutter/material.dart';
//import 'dart:html';
// import 'dart:js';
import 'dart:ui' as ui;
import 'dart:ui';
// import 'dart:io';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
// import 'package:line_icons/line_icons.dart';
import 'package:resize/resize.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

var devMode = 0;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
              '/': (BuildContext context) =>
                  CupertinoScaffold(body: RefreshHome()),
              '/settings': (BuildContext context) =>
                  CupertinoScaffold(body: MySettings()),
            },
          );
        }));
  }
}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
late Future<bool> _Developer;

addBoolToSF(bool first) async {
  print('wrote to prefs');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('devModeOn', first);
}

getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("accessed prefs");
  //Return bool
  bool? devModeOn = prefs.getBool('devModeOn');
}

class MyHome extends StatelessWidget {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      null;
    } else {
      await prefs.setBool('seen', true);
      print("first time");
    }
  }

  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);

  MyHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            activeIcon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            activeIcon: Icon(CupertinoIcons.settings_solid),
          ),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: RefreshHome(),
                );
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: MySettings(),
                );
              });
            default:
              return const Text('');
          }
        });
  }
}

var connectivityResult = (Connectivity().checkConnectivity());
_vibrate() {
  Vibration.vibrate(duration: 10, amplitude: 128);
}

class RefreshHome extends StatelessWidget {
  final _offsetToArmed = 90.0;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      null;
    } else {
      await prefs.setBool('seen', true);
      print("first time");
      // CupertinoScaffold.showCupertinoModalBottomSheet(
      //     expand: true,
      //     context: context,
      //     backgroundColor: Colors.transparent,
      //     builder: (context) => MySocial(),
      //     duration: const Duration(milliseconds: 150));
    }
  }

  RefreshHome({Key? key}) : super(key: key);
  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? devModeOn = prefs.getBool('devModeOn');
    return devModeOn;
  }

  @override
  bool devModeOn = true;
  void initState() {
    getAllSavedData();
  }

  getAllSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? devModeOn = prefs.getBool("youKey");
  }

  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    Future checkFirstSeen() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = (prefs.getBool('seen') ?? false);

      if (seen) {
        null;
      } else {
        // await prefs.setBool('seen', true);
        CupertinoScaffold.showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => MySocial(),
            duration: const Duration(milliseconds: 150));
      }
    }

    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
            sized: false,
            child: CupertinoPageScaffold(
                resizeToAvoidBottomInset: false,
                navigationBar: CupertinoNavigationBar(
                  middle: devModeOn == false
                      ? const Text('Dev Home')
                      : const Text('Home'),
                  automaticallyImplyLeading: true,
                ),
                child: SafeArea(
                    child: CustomRefreshIndicator(
                        onRefresh: () => Future.delayed(
                              const Duration(seconds: 1),
                            ),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    bottomLeft:
                                                        Radius.circular(22.0),
                                                    bottomRight:
                                                        Radius.circular(22.0)),
                                                child: SizedBox(
                                                    width: double.infinity,
                                                    height: _offsetToArmed *
                                                        controller.value *
                                                        2,
                                                    child: const RiveAnimation
                                                        .asset(
                                                      "assets/falling.riv",
                                                      fit: BoxFit.cover,
                                                    ))))),
                                    Transform.translate(
                                        offset: Offset(
                                            0.0,
                                            _offsetToArmed *
                                                controller.value *
                                                2),
                                        child: child),
                                  ]);
                                }),
                        child: Material(
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              color: CupertinoTheme.of(context)
                                  .scaffoldBackgroundColor,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22.0),
                                  child: ListView(
                                    children: [
                                      CupertinoListTile(
                                          title: const Text("My Social"),
                                          onTap: () => CupertinoScaffold
                                              .showCupertinoModalBottomSheet(
                                                  expand: true,
                                                  context: context,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (context) =>
                                                      MySocial(),
                                                  duration: const Duration(
                                                      milliseconds: 150))),
                                      CupertinoListTile(
                                          title: const Text('Test Text'),
                                          onTap: () => getBoolValuesSF() ==
                                                  false
                                              ? Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: TestText()))
                                              : Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        TestText(),
                                                  ))),
                                      CupertinoListTile(
                                          title: const Text("Settings"),
                                          onTap: () => Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    MySettings(),
                                              ))),
                                      CupertinoListTile(
                                          //leading: Icon(),
                                          title: const Text('Send Feedback'),
                                          onTap: () async {
                                            final result =
                                                await FlutterPlatformAlert
                                                    .showAlert(
                                              windowTitle: 'r u sure',
                                              text:
                                                  'this will open the email app bc i cant be bothered to add cloud services to my app',
                                              alertStyle:
                                                  AlertButtonStyle.yesNo,
                                            );
                                            result == AlertButton.yesButton
                                                ? _launchURL(
                                                    "mailto:remmeberthisrishu@gmail.com?subject=Feedback on Zpp")
                                                : null;
                                          }),
                                    ],
                                  ))),
                        ))))));
  }
}

class MySocial extends StatelessWidget {
  MySocial({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    Vibration.vibrate(duration: 10, amplitude: 128);
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
            sized: false,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: CupertinoPageScaffold(
                        navigationBar: const CupertinoNavigationBar(
                          middle: Text('Social Links'),
                          automaticallyImplyLeading: true,
                          previousPageTitle: "Home",
                        ),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    CupertinoListTile(
                                        //leading: Icon(),
                                        title:
                                            const Text('Friend me on Roblox'),
                                        onTap: () => _launchURL(
                                            "https://www.roblox.com/users/690475268/profile")),
                                    CupertinoListTile(
                                        title: const Text(
                                            'Join my Discord Server'),
                                        onTap: () => _launchURL(
                                            "https://discord.gg/HSmAerG2VX")),
                                    CupertinoListTile(
                                        title: const Text('Add me on Snapchat'),
                                        onTap: () => _launchURL(
                                            "https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US")),
                                    CupertinoListTile(
                                        title: const Text(
                                            'Look at me on Minecraft'),
                                        onTap: () => _launchURL(
                                            "https://namemc.com/profile/Firebolt_9907.1")),
                                    CupertinoListTile(
                                        title: const Text(
                                            'Subscribe to me on YouTube'),
                                        onTap: () => _launchURL(
                                            "https://www.youtube.com/channel/UChcPleeg20FGQP2v3sz9MDQ")),
                                  ],
                                ))))))));
  }
}

class MySettings extends StatelessWidget {
  MySettings({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  var devMode = 0;
  Widget build(BuildContext context) {
    Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
            sized: false,
            child: CupertinoPageScaffold(
                navigationBar: const CupertinoNavigationBar(
                  middle: Text('Settings'),
                  previousPageTitle: 'Home',
                  automaticallyImplyLeading: true,
                ),
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        AboutUs()));
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(22.0),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      AspectRatio(
                                          aspectRatio: 4 / 5,
                                          child: Hero(
                                              tag: 'sus',
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          22.0),
                                                  child: const Image(
                                                      image: AssetImage(
                                                          'assets/amogus.jpg'),
                                                      fit: BoxFit.cover)))),
                                      ClipRRect(
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
                                              'Credits',
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  color: CupertinoColors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ],
                                  )))),
                    ]))));
  }
}

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
      statusBarBrightness: ui.Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  var devMode = 0;
  final _offsetToArmed = 75.0;
  Widget build(BuildContext context) {
    Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: DismissiblePage(
            onDismissed: () {
              _vibrate();
              Navigator.of(context).pop();
            },
            direction: DismissiblePageDismissDirection.down,
            isFullScreen: true,
            maxRadius: 22.0,
            minRadius: 22.0,
            minScale: 0.1,
            child: Scaffold(
                appBar: CupertinoNavigationBar(
                    backgroundColor: Color(0x00000000),
                    border: Border.all(color: Colors.transparent),
                    previousPageTitle: "Settings",
                    middle: const Text("About Us")),
                extendBodyBehindAppBar: true,
                body: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                        systemStatusBarContrastEnforced: false,
                        systemNavigationBarColor: Colors.transparent,
                        systemNavigationBarDividerColor: Colors.transparent,
                        statusBarColor: ui.Color.fromARGB(0, 0, 0, 0),
                        systemNavigationBarIconBrightness: Brightness.dark,
                        statusBarIconBrightness: Brightness.light),
                    sized: false,
                    child: CupertinoPageScaffold(
                        resizeToAvoidBottomInset: false,
                        child: ListView(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 0),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (BuildContext context) =>
                                              DevConfirm()));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    const Hero(
                                        tag: 'sus',
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    ui.Radius.circular(22.0),
                                                bottomRight:
                                                    ui.Radius.circular(22.0)),
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/amogus.jpg'),
                                            ))),
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft:
                                                ui.Radius.circular(22.0),
                                            bottomRight:
                                                ui.Radius.circular(22.0)),
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
                              const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                          'dedicaded many weeks to breaking Stack Overflow and his CTRL, C, and V keys',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: CupertinoDynamicColor
                                                  .withBrightness(
                                                      color: Colors.black,
                                                      darkColor:
                                                          Colors.white))))),
                            ]))))));
  }
}

class DevConfirm extends StatelessWidget {
  DevConfirm({Key? key}) : super(key: key);
  final _controller = TextEditingController();
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    TextEditingController textController = TextEditingController();
    String displayText = "";
    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: false,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light),
                sized: false,
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text('Slow down there...'),
                      automaticallyImplyLeading: true,
                      previousPageTitle: "Home",
                    ),
                    backgroundColor: CupertinoColors.systemBackground,
                    child: SafeArea(
                        child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 40, right: 40),
                            child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: GestureDetector(
                                    onTap: () async {
                                      await FlutterPlatformAlert.showAlert(
                                        windowTitle: 'u thought',
                                        text: '🤣🤣🤣',
                                        alertStyle: AlertButtonStyle.ok,
                                      );
                                    },
                                    child: Hero(
                                        tag: 'sus',
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            child: const Image(
                                              image:
                                                  AssetImage('assets/sus.jpg'),
                                              fit: BoxFit.fitWidth,
                                            )))))),
                        const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("u r going to need a code to do this")),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: CupertinoTextField(
                            onChanged: (inputValue) {
                              if (inputValue == "devmode9") {
                                Navigator.pop(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.topToBottom,
                                      child: RefreshHome(),
                                    ));
                                addBoolToSF(false);
                                Phoenix.rebirth(context);
                              } else if (inputValue == "urmom") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => YourMomJokes(),
                                    ));
                              } else if (inputValue == "date") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => EmbarrasingDate(),
                                    ));
                              } else if (inputValue == "random") {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: ((context) => RandomPage())));
                              }
                            },
                            autofocus: true,
                            obscureText: true,
                            obscuringCharacter: "ඞ",
                            controller: _controller,
                          ),
                        ),
                      ],
                    ))))));
  }
}

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  var rng = Random();
  int _n = 0;
  Future<void> _ranInt() async {
    print("number generated");
    setState(() {
      print("number setstate");
      var _n = Random().nextInt(100);
      _n++;
      print(_n);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _offsetToArmed = 75.0;

    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Scaffold(
            appBar: const CupertinoNavigationBar(
                middle: Text("random"), previousPageTitle: "About Us"),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    bottomLeft:
                                                        Radius.circular(22.0),
                                                    bottomRight:
                                                        Radius.circular(22.0)),
                                                child: SizedBox(
                                                    width: double.infinity,
                                                    height: _offsetToArmed *
                                                        controller.value *
                                                        2,
                                                    child: const RiveAnimation
                                                        .asset(
                                                      "assets/falling.riv",
                                                      fit: BoxFit.cover,
                                                    ))))),
                                    Transform.translate(
                                        offset: Offset(
                                            0.0,
                                            _offsetToArmed *
                                                controller.value *
                                                2),
                                        child: child),
                                  ]);
                                }),
                        child: CupertinoPageScaffold(
                            child: ListView(
                          children: <Widget>[Text(_n.toString())],
                        )))))));
  }
}

class TestText extends StatelessWidget {
  const TestText({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
            sized: false,
            child: CupertinoPageScaffold(
                navigationBar: const CupertinoNavigationBar(
                  middle: Text('TestText'),
                  previousPageTitle: 'Home',
                  automaticallyImplyLeading: true,
                ),
                child: ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: getBoolValuesSF() == false
                            ? const Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus id felis id euismod. Nunc non dolor malesuada, finibus quam quis, dictum ligula. Donec tincidunt, dui ac varius commodo, eros tortor pellentesque nulla, sit amet porta lacus odio a sem. Vivamus aliquet ligula at molestie congue. Nulla vel dictum turpis. Morbi consectetur ligula non urna faucibus, ut laoreet purus placerat. Morbi rhoncus porta velit et aliquam. Sed pretium, orci id tincidunt vehicula, metus mauris malesuada nunc, eget consectetur erat risus molestie purus. Fusce convallis diam eu tortor rhoncus gravida. Sed id nunc quis augue vulputate facilisis. Praesent gravida luctus maximus.")
                            : Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus id felis id euismod. Nunc non dolor malesuada, finibus quam quis, dictum ligula. Donec tincidunt, dui ac varius commodo, eros tortor pellentesque nulla, sit amet porta lacus odio a sem. Vivamus aliquet ligula at molestie congue. Nulla vel dictum turpis. Morbi consectetur ligula non urna faucibus, ut laoreet purus placerat. Morbi rhoncus porta velit et aliquam. Sed pretium, orci id tincidunt vehicula, metus mauris malesuada nunc, eget consectetur erat risus molestie purus. Fusce convallis diam eu tortor rhoncus gravida. Sed id nunc quis augue vulputate facilisis. Praesent gravida luctus maximus.",
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle)),
                  ],
                ))));
  }
}

class YourMomJokes extends StatelessWidget {
  const YourMomJokes({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemStatusBarContrastEnforced: false,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
            sized: false,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text('your mom jokes'),
                      previousPageTitle: 'Settings',
                      automaticallyImplyLeading: true,
                    ),
                    child: ListView(children: const [
                      CupertinoListTile(
                        title: Text(
                            'ur mom so fat ur dad didnt leave for the milk'),
                      ),
                      CupertinoListTile(
                        title: Text('ur mom 🤣🤢🤣🤢🤢🤣🤣🤣'),
                      ),
                      CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she got an award from "jonas 4"'),
                      ),
                      CupertinoListTile(
                        title: Text('ur mom so dumb that u r a mistake'),
                      ),
                      CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she thought instagram was a weed delivery service'),
                      ),
                    ])))));
  }
}

class EmbarrasingDate extends StatelessWidget {
  const EmbarrasingDate({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark);
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                    systemStatusBarContrastEnforced: true,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarDividerColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark),
                sized: false,
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text('most embarrasing thing on date'),
                      previousPageTitle: 'Settings',
                      automaticallyImplyLeading: true,
                    ),
                    child: ListView(children: [
                      Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: getBoolValuesSF() == false
                              ? const Text(
                                  "Y'all think I'm good enough to get a date 🤣 i dont have a life i spent way too long making stuff like this")
                              : Text(
                                  "Y'all think I'm good enough to get a date 🤣 i dont have a life i spent way too long making stuff like this",
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle))
                    ])))));
  }
}

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}
