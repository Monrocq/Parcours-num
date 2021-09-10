import 'dart:async';

import 'package:parcours_numerique_app/views/pages/solutions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewCustom extends StatefulWidget {
  final String url;
  final String routeFrom;
  final Completer<WebViewController> controller;

  WebViewCustom({Key? key, required this.url, required this.routeFrom, required this.controller}) : super(key: key);

  @override
  State<WebViewCustom> createState() => _WebViewCustomState();
}

class _WebViewCustomState extends State<WebViewCustom> {
  bool isLoading = true;

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url, enableJavaScript: true) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
          initialUrl: widget.url,
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            widget.controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            if (!request.url.startsWith('https://parcoursnumerique.motherbase.ai/') && widget.routeFrom == SolutionsPage.routeName) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
        isLoading ? Center(
          child: CircularProgressIndicator(),
        ) : Stack()
      ],
    );
  }
}
