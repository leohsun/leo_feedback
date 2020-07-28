library leo_feedback;

import 'dart:async';

import 'package:flutter/material.dart';
part './widgets/fadeZoomBox.dart';
part 'feedback_widget.dart';
part 'theme.dart';

class FeedBackHost {
  BuildContext context;

  double fontSize;

  FeedbackBrightness brightness;

  FeedbackThemeData feedBackTheme;

  OverlayEntry _overlayEntry;

  Set<OverlayEntry> _overlayEntries = Set();

  static FeedBackHost instance;


  FeedBackHost._init({BuildContext context,FeedbackBrightness brightness}) {
    instance = this;
    instance.context = context;
    instance.feedBackTheme = FeedbackThemeData(brightness: brightness);
  }

  OverlayEntry _show(Widget child) {
    OverlayEntry _overlayEntry = OverlayEntry(
        builder: (BuildContext ctx) => Container(
          child: child,
        ));
    instance._overlayEntries.add(_overlayEntry);
    Overlay.of(instance.context).insert(_overlayEntry);
    return _overlayEntry;
  }

  void _dismiss(OverlayEntry _overlayEntry) {
    instance._overlayEntry?.remove();
    instance._overlayEntries.contains(_overlayEntry);
    _overlayEntry.remove();
    instance._overlayEntries.remove(_overlayEntry);
  }
}

void showToast(String msg, {Duration duration}) {
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  GlobalKey<_FadeZoomBoxState> _fadeZoomBox = GlobalKey();
  Widget toastWidget = FadeZoomBox(
    key: _fadeZoomBox,
    child: Container(
        decoration: BoxDecoration(
            color: theme.dialogBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: theme.boxShadow
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            '系统错误，请联系管理员',
            style: TextStyle(color: theme.textPrimaryColor),
          ),
        )),
  );
  OverlayEntry _overlayEntry = FeedBackHost.instance._show(toastWidget);

  Duration _duration = duration ?? Duration(seconds: 3);

  Future.delayed(_duration, () async {
    await _fadeZoomBox.currentState.reverseAnimation();
    FeedBackHost.instance._dismiss(_overlayEntry);
  });
}
