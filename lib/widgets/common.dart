part of 'package:leo_feedback/leo_feedback.dart';

Widget buildBlurWidget({Widget child, BorderRadius borderRadius}) {
  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(12),
    child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 0,
        sigmaY: 0,
      ),
      child: child,
    ),
  );
}

Widget buildButtonWidget(
    {@required Widget child,
    VoidCallback onPress,
    BorderRadius borderRadius,
    Color color}) {
  Color _color = color ?? Colors.transparent;
  return Material(
    color: _color,
    child: InkWell(
      splashColor: FeedBackHost.instance.feedBackTheme.baseGrey3Color,
      highlightColor: Colors.transparent,
      borderRadius: borderRadius,
      child: child,
      onTap: onPress,
    ),
  );
}
