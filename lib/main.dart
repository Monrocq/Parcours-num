import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:parcours_numerique_app/const.dart';
import 'package:parcours_numerique_app/views/page_layout.dart';
import 'package:parcours_numerique_app/views/pages/diagnostic.dart';
import 'package:parcours_numerique_app/views/pages/formations.dart';
import 'package:parcours_numerique_app/views/pages/solutions.dart';
import 'package:parcours_numerique_app/views/pages/widgets/navigation_controls.dart';
import 'package:parcours_numerique_app/views/videos_drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'globals.dart';

void main() {
  //RenderErrorBox.backgroundColor = Colors.transparent;
  //RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Parcours numérique'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    tabController = TabController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );
  }

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url, enableJavaScript: true) : throw 'Could not launch $_url';

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Redirection vers le site de Parcours Numérique'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Vous allez être redirigé sur le navigateur web'),
                Text('Souhaitez vous poursuivre cette action?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler', style: TextStyle(color: Colors.red,)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Poursuivre'),
              onPressed: () {
                _launchURL('https://www.parcoursnumerique.fr');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          return Scaffold(
            key: _key,
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.title),
              backgroundColor: PRIMARY_COLOR,
              actions: [
                IconButton(onPressed: () => _key.currentState!.openEndDrawer(), icon: Icon(Icons.video_library_outlined)),
                // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                // IconButton(onPressed: (){}, icon: const Icon(Icons.loop))
              ],
              leading: Builder(builder: (BuildContext context) => IconButton(onPressed: (){
                _showMyDialog();
              }, icon: const Icon(Icons.open_in_browser))),
              bottom: TabBar(tabs: [
                Tab(text: 'Diagnostic',),
                Tab(text: 'Solutions',),
                Tab(text: 'Formations',)
              ],
                indicatorColor: ACCENT_COLOR,
                controller: tabController,
              ),
            ),
            body: TabBarView(children: [
              PageLayout(widget: DiagnosticPage(controller: controllers[0],), navigationControls: NavigationControls(controllers[0].future)),
              PageLayout(widget: SolutionsPage(controller: controllers[1],), navigationControls: NavigationControls(controllers[1].future)),
              PageLayout(widget: FormationsPage(controller: controllers[2],), navigationControls: NavigationControls(controllers[2].future)),
              //Container(child: Text('Test'),),
              //Container(child: Text('Test'),),
            ], controller: tabController, physics: NeverScrollableScrollPhysics(),),
             endDrawer: VideosDrawer()
             // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
      ),

    );
  }
}
