// import 'dart:js';
//import 'package:flutter/material.dart';
//import 'dart:html';
// import 'package:flutter/painting.dart';
//import 'package:flutter/widgets.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'my_app.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'update_channel', // id
  'Update Notifications', // title
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

extension DarkMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
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

// class MyHome extends StatelessWidget {
//   Future checkFirstSeen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool seen = (prefs.getBool('seen') ?? false);
//     if (seen) {
//       null;
//     } else {
//       await prefs.setBool('seen', true);
//       print("first time");
//     }
//   }
//   static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
//       systemStatusBarContrastEnforced: false,
//       systemNavigationBarColor: Colors.transparent,
//       systemNavigationBarDividerColor: Colors.transparent,
//       statusBarColor: Colors.transparent,
//       systemNavigationBarIconBrightness: Brightness.dark,
//       statusBarIconBrightness: Brightness.dark);
//   MyHome({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
//     //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
//     return CupertinoTabScaffold(
//         tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.home),
//             activeIcon: Icon(CupertinoIcons.home),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.settings),
//             activeIcon: Icon(CupertinoIcons.settings_solid),
//           ),
//         ]),
//         tabBuilder: (context, index) {
//           switch (index) {
//             case 0:
//               return CupertinoTabView(builder: (context) {
//                 return CupertinoPageScaffold(
//                   child: RefreshHome(),
//                 );
//               });
//             case 1:
//               return CupertinoTabView(builder: (context) {
//                 return const CupertinoPageScaffold(
//                   child: MySettings(),
//                 );
//               });
//             default:
//               return const Text('');
//           }
//         });
//   }
// }

var connectivityResult = (Connectivity().checkConnectivity());
_vibrate() {
  Vibration.vibrate(duration: 10, amplitude: 128);
}
