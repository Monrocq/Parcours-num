import 'dart:async';

import 'package:parcours_numerique_app/views/pages/widgets/navigation_controls.dart';
import 'package:parcours_numerique_app/views/pages/widgets/webview_custom.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DiagnosticPage extends StatefulWidget {
  final Completer<WebViewController> controller;
  const DiagnosticPage({Key? key, required this.controller}) : super(key: key);
  static const String routeName = 'diagnostic-page';
  static const String controllerName = 'diagnostic-controller';

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> with AutomaticKeepAliveClientMixin<DiagnosticPage> {

  @override
  Widget build(BuildContext context) {
    return WebViewCustom(url: 'https://parcoursnum.reussiravecleweb.fr/', routeFrom: DiagnosticPage.routeName, controller: widget.controller,);
  }

  @override
  bool get wantKeepAlive => true;
}
