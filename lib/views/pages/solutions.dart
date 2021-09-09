import 'dart:async';

import 'package:parcours_numerique_app/views/pages/widgets/webview_custom.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SolutionsPage extends StatefulWidget {
  final Completer<WebViewController> controller;
  const SolutionsPage({Key? key, required this.controller}) : super(key: key);
  static const String routeName = 'solutions-page';
  static const String controllerName = 'solutions-controller';

  @override
  _SolutionsPageState createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> with AutomaticKeepAliveClientMixin<SolutionsPage> {
  @override
  Widget build(BuildContext context) {
    return WebViewCustom(url: 'https://parcoursnumerique.motherbase.ai/', routeFrom: SolutionsPage.routeName, controller: widget.controller,);
  }

  @override
  bool get wantKeepAlive => true;
}
