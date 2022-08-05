import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';
import 'about_us.dart';

_launchURL(var myUrl) async {
  Uri finalUrl = Uri.parse(myUrl);
  if (await canLaunchUrl(finalUrl)) {
    launchUrl(finalUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $myUrl';
  }
}

class TestText extends StatelessWidget {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('TestText'),
          previousPageTitle: 'Home',
          automaticallyImplyLeading: true,
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemStatusBarContrastEnforced: false,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            sized: false,
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: getBoolValuesSF('devModeOn') == false
                        ? const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus id felis id euismod. Nunc non dolor malesuada, finibus quam quis, dictum ligula. Donec tincidunt, dui ac varius commodo, eros tortor pellentesque nulla, sit amet porta lacus odio a sem. Vivamus aliquet ligula at molestie congue. Nulla vel dictum turpis. Morbi consectetur ligula non urna faucibus, ut laoreet purus placerat. Morbi rhoncus porta velit et aliquam. Sed pretium, orci id tincidunt vehicula, metus mauris malesuada nunc, eget consectetur erat risus molestie purus. Fusce convallis diam eu tortor rhoncus gravida. Sed id nunc quis augue vulputate facilisis. Praesent gravida luctus maximus.")
                        : Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus id felis id euismod. Nunc non dolor malesuada, finibus quam quis, dictum ligula. Donec tincidunt, dui ac varius commodo, eros tortor pellentesque nulla, sit amet porta lacus odio a sem. Vivamus aliquet ligula at molestie congue. Nulla vel dictum turpis. Morbi consectetur ligula non urna faucibus, ut laoreet purus placerat. Morbi rhoncus porta velit et aliquam. Sed pretium, orci id tincidunt vehicula, metus mauris malesuada nunc, eget consectetur erat risus molestie purus. Fusce convallis diam eu tortor rhoncus gravida. Sed id nunc quis augue vulputate facilisis. Praesent gravida luctus maximus.",
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle)),
              ],
            )));
  }
}

class DevMode extends StatefulWidget {
  const DevMode({Key? key}) : super(key: key);

  @override
  State<DevMode> createState() => DevModeState();
}

class DevModeState extends State<DevMode> {
  bool on = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
        body: Center(
      child: Column(children: [
        const Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 0)),
        CupertinoSwitch(
          activeColor: Colors.white,
          thumbColor: on ? Colors.greenAccent : Colors.redAccent,
          trackColor: Colors.grey,
          value: on,
          onChanged: (value) => setState(() {
            on = !on;
            if (on == true) {
              addBoolToSF('devModeOn', false);
            } else {
              addBoolToSF('devModeOn', true);
            }
          }),
        ),
        CupertinoButton.filled(
            onPressed: () {
              Phoenix.rebirth(context);
              Navigator.pop(context);
            },
            child: const Text("Apply"))
      ]),
    ));
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
  );
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
            ),
            sized: false,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      middle: Text('your mom jokes'),
                      previousPageTitle: 'Settings',
                      automaticallyImplyLeading: true,
                    ),
                    child: ListView(children: [
                      const CupertinoListTile(
                        title: Text(
                            'ur mom so fat ur dad didnt leave for the milk'),
                      ),
                      const CupertinoListTile(
                        title: Text('ur mom 🤣🤢🤣🤢🤢🤣🤣🤣'),
                      ),
                      const CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she got an award from "jonas 4"'),
                      ),
                      const CupertinoListTile(
                        title: Text('ur mom so dumb that u r a mistake'),
                      ),
                      const CupertinoListTile(
                        title: Text(
                            'ur mom so stupid she thought instagram was a weed delivery service'),
                      ),
                      CupertinoListTile(
                          subtitle: RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: TextStyle(
                                fontSize: 11,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              children: const <TextSpan>[
                                TextSpan(text: 'add rohan for suggesting this'),
                              ],
                            ),
                          ),
                          title: const Text('Follow my Xbox Account'),
                          onTap: () => _launchURL(
                              "https://www.snapchat.com/add/awesomergs?share_id=-3bVKPHO7Do&locale=en-US")),
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
  );
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  systemStatusBarContrastEnforced: true,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.transparent,
                ),
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
                          child: getBoolValuesSF('devModeOn') == false
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
