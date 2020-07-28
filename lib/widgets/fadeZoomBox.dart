part of 'package:leo_feedback/leo_feedback.dart';

class FadeZoomBox extends StatefulWidget {
  final Widget child;

  const FadeZoomBox({Key key, this.child}) : super(key: key);
  @override
  _FadeZoomBoxState createState() => _FadeZoomBoxState();
}

class _FadeZoomBoxState extends State<FadeZoomBox>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  Future reverseAnimation() async {
    await controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut))
          ..addListener(() {
            setState(() {});
          });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Opacity(
        opacity: animation.value,
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}
