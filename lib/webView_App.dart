import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewApp extends StatefulWidget {
  const webViewApp({Key? key}) : super(key: key);

  @override
  State<webViewApp> createState() => _webViewAppState();
}

class _webViewAppState extends State<webViewApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.loadUrl('https://amazon.com');
          controller.evaluateJavascript(
            "document.getElementsByTagName('header')[0].style.display='none'",
          );
          controller.evaluateJavascript(
            "document.getElementsByTagName('footer')[0].style.display='none'",
          );
        },
        child: const Icon(Icons.import_export),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: WebView(
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          Fluttertoast.showToast(
            msg: 'Website:  $url',
          );
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://web.whatsapp.com',
      ),
    );
  }

  late WebViewController controller;
}
