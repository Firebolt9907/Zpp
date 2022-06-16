//import 'dart:io';

//import 'package:flutter/material.dart';
//import 'dart:html';

// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
// import 'globals.dart';
// import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
// import 'package:easy_web_view/easy_web_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';
// import 'package:animated_page_transition/animated_page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

var devMode = 0;

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        textTheme: const CupertinoTextThemeData(
          textStyle: TextStyle(
            color: CupertinoDynamicColor.withBrightness(
              color: const Color(0xFF000000),
              darkColor: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
      home: MyHome(),
    );
  }
}

_devMode() async {
  devMode >= 7 ? addBoolToSF(true) : devMode = devMode + 1;
}

addBoolToSF(var bool) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('devModeOn', bool);
}

getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? devModeOn = prefs.getBool('devModeOn');
  return devModeOn;
}

class MyHome extends StatelessWidget {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      null;
    } else {
      await prefs.setBool('seen', true);
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => YourMomJokes(),
          ));
    }
  }

  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(1, 1, 1, 1));

  MyHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.home),
          activeIcon: Icon(CupertinoIcons.home),
        ),
        const BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.settings),
          activeIcon: Icon(CupertinoIcons.settings_solid),
        ),
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ActualHome(),
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
      },
    );
  }
}

var connectivityResult = (Connectivity().checkConnectivity());

class ActualHome extends StatelessWidget {
  ActualHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: const Text('Home'),
          automaticallyImplyLeading: true,
        ),
        child: Container(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: ListView(
                  children: [
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
                    connectivityResult == ConnectivityResult.mobile
                        ? const CupertinoListTile(
                            title: Text('No Wifi Connection'))
                        : const CupertinoListTile(
                            title: const Text('Wifi Connected')),
                    CupertinoListTile(
                        title: Text('your mom jokes'),
                        onTap: () => getBoolValuesSF() ?? true
                            ? Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: YourMomJokes()))
                            : Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => YourMomJokes(),
                                ))),
                    CupertinoListTile(
                        title: const Text('Test Text'),
                        onTap: () => getBoolValuesSF() == true
                            ? Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: TestText()))
                            : Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => TestText(),
                                ))),
                    CupertinoListTile(
                        title: Text('Most Embarrasing Moment on a Date'),
                        onTap: () => getBoolValuesSF() == true
                            ? Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: EmbarrasingDate()))
                            : Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => EmbarrasingDate(),
                                ))),
                  ],
                ))));
  }
}

class MySettings extends StatelessWidget {
  MySettings({Key? key}) : super(key: key);

  @override
  var devMode = 0;
  Widget build(BuildContext context) {
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: getBoolValuesSF() == true
              ? Text('Dev Mode Enabled')
              : Text('Settings'),
          previousPageTitle: 'Home',
          automaticallyImplyLeading: true,
        ),
        child: ListView(children: [
          CupertinoListTile(
            leading: const Icon(CupertinoIcons.wifi_exclamationmark),
            title: const Text('No Internet Connection'),
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight, child: DevConfirm())),
          ),
        ]));
  }
}

class DevConfirm extends StatelessWidget {
  DevConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Slow Down There...'),
            ),
            body: Column(
              children: [
                Text("You're going to need a code to do this ☠️"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter the Access Code',
                    ),
                  ),
                ),
              ],
            )));
  }
}

class TestText extends StatelessWidget {
  TestText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: const Text('TestText'),
          previousPageTitle: 'Home',
          automaticallyImplyLeading: true,
        ),
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(25.0),
                child: getBoolValuesSF() == true
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

  @override
  Widget build(BuildContext context) {
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: const Text('your mom jokes'),
          previousPageTitle: 'Home',
          automaticallyImplyLeading: true,
        ),
        child: ListView(children: [
          const CupertinoListTile(
            title: const Text('ur mom so fat ur dad didnt leave for the milk'),
          ),
          const CupertinoListTile(
            title: const Text('ur mom 🤣🤢🤣🤢🤢🤣🤣🤣'),
          ),
          const CupertinoListTile(
            title: Text('ur mom so stupid she got an award from "jonas 4"'),
          ),
          const CupertinoListTile(
            title: Text('ur mom so dumb that u r a mistake'),
          ),
          const CupertinoListTile(
            title: const Text(
                'ur mom so stupid she thought instagram was a weed delivery service'),
          ),
        ]));
  }
}

class EmbarrasingDate extends StatelessWidget {
  EmbarrasingDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: const Text('most embarrasing thing on date'),
          previousPageTitle: 'Home',
          automaticallyImplyLeading: true,
        ),
        child: ListView(children: [
          Padding(
              padding: const EdgeInsets.all(25.0),
              child: getBoolValuesSF() ?? true
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
