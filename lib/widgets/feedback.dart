part of 'package:leo_feedback/leo_feedback.dart';

class LeoFeedBack extends StatefulWidget {
  final Widget child;
  final FeedbackBrightness brightness;
  final double designWidth;

  const LeoFeedBack(
      {Key? key,
      this.brightness = FeedbackBrightness.light,
      required this.child,
      required this.designWidth})
      : super(key: key);

  @override
  _LeoFeedBackState createState() => _LeoFeedBackState();
}

class _LeoFeedBackState extends State<LeoFeedBack> {
  FeedbackBrightness _brightness = FeedbackBrightness.light;

  @override
  void initState() {
    _brightness = widget.brightness;
    super.initState();
  }

  @override
  void didUpdateWidget(LeoFeedBack oldWidget) {
    if (widget.brightness != _brightness) _brightness = widget.brightness;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      child: Overlay(
        initialEntries: [
          OverlayEntry(builder: (BuildContext context) {
            FeedBackHost._init(
                context: context,
                brightness: _brightness,
                designWidth: widget.designWidth);
            return widget.child;
          })
        ],
      ),
      textDirection: TextDirection.ltr,
    );
  }
}
