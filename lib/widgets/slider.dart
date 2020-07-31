part of 'package:leo_feedback/leo_feedback.dart';

class Slider extends StatefulWidget {
  final SliderDirection direction;
  final Widget child;

  const Slider({Key key, this.direction, this.child}) : super(key: key);
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation _slide;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _slide = Tween<double>(begin: -1, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future reverseAnimation() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    Widget _child = widget.child ??
        Container(
          height: 30,
          color: Colors.green,
        );

    return Stack(
      children: <Widget>[
        Positioned(
            left: 0,
            top: Platform.isAndroid ? 24 : 40,
            right: 0,
            child: FractionalTranslation(
                translation: Offset(0, _slide.value), child: _child))
      ],
    );
  }
}
