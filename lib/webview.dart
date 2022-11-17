import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:Zpp/main.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:iconforest_arcticons/arcticons.dart';
import 'package:sheet/sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

class OpenWebView extends StatefulWidget {
  // final website;

  OpenWebView({super.key, this.website, this.preview});
  final website;
  final preview;
  @override
  WebViewState createState() => WebViewState();
}

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class WebViewState extends State<OpenWebView> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  late WebViewController _controller;
  // String website = '';
  String _selectedMenu = '';
  @override
  Widget build(BuildContext context) {
    var key = const Key('webview');
    String site =
        widget.website.replaceAll("https://", "").replaceAll("http://", "");
    var pos = site.indexOf('/');
    String result = (pos != -1) ? site.substring(0, pos) : site;
    double width = MediaQuery.of(context).size.width;
    double height2 = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        kToolbarHeight;
    print(kBottomNavigationBarHeight);
    var preview = widget.preview;
    return MaterialApp(
        color: Colors.transparent,
        home: Material(
            color: Colors.transparent,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  // systemStatusBarContrastEnforced: false,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarContrastEnforced: false,
                  systemNavigationBarDividerColor: Colors.transparent,
                  systemNavigationBarIconBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                ),
                sized: false,
                child: SafeArea(
                    top: false,
                    bottom: false,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        child: CupertinoPageScaffold(
                            resizeToAvoidBottomInset: false,
                            backgroundColor: Colors
                                .transparent, //Colors.black.withOpacity(0.6),
                            child: Stack(children: [
                              SafeArea(
                                  top: false,
                                  minimum: const EdgeInsets.only(top: 00),
                                  bottom: false,
                                  child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 25),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20)),
                                                child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 20, sigmaY: 20),
                                                    child: Container(
                                                        height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height,
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.1))))),
                                        // Padding(
                                        //     padding: const EdgeInsets.only(top: 60),
                                        //     child: ClipRRect(
                                        //         borderRadius: const BorderRadius.only(
                                        //             bottomLeft: Radius.circular(8.0),
                                        //             bottomRight: Radius.circular(8.0),
                                        //             topLeft: Radius.circular(18.0),
                                        //             topRight: Radius.circular(18.0)),
                                        //         child: Container(
                                        //             height: height2,
                                        //             width: double.infinity,
                                        //             color: Colors.black))),

                                        Align(
                                            child: SafeArea(
                                                maintainBottomViewPadding:
                                                    false,
                                                bottom: false,
                                                left: false,
                                                right: false,
                                                top: false,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 75, bottom: 0),
                                                    child: Hero(
                                                        tag: widget.website,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                            child: WebView(
                                                              // key: UniqueKey(),
                                                              onWebViewCreated:
                                                                  (WebViewController
                                                                      webViewController) {
                                                                _controller =
                                                                    webViewController;
                                                              },
                                                              onPageFinished:
                                                                  (url) {
                                                                Platform.isAndroid
                                                                    ? JavascriptMode
                                                                        .unrestricted
                                                                    : _controller
                                                                        .runJavascript(
                                                                            "document.getElementsByClassName('ws-header-container')[0].style.display='none';");
                                                                Platform.isAndroid
                                                                    ? JavascriptMode
                                                                        .unrestricted
                                                                    : _controller
                                                                        .runJavascript(
                                                                            "document.getElementsByClassName('ws-footer-page')[0].style.display='none';");
                                                              },
                                                              javascriptMode: Platform.isAndroid
                                                                  ? JavascriptMode
                                                                      .unrestricted
                                                                  : JavascriptMode
                                                                      .disabled,
                                                              // backgroundColor: Colors.black,
                                                              initialUrl: widget
                                                                  .website,
                                                            )))))),

                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 4),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    height: 5,
                                                    width: 55))),

                                        SafeArea(
                                            top: false,
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: SafeArea(
                                                    maintainBottomViewPadding:
                                                        false,
                                                    top: false,
                                                    left: false,
                                                    right: false,
                                                    child: Bounceable(
                                                        onTap: () {
                                                          _launchURL(
                                                              widget.website);
                                                        },
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 32.5,
                                                                    left: 7.5,
                                                                    right: 7.5,
                                                                    bottom:
                                                                        5.0),
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 35,
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: context.isDarkMode ==
                                                                            true
                                                                        ? const Color.fromARGB(
                                                                                255,
                                                                                65,
                                                                                65,
                                                                                65)
                                                                            .withOpacity(
                                                                                0.3)
                                                                        : const Color.fromARGB(
                                                                                255,
                                                                                204,
                                                                                204,
                                                                                204)
                                                                            .withOpacity(0.6),
                                                                    spreadRadius:
                                                                        5,
                                                                    blurRadius:
                                                                        7,
                                                                    // changes position of shadow
                                                                  ),
                                                                ],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            1000),
                                                                color: context
                                                                            .isDarkMode ==
                                                                        true
                                                                    ? const Color.fromARGB(
                                                                            255,
                                                                            65,
                                                                            65,
                                                                            65)
                                                                        .withOpacity(
                                                                            0.8)
                                                                    : const Color.fromARGB(
                                                                            255,
                                                                            204,
                                                                            204,
                                                                            204)
                                                                        .withOpacity(
                                                                            0.6),
                                                              ),
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  // Note: Styles for TextSpans must be explicitly defined.
                                                                  // Child text spans will inherit styles from parent
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: context.isDarkMode
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                  children: <
                                                                      TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            preview,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                    TextSpan(
                                                                        text:
                                                                            ' - '),
                                                                    TextSpan(
                                                                        text:
                                                                            result,
                                                                        style: TextStyle(
                                                                            fontStyle:
                                                                                FontStyle.italic)),
                                                                  ],
                                                                ),
                                                              ), /*Text(
                                                                  '$preview - $result',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: context.isDarkMode ==
                                                                              true
                                                                          ? const Color.fromARGB(
                                                                              255,
                                                                              207,
                                                                              207,
                                                                              207)
                                                                          : const Color.fromARGB(
                                                                              255,
                                                                              99,
                                                                              99,
                                                                              99),
                                                                      fontSize:
                                                                          20),
                                                                )*/
                                                            )))))),
                                        Align(
                                            alignment: Alignment.bottomLeft,
                                            child: SafeArea(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 15.0,
                                                            right: 15,
                                                            left: 15),
                                                    child: Bounceable(
                                                        scaleFactor: 0.6,
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: context.isDarkMode ==
                                                                            true
                                                                        ? const Color.fromARGB(
                                                                                255,
                                                                                65,
                                                                                65,
                                                                                65)
                                                                            .withOpacity(
                                                                                0.6)
                                                                        : const Color.fromARGB(
                                                                                255,
                                                                                204,
                                                                                204,
                                                                                204)
                                                                            .withOpacity(0.5),
                                                                    spreadRadius:
                                                                        5,
                                                                    blurRadius:
                                                                        7,
                                                                    // changes position of shadow
                                                                  ),
                                                                ],
                                                                color: context
                                                                            .isDarkMode ==
                                                                        true
                                                                    ? const Color.fromARGB(
                                                                            255,
                                                                            65,
                                                                            65,
                                                                            65)
                                                                        .withOpacity(
                                                                            0.6)
                                                                    : const Color.fromARGB(
                                                                            255,
                                                                            204,
                                                                            204,
                                                                            204)
                                                                        .withOpacity(
                                                                            0.5),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Icon(
                                                              Icons
                                                                  .close_rounded,
                                                              size: 35,
                                                              color: context
                                                                          .isDarkMode ==
                                                                      true
                                                                  ? const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      207,
                                                                      207,
                                                                      207)
                                                                  : const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      99,
                                                                      99,
                                                                      99),
                                                            )))))),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: SafeArea(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 15.0,
                                                            right: 15,
                                                            left: 15),
                                                    child: Bounceable(
                                                        scaleFactor: 0.6,
                                                        onTap: () {
                                                          _launchURL(
                                                              widget.website);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: context
                                                                              .isDarkMode ==
                                                                          true
                                                                      ? const Color.fromARGB(
                                                                              255,
                                                                              65,
                                                                              65,
                                                                              65)
                                                                          .withOpacity(
                                                                              0.6)
                                                                      : const Color.fromARGB(
                                                                              255,
                                                                              204,
                                                                              204,
                                                                              204)
                                                                          .withOpacity(
                                                                              0.5),
                                                                  spreadRadius:
                                                                      5,
                                                                  blurRadius: 7,
                                                                  // changes position of shadow
                                                                ),
                                                              ],
                                                              color: context
                                                                          .isDarkMode ==
                                                                      true
                                                                  ? const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          65,
                                                                          65,
                                                                          65)
                                                                      .withOpacity(
                                                                          0.6)
                                                                  : const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          204,
                                                                          204,
                                                                          204)
                                                                      .withOpacity(
                                                                          0.5),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.5),
                                                              child: Arcticons(
                                                                Arcticons
                                                                    .google_chrome,
                                                                height: 30,
                                                                color: context
                                                                            .isDarkMode ==
                                                                        true
                                                                    ? const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        207,
                                                                        207,
                                                                        207)
                                                                    : const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        99,
                                                                        99,
                                                                        99),
                                                              )), /*PopupMenuButton<
                                                                  Menu>(
                                                              tooltip: '',
                                                              splashRadius: 18,
                                                              child: Icon(
                                                                Icons.more_vert,
                                                                size: 35,
                                                                color: context
                                                                            .isDarkMode ==
                                                                        true
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            207,
                                                                            207,
                                                                            207)
                                                                    : Color
                                                                        .fromARGB(
                                                                            255,
                                                                            99,
                                                                            99,
                                                                            99),
                                                              ),
                                                              // Callback that sets the selected popup menu item.
                                                              offset:
                                                                  const Offset(
                                                                      0.1, 0.1),
                                                              onSelected:
                                                                  (Menu item) {
                                                                setState(() {
                                                                  _selectedMenu =
                                                                      item.name;
                                                                });
                                                              },
                                                              itemBuilder: (BuildContext
                                                                      context) =>
                                                                  <
                                                                      PopupMenuEntry<
                                                                          Menu>>[
                                                                    // PopupMenuItem<
                                                                    //     Menu>(
                                                                    //   onTap:
                                                                    //       () {
                                                                    //     _controller.loadUrl(widget.website);
                                                                    //   },
                                                                    //   value:
                                                                    //       Menu.itemOne,
                                                                    //   child:
                                                                    //       Row(textDirection: TextDirection.rtl, children: [
                                                                    //     Padding(padding: EdgeInsets.only(left: 10), child: Icon(Icons.refresh_rounded)),
                                                                    //     Text(
                                                                    //       'Refresh',
                                                                    //       textAlign: TextAlign.end,
                                                                    //     ),
                                                                    //   ]),
                                                                    // ),
                                                                    PopupMenuItem<
                                                                        Menu>(
                                                                      onTap:
                                                                          () {
                                                                        _launchURL(
                                                                            widget.website);
                                                                      },
                                                                      value: Menu
                                                                          .itemTwo,
                                                                      child: Row(
                                                                          textDirection:
                                                                              TextDirection.rtl,
                                                                          children: [
                                                                            const Padding(
                                                                              padding: EdgeInsets.only(left: 10),
                                                                              child: Icon(Icons.open_in_new_rounded),
                                                                            ),
                                                                            const Text(
                                                                              'Open',
                                                                              textAlign: TextAlign.end,
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                    // PopupMenuItem<
                                                                    //     Menu>(
                                                                    //   value:
                                                                    //       Menu.itemThree,
                                                                    //   child:
                                                                    //       Row(textDirection: TextDirection.rtl, children: [
                                                                    //     Padding(
                                                                    //       padding: EdgeInsets.only(left: 10),
                                                                    //       child: Icon(Icons.open_in_new_rounded),
                                                                    //     ),
                                                                    //     Text(
                                                                    //       'Open',
                                                                    //       textAlign: TextAlign.end,
                                                                    //     ),
                                                                    //   ]),
                                                                    // ),
                                                                    // PopupMenuItem<
                                                                    //     Menu>(
                                                                    //   value:
                                                                    //       Menu.itemFour,
                                                                    //   child:
                                                                    //       Row(textDirection: TextDirection.rtl, children: [
                                                                    //     Padding(
                                                                    //       padding: EdgeInsets.only(left: 10),
                                                                    //       child: Icon(Icons.open_in_new_rounded),
                                                                    //     ),
                                                                    //     Text(
                                                                    //       'Open',
                                                                    //       textAlign: TextAlign.end,
                                                                    //     ),
                                                                    //   ]),
                                                                    // ),
                                                                  ]),*/
                                                        ))))),
                                      ]))
                            ])))))));
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
