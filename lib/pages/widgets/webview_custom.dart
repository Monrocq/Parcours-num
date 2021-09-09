import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewCustom extends StatelessWidget {
  final String url;

  const WebViewCustom({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(initialUrl: url, javascriptMode: JavascriptMode.unrestricted,);
  }
}
