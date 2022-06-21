//import 'package:flutter/material.dart';
//import 'dart:html';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'globals.dart';
// import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';
// import 'package:line_icons/line_icons.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
// import 'package:easy_web_view/easy_web_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';
// import 'package:animated_page_transition/animated_page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

var devMode = 0;

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
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
        '/': (BuildContext context) => CupertinoScaffold(body: RefreshHome()),
        '/settings': (BuildContext context) =>
            CupertinoScaffold(body: MySettings()),
      },
    );
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
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));

  MyHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
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
  final _offsetToArmed = 75.0;

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
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle:
              devModeOn == false ? const Text('Dev Home') : const Text('Home'),
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
                    _vibrate();
                  } //else if (change.didChange(
                  //     from: IndicatorState.armed, to: IndicatorState.loading)) {
                  //   _vibrate();
                  // }
                },
                builder: (context, child, controller) => AnimatedBuilder(
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
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(22.0),
                                        bottomRight: Radius.circular(22.0)),
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: _offsetToArmed *
                                            controller.value *
                                            2,
                                        child: const RiveAnimation.asset(
                                          "assets/falling.riv",
                                          fit: BoxFit.cover,
                                        ))))),
                        Transform.translate(
                            offset: Offset(
                                0.0, _offsetToArmed * controller.value * 2),
                            child: child),
                      ]);
                    }),
                child: Material(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ListView(
                            children: [
                              CupertinoListTile(
                                  title: const Text("My Social"),
                                  onTap: () => CupertinoScaffold
                                      .showCupertinoModalBottomSheet(
                                          expand: true,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => MySocial(),
                                          duration: const Duration(
                                              milliseconds: 250))),
                              CupertinoListTile(
                                  title: const Text('Test Text'),
                                  onTap: () => getBoolValuesSF() == false
                                      ? Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: TestText()))
                                      : Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => TestText(),
                                          ))),
                              CupertinoListTile(
                                  title: const Text("Settings"),
                                  onTap: () => CupertinoScaffold
                                      .showCupertinoModalBottomSheet(
                                          expand: true,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => MySettings(),
                                          duration: const Duration(
                                              milliseconds: 250))),
                            ],
                          ))),
                ))));
  }
}

class MySocial extends StatelessWidget {
  MySocial({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: CupertinoPageScaffold(
                navigationBar: const CupertinoNavigationBar(
                  middle: Text('Social Links'),
                  automaticallyImplyLeading: true,
                  previousPageTitle: "Home",
                ),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 130),
                                child: Divider(
                                  height: 10,
                                  thickness: 2,
                                  color: CupertinoTheme.of(context)
                                      .primaryContrastingColor,
                                ))),
                        CupertinoListTile(
                            //leading: Icon(),
                            title: const Text('Friend me on Roblox'),
                            onTap: () => _launchURL(
                                "https://www.roblox.com/users/690475268/profile")),
                        CupertinoListTile(
                            title: const Text('Join my Discord Server'),
                            onTap: () =>
                                _launchURL("https://discord.gg/HSmAerG2VX")),
                        CupertinoListTile(
                            title: const Text('Add me on Snapchat'),
                            onTap: () => _launchURL(
                                "https://www.snapchat.com/add/firebolt_9907?share_id=6bLdC4GNgg8&locale=en-US")),
                        CupertinoListTile(
                            title: const Text('Look at me on Minecraft'),
                            onTap: () => _launchURL(
                                "https://namemc.com/profile/Firebolt_9907.1")),
                        CupertinoListTile(
                            title: const Text('Subscribe to me on YouTube'),
                            onTap: () => _launchURL(
                                "https://www.youtube.com/channel/UChcPleeg20FGQP2v3sz9MDQ")),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: Text(
                              "Swipe down to dismiss",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ui.Color.fromARGB(255, 131, 131, 131)),
                            ))
                      ],
                    )))));
  }
}

class MySettings extends StatelessWidget {
  MySettings({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));
  @override
  var devMode = 0;
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: getBoolValuesSF() == false
              ? const Text('Dev Mode Enabled')
              : const Text('Disabled'),
          previousPageTitle: 'Home',
          automaticallyImplyLeading: true,
        ),
        child:
            ListView(physics: const NeverScrollableScrollPhysics(), children: [
          CupertinoListTile(
              leading: const Icon(CupertinoIcons.wifi_exclamationmark),
              title: const Text('No Internet Connection'),
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DevConfirm(),
                  )))
        ]));
  }
}

class DevConfirm extends StatelessWidget {
  DevConfirm({Key? key}) : super(key: key);
  final _controller = TextEditingController();
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    TextEditingController textController = TextEditingController();
    String displayText = "";
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Slow down there...'),
          automaticallyImplyLeading: true,
          previousPageTitle: "Home",
        ),
        backgroundColor: CupertinoColors.systemBackground,
        child: SafeArea(
            child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("u r going to need a code to do this")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  }
                },
                autofocus: true,
                obscureText: true,
                obscuringCharacter: "ඞ",
                controller: _controller,
              ),
            ),
          ],
        )));
  }
}

class TestText extends StatelessWidget {
  TestText({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return CupertinoPageScaffold(
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
                        style: CupertinoTheme.of(context).textTheme.textStyle)),
          ],
        ));
  }
}

class YourMomJokes extends StatelessWidget {
  YourMomJokes({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('your mom jokes'),
          previousPageTitle: 'Settings',
          automaticallyImplyLeading: true,
        ),
        child: ListView(children: const [
          CupertinoListTile(
            title: Text('ur mom so fat ur dad didnt leave for the milk'),
          ),
          CupertinoListTile(
            title: Text('ur mom 🤣🤢🤣🤢🤢🤣🤣🤣'),
          ),
          CupertinoListTile(
            title: Text('ur mom so stupid she got an award from "jonas 4"'),
          ),
          CupertinoListTile(
            title: Text('ur mom so dumb that u r a mistake'),
          ),
          CupertinoListTile(
            title: Text(
                'ur mom so stupid she thought instagram was a weed delivery service'),
          ),
        ]));
  }
}

class EmbarrasingDate extends StatelessWidget {
  EmbarrasingDate({Key? key}) : super(key: key);
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0));
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return CupertinoPageScaffold(
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
                      style: CupertinoTheme.of(context).textTheme.textStyle))
        ]));
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
