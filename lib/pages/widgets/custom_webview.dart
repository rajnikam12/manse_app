import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomWebView extends StatefulWidget {
  final String url, title;
  final bool enableSmoothTransition;

  const CustomWebView({
    super.key,
    required this.url,
    required this.title,
    this.enableSmoothTransition = true,
  });

  // Static method to push with custom transition
  static Future<void> push(
    BuildContext context, {
    required String url,
    required String title,
    bool enableSmoothTransition = true,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CustomWebView(
          url: url,
          title: title,
          enableSmoothTransition: enableSmoothTransition,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView>
    with SingleTickerProviderStateMixin {
  late String _url;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  double _progress = 0;
  InAppWebViewController? _webViewController;
  late PullToRefreshController _pullToRefreshController;

  // Animation controllers for smooth transitions
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Timeout for page loading
  Timer? _loadingTimer;
  static const int _loadingTimeoutSeconds = 30;

  @override
  void initState() {
    super.initState();
    _initializeUrl();
    _initializeAnimations();
    _initializePullToRefresh();
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    _fadeController.dispose();
    _webViewController?.stopLoading();
    super.dispose();
  }

  void _initializeUrl() {
    String url = widget.url.trim();

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    _url = url;
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // Start fade in animation
    _fadeController.forward();
  }

  void _initializePullToRefresh() {
    _pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.deepOrange),
      onRefresh: () async {
        await _webViewController?.reload();
      },
    );
  }

  void _startLoadingTimer() {
    _loadingTimer?.cancel();
    _loadingTimer = Timer(const Duration(seconds: _loadingTimeoutSeconds), () {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Connection timeout. Please try again.';
        });
        _fadeController.forward();
      }
    });
  }

  // Future<void> _handleLoadError(WebResourceError error) async {
  //   _loadingTimer?.cancel();

  //   setState(() {
  //     _isLoading = false;
  //     _hasError = true;

  //     switch (error.type) {
  //       case WebResourceErrorType.NO_INTERNET_CONNECTION:
  //         _errorMessage = 'No internet connection';
  //         break;
  //       case WebResourceErrorType.HOST_LOOKUP:
  //         _errorMessage = 'Server not found';
  //         break;
  //       case WebResourceErrorType.CONNECTION_REFUSED:
  //         _errorMessage = 'Connection refused';
  //         break;
  //       case WebResourceErrorType.TIMEOUT:
  //         _errorMessage = 'Connection timeout';
  //         break;
  //       case WebResourceErrorType.CERTIFICATE:
  //         _errorMessage = 'Security certificate error';
  //         break;
  //       default:
  //         _errorMessage = 'Failed to load page';
  //     }
  //   });

  //   _fadeController.forward();
  // }

  Future<bool> _onWillPop() async {
    if (await _webViewController?.canGoBack() ?? false) {
      _webViewController?.goBack();
      return false;
    }

    // Add pop transition animation if enabled
    if (widget.enableSmoothTransition) {
      _fadeController.reverse();
      await Future.delayed(_fadeController.duration!);
    }

    return true;
  }

  Widget _buildLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          value: _progress < 0 ? null : _progress,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrange),
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 16),
        Text(
          'Loading... ${(_progress * 100).toStringAsFixed(0)}%',
          style: const TextStyle(color: Colors.deepOrange, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'An error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _retryLoading,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _retryLoading() {
    setState(() {
      _hasError = false;
      _isLoading = true;
      _errorMessage = null;
      _progress = 0;
    });

    _fadeController.forward();
    _webViewController?.reload();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.deepOrange),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 1,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.deepOrange,
            ),
          ),
          actions: [
            if (_webViewController != null)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _webViewController?.reload(),
                color: Colors.deepOrange,
              ),
          ],
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            children: [
              if (_hasError) _buildErrorWidget(),
              if (!_hasError)
                InAppWebView(
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      _isLoading = true;
                      _progress = 0;
                    });
                    _startLoadingTimer();
                  },
                  onLoadStop: (controller, url) {
                    _loadingTimer?.cancel();
                    setState(() {
                      _isLoading = false;
                      _hasError = false;
                    });
                    _pullToRefreshController.endRefreshing();
                  },

                  onProgressChanged: (controller, progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                  initialUrlRequest: URLRequest(url: WebUri(_url)),
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                        return ServerTrustAuthResponse(
                          action: ServerTrustAuthResponseAction.PROCEED,
                        );
                      },
                  pullToRefreshController: _pullToRefreshController,
                ),
              if (_isLoading && !_hasError)
                Container(
                  color: Colors.white.withOpacity(0.9),
                  child: Center(child: _buildLoadingIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
