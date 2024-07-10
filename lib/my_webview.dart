import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key, required this.url});

  final String url;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late Uri uri;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    uri = Uri.parse(widget.url);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..addJavaScriptChannel(
        'EwWebViewChannel',
        onMessageReceived: handleMessage,
      )
      ..setOnScrollPositionChange((change) {
        log(change.y.toString());
      })
      ..loadRequest(uri);
  }

  void handleMessage(JavaScriptMessage message) {
    log(message.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.runJavaScript("setText('SonDepTrai')");
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
