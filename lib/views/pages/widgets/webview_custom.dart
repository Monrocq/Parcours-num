import 'dart:async';

import 'package:parcours_numerique_app/views/pages/solutions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewCustom extends StatelessWidget {
  final String url;
  final String routeFrom;
  final Completer<WebViewController> controller;

  const WebViewCustom({Key? key, required this.url, required this.routeFrom, required this.controller}) : super(key: key);

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url, enableJavaScript: true) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: WebView(
            initialUrl: url,
            gestureNavigationEnabled: true,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              if (!request.url.startsWith('https://parcoursnumerique.motherbase.ai/') && routeFrom == SolutionsPage.routeName) {
                _launchURL(request.url);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        ),

      ],
    );
  }
}
