import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import '../features/market_place/widgets/web_view_screen.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: WebViewScreen(url: url),
    // ),
    //   WebView(
    //     initialUrl: url,
    //     javascriptMode: JavascriptMode.unrestricted,
    //   ),
    );
  }
}