library parcours_numerique_app.globals;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//Pass from Main to NavigationControls
late TabController tabController;

late List controllers = [
  Completer<WebViewController>(),
  Completer<WebViewController>(),
  Completer<WebViewController>(),
];