import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class IntroScreen extends StatefulWidget {
  String from;
  int index;
  IntroScreen({required this.from, this.index = 1});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  late SharedPreferences prefs;

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  void getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _desactivateIntroduction(context) async {
    await prefs.setBool('seen', true);
    _onIntroEnd(context);
  }

  void _onIntroEnd(context) {
    if (widget.from == "main") {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => MyHomePage(title: 'Parcours numérique'), ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/img/background.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName) {
    return Image.asset('lib/assets/img/$assetName', width: MediaQuery.of(context).size.width / 3);
  }

  _repeatIntroduction() {

  }

  @override
  Widget build(BuildContext context) {
    bool repeatIntroduction = true;
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalHeader: widget.index == 1 ? SafeArea(child: Container(child: IconButton(icon: Icon(Icons.close, color: Colors.blueGrey, size: 33,), onPressed: () => _onIntroEnd(context),), alignment: Alignment.centerRight, margin: EdgeInsets.only(right: 8),)) : Container() ,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('flutter.png', 100),
      //     ),
      //   ),
      // ),
      // globalFooter: widget.index == 1 ? SafeArea(
      //   child: SizedBox(
      //     width: double.infinity,
      //     height: 60,
      //     child: ElevatedButton(
      //       child: const Text(
      //         'Revoir plus tard',
      //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //       ),
      //       onPressed: () => _onIntroEnd(context),
      //     ),
      //   ),
      // ) : Container(),
      pages: [
        /**
        PageViewModel(
          title: "CRM, GRC, Progiciel, E-commerce, etc... 🤯",
          body:
          "Le nombre d'outil numérique évolue de manière exponentiel! Mais comment trouver LA solution adéquate à ses besoins?",
          image: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_sk5h1kfn.json'),
          decoration: pageDecoration,
        ),
            */
        PageViewModel(
          title: "Bienvenue sur \nParcours Numérique",
          body:
          "Parcours Numérique accompagne les entreprises de proximité, les commerçants et les TPE, dans leur choix de solutions et technologies numériques pour leur activité professionnelle",
          image: Stack(children: [
            Lottie.network('https://assets7.lottiefiles.com/packages/lf20_daqsbzrp.json'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildImage('PN.png'),
            )
          ], alignment: Alignment.centerRight,),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Réussir avec le Web",
          body:
          "En partenariat avec l'AFNIC, Parcours Numérique vous propose un bilan de maturité numérique et un plan d'action",
          image: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_xkmq5z4e.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Trouver la solution",
          body:
          "Parcours Numérique propose une sélection de solutions logicielles par activité professionnelle et maturité numérique",
          image: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_jtvduiqm.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Se former au numérique",
          body:
          "Formez-vous ou vos collaborateurs avec notre partenaire l-ecole.com",
          image: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_26ewjioz.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Artisans, Commerçants, TPE",
          body: "Faites de Parcours Numérique votre compagnon pour votre transformation digitale",
          image: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_rmlyntkm.json'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _desactivateIntroduction(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      initialPage: 0, //widget.index,
      skip: Text('Passer', style: TextStyle(color: Colors.lightBlue)),
      next: const Icon(Icons.arrow_forward, color: Colors.lightBlue,),
      done: const Text('Terminer', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.lightBlue)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.symmetric(horizontal: 16, vertical: widget.index == 0 ? 16 : 0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}