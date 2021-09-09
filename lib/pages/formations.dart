import 'package:parcours_numerique_app/pages/widgets/webview_custom.dart';
import 'package:flutter/material.dart';

class FormationsPage extends StatefulWidget {
  const FormationsPage({Key? key}) : super(key: key);

  @override
  _FormationsPageState createState() => _FormationsPageState();
}

class _FormationsPageState extends State<FormationsPage> with AutomaticKeepAliveClientMixin<FormationsPage> {
  @override
  Widget build(BuildContext context) {
    return const WebViewCustom(url: 'https://transition-numerique.l-ecole.com/parcoursnum/');
  }

  @override
  bool get wantKeepAlive => true;
}
