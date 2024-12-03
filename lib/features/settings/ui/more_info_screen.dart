import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forest_tinker_live/core/services/mixins/network_mixin.dart';
import 'package:forest_tinker_live/features/onb/initial_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MoreInfoScreen extends StatefulWidget {
  const MoreInfoScreen({super.key});

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> with NetworkMixin {
  late final WebViewController _controller;

  bool _isLoading = true;

  String get _cssCode {
    return ".docs-ml-promotion, #docs-ml-header-id { display: none !important; } .app-container { margin: 0 !important; }";
  }

  String get _jsCode => """
      var style = document.createElement('style');
      style.type = "text/css";
      style.innerHTML = "$_cssCode";
      document.head.appendChild(style);
    """;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            controller.runJavaScript(_jsCode);

            setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            if (error.errorCode == -1009) {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => const InitialScreen(),
                ),
              );
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) async {
            if (change.url != null) {
              await _saveLastVisit(change.url!);
            }
          },
        ),
      );

    if (controller.platform is WebKitWebViewController) {
      (controller.platform as WebKitWebViewController)
          .setAllowsBackForwardNavigationGestures(true);
    }

    _controller = controller;

    _loadUrl().then((urlToLoad) {
      _controller.loadRequest(Uri.parse(urlToLoad));
    });
  }

  Future<void> _saveLastVisit(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastVisitedUrl', url);
    } catch (e) {
      log('Error saving last visited URL: $e');
    }
  }

  Future<String> _loadUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final initialLink = prefs.getString('initialLink');
      if (initialLink == null) {
        prefs.setString('initialLink', link);
      } else {
        if (link != initialLink) {
          prefs.setString('initialLink', link);
          return link;
        }
      }
      final url = prefs.getString('lastVisitedUrl') ?? link;

      return url;
    } catch (e) {
      return link;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF313131),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    const CupertinoActivityIndicator(
                      color: CupertinoColors.white,
                      radius: 15,
                    )
                  ],
                ),
              ),
            )
          : SafeArea(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
    );
  }
}
