library leo_feedback;

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
part './widgets/fadeZoomBox.dart';
part './widgets/indicator.dart';
part './widgets/common.dart';
part './widgets/slider.dart';
part 'widgets/feedback.dart';
part 'theme.dart';
part 'actions.dart';
part 'model.dart';
part 'tools.dart';

class FeedBackHost {
  bool intanceGenerateByInit = false;

  BuildContext? context;

  double designWidth = 375;

  double ratio = 1.0;

  bool fadeZoomBoxCreated = false;

  MediaQueryData mediaQueryData =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

  FeedbackBrightness? brightness;

  FeedbackThemeData feedBackTheme =
      FeedbackThemeData(brightness: FeedbackBrightness.light);

  OverlayEntry? _uniqueOverlayEntry;

  GlobalKey _uniqueGlobalStateKey = FeedBackHost._defaultUniqueGlobalKey;

  static GlobalKey _defaultUniqueGlobalKey =
      GlobalKey(debugLabel: '_defaultUniqueGlobalKey');

  static GlobalKey _loadingGlobalKey =
      GlobalKey(debugLabel: '_defaultUniqueGlobalKey');

  Set<Function> _shouldCallAfterFadeZoomBoxWidgetCreatedFunctions = Set();
  Set<Function> _shouldCallAfterSliderWidgetCreatedFunctions = Set();

  Set<OverlayEntry> _sliderOverlayEntrySet = Set();

  Set<GlobalKey> _sliderKeysSet = Set();

  FeedBackHost(bool executeInit) {
    this.intanceGenerateByInit = executeInit;
  }

  static FeedBackHost instance = FeedBackHost(false);

  static calcScaleRatio(double desiginWidth) {
    double screenWidth = FeedBackHost.instance.mediaQueryData.size.width;
    double ratio = screenWidth / desiginWidth;
    instance.ratio = double.parse(ratio.toStringAsFixed(6));
  }

  FeedBackHost._init(
      {required BuildContext context,
      required FeedbackBrightness brightness,
      required double designWidth}) {
    if (!instance.intanceGenerateByInit) {
      instance = this;
      instance.intanceGenerateByInit = true;
      instance.context = context;
      FeedBackHost.calcScaleRatio(designWidth);
    }

    if (instance.context != context) {
      print('leo_feedback: content is change');
      instance.context = context;
    }

    if (instance.brightness != brightness) {
      instance.brightness = brightness;
      instance.feedBackTheme = FeedbackThemeData(brightness: brightness);
    }
  }

  OverlayEntry _show(Widget child,
      {bool? cover, bool? unique, bool? isSlider}) {
    bool _cover = cover ?? true;
    unique ??= false;
    isSlider ??= false;
    assert(
        (unique == true && isSlider == false) ||
            (unique == false && isSlider == true) ||
            (isSlider == false && unique == false),
        'either "unique" or "isSlider" only one can be true of boolean');
    bool dark = FeedBackHost.instance.brightness == FeedbackBrightness.dark;
    Color overlayColor =
        dark ? Color.fromRGBO(0, 0, 0, 0.3) : Color.fromRGBO(0, 0, 0, 0.15);
    OverlayEntry _overlayEntry = OverlayEntry(
      builder: (BuildContext ctx) => WidgetsApp(
        color: Colors.grey,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? _child) =>
            Container(color: _cover ? overlayColor : null, child: child),
      ),
    );
    if (unique) FeedBackHost.instance._uniqueOverlayEntry = _overlayEntry;
    if (isSlider)
      FeedBackHost.instance._sliderOverlayEntrySet.add(_overlayEntry);
    Overlay.of(instance.context!)!.insert(_overlayEntry);
    return _overlayEntry;
  }

  void _dismiss(OverlayEntry _overlayEntry) {
    _overlayEntry.remove();
  }

  void _dismissUnique() {
    if (instance._uniqueOverlayEntry != null) {
      instance._uniqueOverlayEntry!.remove();
      instance._uniqueOverlayEntry = null;
    }
    instance._uniqueGlobalStateKey = FeedBackHost._defaultUniqueGlobalKey;
  }
}
