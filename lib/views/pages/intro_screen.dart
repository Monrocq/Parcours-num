import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  Widget redirect;
  IntroScreen({required this.redirect});

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
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => widget.redirect),
    );
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => widget.redirect),
    );
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
      globalFooter: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            child: const Text(
              'Revoir plus tard',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "CRM, GRC, Progiciel, E-commerce, etc... 🤯",
          body:
          "Le nombre d'outil numérique évolue de manière exponentiel! Mais comment trouver LA solution adéquate à ses besoins?",
          image: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_sk5h1kfn.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bienvenue sur Parcours Numérique",
          body:
          "Parcours numérique accompagne et guide les petites entreprises dans le choix de leurs outils digitaux ",
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
          title: "Explorer les solutions",
          body:
          "Accédez à un riche catalogue de solutions. Vous trouverez forcément l'outil dont vous nécessitez",
          image: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_jtvduiqm.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Diagnostic Digital",
          body:
          "Etablissez un check-up digital afin de visualiser où la digitalisation peut vous être bénéfique",
          image: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_xkmq5z4e.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Découvrir les formations",
          body:
          "Vous préferez vous faire accompagner? Découvrez nos nombreuses formations",
          image: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_26ewjioz.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Introduction terminée",
          body: "Faites de Parcours Numérique votre nouveau compagnon pour propulser votre business!",
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
      initialPage: 1,
      skip: Text('Passer'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Ne plus revoir', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.symmetric(horizontal: 16),
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