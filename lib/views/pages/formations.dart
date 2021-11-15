import 'dart:async';

import 'package:parcours_numerique_app/views/pages/widgets/webview_custom.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FormationsPage extends StatefulWidget {
  final Completer<WebViewController> controller;
  const FormationsPage({Key? key, required this.controller}) : super(key: key);
  static const String routeName = 'formations-page';
  static const String controllerName = 'formationsController';

  @override
  _FormationsPageState createState() => _FormationsPageState();
}

class _FormationsPageState extends State<FormationsPage> with AutomaticKeepAliveClientMixin<FormationsPage> {
  @override
  Widget build(BuildContext context) {
    return WebViewCustom(url: 'https://transition-numerique.l-ecole.com/parcoursnum/', routeFrom: FormationsPage.routeName, controller: widget.controller,);
  }

  @override
  bool get wantKeepAlive => true;
}


