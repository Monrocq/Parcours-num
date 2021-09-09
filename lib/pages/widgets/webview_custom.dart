import 'package:parcours_numerique_app/pages/solutions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewCustom extends StatelessWidget {
  final String url;
  final String routeFrom;

  const WebViewCustom({Key? key, required this.url, required this.routeFrom}) : super(key: key);

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url, enableJavaScript: true) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        if (!request.url.startsWith('https://parcoursnumerique.motherbase.ai/') && routeFrom == SolutionsPage.routeName) {
          _launchURL(request.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
