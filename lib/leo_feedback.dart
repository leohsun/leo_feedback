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

class DelayTween extends Tween<double> {
  DelayTween({double begin, double end, this.delay}) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) => super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
}

class FeedBackHost {
  BuildContext context;

  double designWidth = 375;

  double ratio;

  FeedbackBrightness brightness;

  FeedbackThemeData feedBackTheme;

  OverlayEntry _uniqueOverlayEntry;

  GlobalKey _uniqueGlobalStateKey;

  Set<Function> _shouldCallAfterFadeZoomBoxWidgetCreatedFunctions = Set();
  Set<Function> _shouldCallAfterSliderWidgetCreatedFunctions = Set();

  Set<OverlayEntry> _sliderOverlayEntrySet = Set();

  Set<GlobalKey> _sliderKeysSet = Set();

  static FeedBackHost instance;

  FeedBackHost._init({BuildContext context, FeedbackBrightness brightness}) {
    print('---init');
    instance ??= this;
    instance.context ??= context;
    if (instance.brightness != brightness) {
      instance.brightness = brightness;
      instance.feedBackTheme = FeedbackThemeData(brightness: brightness);
    }
  }

  OverlayEntry _show(Widget child, {bool cover, bool unique, bool isSlider}) {
    cover ??= true;
    unique ??= false;
    isSlider ??= false;
    assert(
        (unique == true && isSlider == false) ||
            (unique == false && isSlider == true) ||
            (isSlider == false && unique == false),
        'either "unique" or "isSlider" only one can be true of boolean');
    bool dark = FeedBackHost.instance.brightness == FeedbackBrightness.dark;
    Color overlayColor = dark ? Color.fromRGBO(0, 0, 0, 0.3) : Color.fromRGBO(0, 0, 0, 0.15);
    OverlayEntry _overlayEntry = OverlayEntry(
      builder: (BuildContext ctx) => WidgetsApp(
        color: Colors.grey,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget _child) => Container(color: cover ? overlayColor : null, child: child),
      ),
    );
    if (unique) FeedBackHost.instance._uniqueOverlayEntry = _overlayEntry;
    if (isSlider) FeedBackHost.instance._sliderOverlayEntrySet.add(_overlayEntry);
    Overlay.of(instance.context).insert(_overlayEntry);
    print(FeedBackHost.instance._sliderOverlayEntrySet.length);
    return _overlayEntry;
  }

  void _dismiss(OverlayEntry _overlayEntry) {
    _overlayEntry.remove();
  }

  void _dismissUnique() {
    if (instance._uniqueOverlayEntry != null) {
      instance._uniqueOverlayEntry.remove();
      instance._uniqueOverlayEntry = null;
    }
    instance._uniqueGlobalStateKey = null;
  }
}
