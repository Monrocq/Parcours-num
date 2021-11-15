import 'dart:async';
import 'dart:ui' as ui;
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:parcours_numerique_app/const.dart';
import 'package:parcours_numerique_app/views/page_layout.dart';
import 'package:parcours_numerique_app/views/pages/diagnostic.dart';
import 'package:parcours_numerique_app/views/pages/formations.dart';
import 'package:parcours_numerique_app/views/pages/intro_screen.dart';
import 'package:parcours_numerique_app/views/pages/solutions.dart';
import 'package:parcours_numerique_app/views/pages/widgets/navigation_controls.dart';
import 'package:parcours_numerique_app/views/videos_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'globals.dart';

void main() {
  //RenderErrorBox.backgroundColor = Colors.transparent;
  //RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final String routeName = 'main';

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;
  bool seen = false;

  @override
  void initState() {
    displayIntro();
    super.initState();
  }

  displayIntro() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      seen = prefs.getBool('seen') ?? false;
    });
  }

  // @override
  // void afterFirstLayout(BuildContext context) => checkFirstSeen(context);

  // Future checkFirstSeen(context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? _seen = prefs.getBool('seen');
  //   print(_seen);
  //   if (_seen == false || _seen == null) {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => IntroScreen(redirect: MyHomePage(title: 'Parcours numérique'))));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcours numérique',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: seen? MyHomePage(title: 'Parcours numérique') : IntroScreen(from: 'main'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final String routeName = 'home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  Key diagnosticKey = UniqueKey();
  Key solutionKey = UniqueKey();
  Key formationKey = UniqueKey();

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
    List<Widget> _tabBarViews = [
      PageLayout(widget: DiagnosticPage(key: diagnosticKey, controller: controllers[0],), navigationControls: NavigationControls(controllers[0].future)),
      PageLayout(widget: SolutionsPage(key: solutionKey, controller: controllers[1],), navigationControls: NavigationControls(controllers[1].future)),
      PageLayout(widget: FormationsPage(key: formationKey, controller: controllers[2],), navigationControls: NavigationControls(controllers[2].future)),
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 3,
        child: Builder(
          builder: (context) {
            if (true) {
              return Scaffold(
                  key: _key,
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(widget.title),
                    backgroundColor: PRIMARY_COLOR,
                    actions: [
                      IconButton(onPressed: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => IntroScreen(from: 'home', index: 0))
                        );
                      }, icon: Icon(Icons.lightbulb)),
                      IconButton(onPressed: () => _key.currentState!.openEndDrawer(), icon: Icon(Icons.video_library_outlined)),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                      // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                      // IconButton(onPressed: (){}, icon: const Icon(Icons.loop))
                    ],
                    titleSpacing: 0,
                    leading: Builder(builder: (BuildContext context) => IconButton(onPressed: (){
                      _showMyDialog();
                    }, icon: const Icon(Icons.open_in_browser))),
                    bottom: Platform.isAndroid ? TabBar(tabs: const [
                      Tab(text: 'Diagnostic',),
                      Tab(text: 'Solutions',),
                      Tab(text: 'Formations',)
                    ],
                      indicatorColor: ACCENT_COLOR,
                      controller: tabController,
                    ) : null,
                  ),
                  body: TabBarView(children: _tabBarViews, controller: tabController, physics: NeverScrollableScrollPhysics(),),
                  endDrawer: VideosDrawer(),
                bottomNavigationBar: Platform.isIOS ? CupertinoTabBar(
                  iconSize: 25,
                  onTap: (index) {
                    print(index);
                    setState(() {
                      tabController.animateTo(index);
                      if (tabController.indexIsChanging == false) {
                        switch (index) {
                          case 0: {
                            diagnosticKey = UniqueKey();
                            break;
                          }
                          case 1: {
                            solutionKey = UniqueKey();
                            break;
                          }
                          case 2: {
                            formationKey = UniqueKey();
                            break;
                          }
                        }
                      };
                    });
                  },
                  //backgroundColor: PRIMARY_COLOR,
                  activeColor: PRIMARY_COLOR,
                  inactiveColor: Colors.grey.shade700,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.doc_chart_fill,
                      ),
                      label: 'Diagnostic'
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.square_stack_3d_up_fill,
                      ),
                      label: 'Solutions'
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.book_fill
                      ),
                      label: 'Formations'
                    ),
                  ],
                  currentIndex: tabController.index,
                ) : null,
                // This trailing comma makes auto-formatting nicer for build methods.
              );
            } else if (Platform.isIOS) {

            }
          }
        ),

      ),
    );
  }
}
