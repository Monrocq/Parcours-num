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
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final controller = snapshot.data!;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          color: ACCENT_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
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
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
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
                ),
              ],),
              IconButton(
                icon: const Icon(Icons.replay),
                onPressed: !webViewReady
                    ? null
                    : () {
                  controller.reload();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
