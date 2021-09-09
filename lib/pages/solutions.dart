import 'package:parcours_numerique_app/pages/widgets/webview_custom.dart';
import 'package:flutter/material.dart';

class SolutionsPage extends StatefulWidget {
  const SolutionsPage({Key? key}) : super(key: key);

  @override
  _SolutionsPageState createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> with AutomaticKeepAliveClientMixin<SolutionsPage> {
  @override
  Widget build(BuildContext context) {
    return const WebViewCustom(url: 'https://parcoursnumerique.motherbase.ai/');
  }

  @override
  bool get wantKeepAlive => true;
}
