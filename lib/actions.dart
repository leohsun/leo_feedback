part of 'package:leo_feedback/leo_feedback.dart';

void showToast(String? msg, {Duration? duration}) {
  final FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  final GlobalKey<_FadeZoomBoxState> _fadeZoomBox =
      GlobalKey(debugLabel: 'toast key');
  Widget toastWidget = FadeZoomBox(
    key: _fadeZoomBox,
    child: Container(
        constraints: BoxConstraints(
          minWidth: 170,
        ),
        decoration: BoxDecoration(
            color: theme.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: theme.boxShadow),
        child: buildBlurWidget(
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              msg ?? 'hi you!',
              style: TextStyle(color: theme.labelPrimaryColor),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )),
  );
  OverlayEntry _overlayEntry =
      FeedBackHost.instance._show(toastWidget, cover: false);

  Duration _duration = duration ?? Duration(seconds: 3);

  Future.delayed(_duration, () async {
    await _fadeZoomBox.currentState!.reverseAnimation();
    FeedBackHost.instance._dismiss(_overlayEntry);
  });
}

void showLoading(
    {String title = 'none', Duration? duration, bool cover = true}) {
  if (FeedBackHost.instance._uniqueGlobalStateKey ==
      FeedBackHost._loadingGlobalKey) return;
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  FeedBackHost.instance._uniqueGlobalStateKey = FeedBackHost._loadingGlobalKey;
  bool showTitle = title != 'none';

  Widget toastWidget = FadeZoomBox(
    key: FeedBackHost.instance._uniqueGlobalStateKey,
    child: Container(
      width: 120,
      height: 120,
      child: Stack(
        children: <Widget>[
          buildBlurWidget(
              child: Container(
            decoration: BoxDecoration(
              color: theme.dialogBackgroundColor,
              borderRadius: BorderRadius.circular(14),
//          boxShadow: theme.boxShadow,
            ),
          )),
          Positioned.fill(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Indicator(),
                SizedBox(
                  height: showTitle ? 15 : 0,
                ),
                showTitle
                    ? Text(
                        title,
                        style: TextStyle(color: theme.labelPrimaryColor),
                      )
                    : SizedBox()
              ],
            ),
          ))
        ],
      ),
    ),
  );
  FeedBackHost.instance._show(toastWidget, unique: true, cover: cover);

  if (duration != null) {
    Future.delayed(duration).then((value) => hideLoading());
  }
  print('show end');
}

void hideLoading() async {
  if (FeedBackHost.instance._uniqueGlobalStateKey !=
      FeedBackHost._loadingGlobalKey) return;
  //  do it after loading widget was created;
  if (!FeedBackHost.instance.fadeZoomBoxCreated) {
    FeedBackHost.instance._shouldCallAfterFadeZoomBoxWidgetCreatedFunctions
        .add(() async {
      bool isLoadingOpened = FeedBackHost.instance._uniqueGlobalStateKey !=
              FeedBackHost._defaultUniqueGlobalKey &&
          FeedBackHost
                  .instance._uniqueGlobalStateKey.currentState.runtimeType ==
              _FadeZoomBoxState;
      if (!isLoadingOpened) return;
      await (FeedBackHost.instance._uniqueGlobalStateKey.currentState
              as _FadeZoomBoxState)
          .reverseAnimation();

      FeedBackHost.instance._dismissUnique();
    });
  } else {
    await (FeedBackHost.instance._uniqueGlobalStateKey.currentState
            as _FadeZoomBoxState)
        .reverseAnimation();

    FeedBackHost.instance._dismissUnique();
  }
}

void noop() {}

