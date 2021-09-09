import 'package:flutter/material.dart';
import 'package:parcours_numerique_app/const.dart';
import 'package:parcours_numerique_app/pages/diagnostic.dart';
import 'package:parcours_numerique_app/pages/formations.dart';
import 'package:parcours_numerique_app/pages/solutions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

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

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: primaryColor,
          leading: Builder(builder: (BuildContext context) => IconButton(onPressed: (){}, icon: const Icon(Icons.home))),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
            IconButton(onPressed: (){

            }, icon: const Icon(Icons.loop))
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'Diagnostic',),
            Tab(text: 'Solutions',),
            Tab(text: 'Formations',)
          ], indicatorColor: accentColor,),
        ),
        body: const TabBarView(children: [
          DiagnosticPage(),
          SolutionsPage(),
          FormationsPage(),
        ])
         // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
