import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:parcours_numerique_app/const.dart';
import '../../../globals.dart';


class NavigationControls extends StatelessWidget {

  final Future<WebViewController> _webViewControllerFuture;
  const NavigationControls(this._webViewControllerFuture) : assert(_webViewControllerFuture != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        if (snapshot.hasData) {
          final bool webViewReady =
              snapshot.connectionState == ConnectionState.done;
          final controller = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: [
                  FloatingActionButton(
                    backgroundColor: WEBVIEW_CONTROLLER_COLOR,
                    child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
                    onPressed: !webViewReady
                        ? null
                        : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        // ignore: deprecated_member_use
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("Aucun élement précédent à afficher")),
                        );
                        return;
                      }
                    },
                  ),
                  /**
                      IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onPressed: !webViewReady
                      ? null
                      : () async {
                      if (await controller.canGoForward()) {
                      await controller.goForward();
                      } else {
                      // ignore: deprecated_member_use
                      Scaffold.of(context).showSnackBar(
                      const SnackBar(
                      content: Text("Aucun élement à afficher")),
                      );
                      return;
                      }
                      },
                      ), */
                ],),
                FloatingActionButton(
                  backgroundColor: WEBVIEW_CONTROLLER_COLOR,
                  child: const Icon(Icons.replay, color: Colors.white,),
                  onPressed: !webViewReady
                      ? null
                      : () {
                    controller.reload();
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Il y'a des erreurs");
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
