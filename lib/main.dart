import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parcours_numerique_app/const.dart';
import 'package:parcours_numerique_app/views/page_layout.dart';
import 'package:parcours_numerique_app/views/pages/diagnostic.dart';
import 'package:parcours_numerique_app/views/pages/formations.dart';
import 'package:parcours_numerique_app/views/pages/solutions.dart';
import 'package:parcours_numerique_app/views/pages/widgets/navigation_controls.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'globals.dart';

void main() {
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

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              backgroundColor: PRIMARY_COLOR,
              actions: [
                //IconButton(onPressed: _openEndDrawer, icon: Icon(Icons.video_library_outlined)),
                // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                // IconButton(onPressed: (){}, icon: const Icon(Icons.loop))
              ],
              leading: Builder(builder: (BuildContext context) => IconButton(onPressed: (){}, icon: const Icon(Icons.home))),
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
            ], controller: tabController,),
             endDrawer: const Drawer(
               child: Text('Videos'),
             ),
             // This trailing comma makes auto-formatting nicer for build methods.
          );
        }
      ),

    );
  }
}
