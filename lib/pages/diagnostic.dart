import 'package:parcours_numerique_app/pages/widgets/webview_custom.dart';
import 'package:flutter/material.dart';

class DiagnosticPage extends StatefulWidget {
  const DiagnosticPage({Key? key}) : super(key: key);

  @override
  State<DiagnosticPage> createState() => _DiagnosticPageState();
}

class _DiagnosticPageState extends State<DiagnosticPage> with AutomaticKeepAliveClientMixin<DiagnosticPage> {
  @override
  Widget build(BuildContext context) {
    return const WebViewCustom(url: 'https://parcoursnum.reussiravecleweb.fr/');
  }

  @override
  bool get wantKeepAlive => true;
}
