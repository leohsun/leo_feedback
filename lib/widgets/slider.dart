part of 'package:leo_feedback/leo_feedback.dart';

class Slider extends StatefulWidget {
  final SliderDirection direction;
  final Widget child;
  final Duration duration;
  final bool closeOnClickMask;
  final bool noMask;

  const Slider({Key key, this.direction, this.child, this.duration, this.closeOnClickMask = false, this.noMask = false})
      : super(key: key);
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: widget.duration ?? 300));

    _slide = Tween<double>(begin: -1, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FeedBackHost.instance._shouldCallAfterSliderWidgetCreatedFunctions.length > 0) {
        FeedBackHost.instance._shouldCallAfterSliderWidgetCreatedFunctions.forEach((cb) {
          cb();
        });
        FeedBackHost.instance._shouldCallAfterSliderWidgetCreatedFunctions.clear();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future reverseAnimation() => _controller.reverse();

  void _handleMaskTab() {
    if (widget.closeOnClickMask) {
      hideSlider();
    }
  }

  @override
  Widget build(BuildContext context) {
    SliderDirection _direction = widget.direction ?? SliderDirection.top;
    bool isDark = FeedBackHost.instance.brightness == FeedbackBrightness.dark;
    Offset _offset;

    switch (_direction) {
      case SliderDirection.left:
        _offset = Offset(_slide.value, 0);
        break;
      case SliderDirection.top:
        _offset = Offset(0, _slide.value);
        break;
      case SliderDirection.right:
        _offset = Offset((_slide.value.abs()), 0);
        break;
      case SliderDirection.bottom:
        _offset = Offset(0, _slide.value.abs());
        break;
    }

    return Stack(
      children: <Widget>[
        widget.noMask
            ? SizedBox()
            : Positioned.fill(
                child: GestureDetector(
                onTap: _handleMaskTab,
                child: Container(
                  color: isDark ? Colors.white.withOpacity(0.15) : Colors.black.withOpacity(0.15),
                ),
              )),
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: FractionalTranslation(translation: _offset, child: widget.child))
      ],
    );
  }
}