void showAlert(
    {String? title,
    required String content,
    AlertType? type,
    VoidCallback? onCancel,
    VoidCallback? onConfirm}) async {
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  FeedBackHost.instance._uniqueGlobalStateKey =
      GlobalKey(debugLabel: 'alert key');
  print(FeedBackHost.instance);
  final double _width = 270;
  final double _bottomHeight = 44;
  final String _title = (title != null && title.isNotEmpty) ? title : '提示';

  AlertType _type = type ?? AlertType.normal;

  void _dismissAlert() async {
    print(FeedBackHost.instance._uniqueGlobalStateKey);
    if (FeedBackHost.instance._uniqueGlobalStateKey.currentState != null) {
      await (FeedBackHost.instance._uniqueGlobalStateKey.currentState
              as _FadeZoomBoxState)
          .reverseAnimation();
    }
    FeedBackHost.instance._dismissUnique();
  }

  void _closeAlert() async {
    _dismissAlert();
    if (onCancel != null) onCancel();
  }

  void _onConfirm() {
    _dismissAlert();
    if (onConfirm != null) onConfirm();
  }

  Widget _buildBottomWidget() {
    if (_type == AlertType.confirm)
      return Row(
        children: <Widget>[
          Expanded(
            child: buildButtonWidget(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(14)),
                child: Container(
                  height: _bottomHeight,
                  child: Center(
                    child: Text(
                      '取消',
                      style: TextStyle(
                          fontSize: 20, color: theme.labelSecondaryColor),
                    ),
                  ),
                ),
                onPress: _closeAlert),
          ),
          Container(
            height: _bottomHeight,
            width: 1,
            color: theme.nonOpaqueSeparatorColor,
          ),
          Expanded(
            child: buildButtonWidget(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(14)),
                child: Container(
                  height: _bottomHeight,
                  child: Center(
                    child: Text(
                      '确定',
                      style:
                          TextStyle(fontSize: 20, color: theme.baseBlueColor),
                    ),
                  ),
                ),
                onPress: _onConfirm),
          ),
        ],
      );

//    default --> AlertType.normal
    return buildButtonWidget(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14)),
        child: Container(
          width: _width,
          height: _bottomHeight,
          child: Center(
            child: Text(
              '确定',
              style: TextStyle(fontSize: 20, color: theme.baseBlueColor),
            ),
          ),
        ),
        onPress: _closeAlert);
  }

  Widget toastWidget = FadeZoomBox(
    key: FeedBackHost.instance._uniqueGlobalStateKey,
    child: Container(
      width: _width,
      height: 140,
      child: Stack(
        children: <Widget>[
          buildBlurWidget(
              child: Container(
            decoration: BoxDecoration(
                color: theme.dialogBackgroundColor,
                borderRadius: BorderRadius.circular(14)),
          )),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 19, bottom: 21),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _title,
                      style: TextStyle(
                          color: theme.labelPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      content,
                      style: TextStyle(
                          color: theme.labelPrimaryColor, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: theme.nonOpaqueSeparatorColor,
              ),
              _buildBottomWidget()
            ],
          ))
        ],
      ),
    ),
  );
  HapticFeedback.lightImpact();
  FeedBackHost.instance._show(toastWidget, unique: true);
}

