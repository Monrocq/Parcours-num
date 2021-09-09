import 'package:parcours_numerique_app/pages/widgets/webview_custom.dart';
import 'package:flutter/material.dart';

class DiagnosticPage extends StatefulWidget {
  const DiagnosticPage({Key? key}) : super(key: key);
  static const String routeName = 'diagnostic-page';

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> with AutomaticKeepAliveClientMixin<DiagnosticPage> {
  @override
  Widget build(BuildContext context) {
    return const WebViewCustom(url: 'https://parcoursnum.reussiravecleweb.fr/', routeFrom: DiagnosticPage.routeName,);
  }

  @override
  bool get wantKeepAlive => true;
}
