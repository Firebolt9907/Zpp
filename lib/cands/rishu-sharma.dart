import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Zpp/cand-views/rishu-sharma-slide.dart';
import 'package:Zpp/main.dart';

class RishuSharma extends StatefulWidget {
  const RishuSharma({Key? key}) : super(key: key);

  @override
  MySettingsState createState() => MySettingsState();
}

class MySettingsState extends State<RishuSharma> {
  static SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
    systemStatusBarContrastEnforced: false,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  );
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  bool devModeOn = true;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      devModeOn = (prefs.getBool('devModeOn') ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 40.0,
      fontFamily: 'Horizon',
    );
    // Vibration.vibrate(duration: 10, amplitude: 128);
    //SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    MediaQueryData(textScaleFactor: MediaQuery.textScaleFactorOf(context));
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemStatusBarContrastEnforced: false,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            sized: false,
            child: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  trailing: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Rishu Sharma',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  previousPageTitle: 'Candidates',
                  automaticallyImplyLeading: true,
                ),
                child: ListView(
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Row(children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Hero(
                                                tag: 'sus',
                                                transitionOnUserGestures: true,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    child: const Image(
                                                        image: AssetImage(
                                                            'assets/sus.jpg'),
                                                        fit: BoxFit.cover))),
                                          ],
                                        ))))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                                transitionOnUserGestures: true,
                                tag: 'Rishu_First',
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      'Rishu ',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                    ColorizeAnimatedText(
                                      'Rishu ',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                  ],
                                  isRepeatingAnimation: true,
                                )),
                            Hero(
                                transitionOnUserGestures: true,
                                tag: 'Rishu-Last',
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      'Sharma',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                    ColorizeAnimatedText(
                                      'Sharma',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                  ],
                                  isRepeatingAnimation: true,
                                )),
                          ],
                        )
                      ]),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Slide()));
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Hero(
                                  tag: 'rishu-sharma',
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/rishu-campaign.jpg'),
                                      ))))),
                    ]))));
  }
}
