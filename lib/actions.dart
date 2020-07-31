part of 'package:leo_feedback/leo_feedback.dart';

void showToast(String msg, {Duration duration}) {
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  GlobalKey<_FadeZoomBoxState> _fadeZoomBox = GlobalKey();
  Widget toastWidget = FadeZoomBox(
    key: _fadeZoomBox,
    child: Container(
        constraints: BoxConstraints(
          maxWidth: 170,
        ),
        decoration: BoxDecoration(
            color: theme.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: theme.boxShadow),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            msg ?? 'hi you!',
            style: TextStyle(color: theme.labelPrimaryColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        )),
  );
  OverlayEntry _overlayEntry =
      FeedBackHost.instance._show(toastWidget, cover: false);

  Duration _duration = duration ?? Duration(seconds: 3);

  Future.delayed(_duration, () async {
    await _fadeZoomBox.currentState.reverseAnimation();
    FeedBackHost.instance._dismiss(_overlayEntry);
  });
}

void showLoading({String title}) {
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  FeedBackHost.instance._uniqueGlobalStateKey = GlobalKey();
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
                        title ?? '数据加载中',
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
  FeedBackHost.instance._show(toastWidget, unique: true);
}

void hideLoading() async {
  await (FeedBackHost.instance._uniqueGlobalStateKey.currentState
          as _FadeZoomBoxState)
      ?.reverseAnimation();
  FeedBackHost.instance._dismissUnique();
}

void showAlert(
    {String title,
    String content,
    AlertType type,
    VoidCallback onCancel,
    VoidCallback onConfirm}) async {
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  FeedBackHost.instance._uniqueGlobalStateKey = GlobalKey();
  final double _width = 270;
  final double _bottomHeight = 44;

  AlertType _type = type ?? AlertType.normal;

  void _dismissAlert() async {
    await (FeedBackHost.instance._uniqueGlobalStateKey.currentState
            as _FadeZoomBoxState)
        ?.reverseAnimation();
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
                      title ?? '提示',
                      style: TextStyle(
                          color: theme.labelPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      content ?? '正文内容',
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
  FeedBackHost.instance._show(toastWidget, unique: true);
}

void showMessage(String message,
    {MessageType type, Duration duration, VoidCallback onPress}) {
  FeedbackThemeData theme = FeedBackHost.instance.feedBackTheme;
  GlobalKey<_SliderState> _slider = GlobalKey<_SliderState>();
  Duration _duration = duration ?? Duration(seconds: 3);
  MessageType _type = type ?? MessageType.info;
  IconData _icon;
  Color _bgColor;
  String _msg = message ?? '...';
  switch (_type) {
    case MessageType.success:
      _icon = Icons.check_circle_outline;
      _bgColor = theme.baseGreenColor;
      break;
    case MessageType.error:
      _icon = Icons.highlight_off;
      _bgColor = theme.baseRedColor;
      break;
    case MessageType.warning:
      _icon = Icons.remove_circle;
      _bgColor = theme.baseOrangeColor;
      break;
    case MessageType.info:
      _icon = Icons.info_outline;
      _bgColor = theme.baseTealColor;
      break;
  }
  Widget messageWidget = Slider(
    key: _slider,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Stack(
        children: <Widget>[
          buildBlurWidget(
              child: Container(
                  height: 60,
                  decoration: BoxDecoration(
//                      color: _bgColor,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: theme.boxShadow))),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: buildButtonWidget(
                color: _bgColor,
                borderRadius: BorderRadius.circular(14),
                onPress: onPress,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                              color: Colors.white, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      )
                    ],
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

  Future.delayed(_duration, () async {
    await _slider.currentState.reverseAnimation();
    FeedBackHost.instance._dismiss(messageOverlayEntry);
  });
}