void showMessage(String message,
    {MessageType type = MessageType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback onPress = noop}) {
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  GlobalKey<_SliderState> _slider = GlobalKey<_SliderState>();
  IconData _icon;
  Color _bgColor;
  final String _msg = message;
  switch (type) {
    case MessageType.success:
      _icon = Icons.check_circle_outline;
      _bgColor = theme.baseGreenColor!;
      break;
    case MessageType.error:
      _icon = Icons.highlight_off;
      _bgColor = theme.baseRedColor!;
      HapticFeedback.lightImpact();
      break;
    case MessageType.warning:
      _icon = Icons.remove_circle;
      _bgColor = theme.baseOrangeColor!;
      HapticFeedback.lightImpact();
      break;
    case MessageType.info:
      _icon = Icons.info_outline;
      _bgColor = theme.baseTealColor!;
      break;
  }
  Widget messageWidget = Slider(
    key: _slider,
    noMask: true,
    child: Padding(
      padding:
          EdgeInsets.only(left: 8, right: 8, top: Platform.isAndroid ? 24 : 40),
      child: Stack(
        children: <Widget>[
          buildBlurWidget(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: buildButtonWidget(
                color: _bgColor,
                borderRadius: BorderRadius.circular(14),
                onPress: onPress,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Container(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          _icon,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            _msg,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
//                              overflow: TextOverflow.fade,
                            maxLines: 2,
//                              softWrap: false,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  OverlayEntry messageOverlayEntry =
      FeedBackHost.instance._show(messageWidget, cover: false);

  Future.delayed(duration, () async {
    await _slider.currentState!.reverseAnimation();
    FeedBackHost.instance._dismiss(messageOverlayEntry);
  });
}

void showSlider(
    {required Widget child,
    Duration? duration,
    required SliderDirection direction,
    bool? closeOnClickMask,
    bool? autoClose}) async {
  assert(
      (autoClose != true && closeOnClickMask == true) ||
          (autoClose == true && closeOnClickMask != true) ||
          (autoClose != true && closeOnClickMask != true),
      'property autoClose or closeOnClickMask can not be the same value "true of boolean"');
  GlobalKey<_SliderState> _sliderKey = GlobalKey<_SliderState>();

  bool _autoClose = autoClose ?? false;
  bool _closeOnClickMask = closeOnClickMask ?? false;

  Duration _duration = duration ?? Duration(milliseconds: 3000);

  Widget _slider = Slider(
    key: _sliderKey,
    child: child,
    closeOnClickMask: _closeOnClickMask,
    direction: direction,
  );

  OverlayEntry sliderEntry;

  if (_autoClose) {
    sliderEntry = FeedBackHost.instance._show(_slider);
    Future.delayed(_duration, () async {
      await _sliderKey.currentState!.reverseAnimation();
      FeedBackHost.instance._dismiss(sliderEntry);
    });
  } else {
    FeedBackHost.instance._sliderKeysSet.add(_sliderKey);
    sliderEntry = FeedBackHost.instance._show(_slider, isSlider: true);
  }
}

void hideSlider() async {
  bool isSliderOpened = FeedBackHost.instance._sliderKeysSet.length > 0 &&
      FeedBackHost.instance._sliderKeysSet.last.runtimeType != Null;
  if (!isSliderOpened) {
    FeedBackHost.instance._shouldCallAfterSliderWidgetCreatedFunctions
        .add(() async {
      await (FeedBackHost.instance._sliderKeysSet.last.currentState
              as _SliderState)
          .reverseAnimation();
      FeedBackHost.instance._sliderOverlayEntrySet.last.remove();
      FeedBackHost.instance._sliderOverlayEntrySet
          .remove(FeedBackHost.instance._sliderOverlayEntrySet.last);
      FeedBackHost.instance._sliderKeysSet
          .remove(FeedBackHost.instance._sliderKeysSet.last);
    });
  } else {
    await (FeedBackHost.instance._sliderKeysSet.last.currentState
            as _SliderState)
        .reverseAnimation();
    FeedBackHost.instance._sliderOverlayEntrySet.last.remove();
    FeedBackHost.instance._sliderOverlayEntrySet
        .remove(FeedBackHost.instance._sliderOverlayEntrySet.last);
    FeedBackHost.instance._sliderKeysSet
        .remove(FeedBackHost.instance._sliderKeysSet.last);
  }
}

void hideSliderAll() {
  bool isSliderOpened = FeedBackHost.instance._sliderKeysSet.length > 0;
  if (!isSliderOpened) return;
  FeedBackHost.instance._sliderOverlayEntrySet.forEach((OverlayEntry slider) {
    slider.remove();
  });
  FeedBackHost.instance._sliderOverlayEntrySet.clear();
  FeedBackHost.instance._sliderKeysSet.clear();
}
