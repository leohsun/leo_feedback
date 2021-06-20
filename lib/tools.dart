part of 'package:leo_feedback/leo_feedback.dart';

double size(double size) {
  return size * FeedBackHost.instance.ratio;
}

Color hex(String color) {
  String _color = color.trim();
  if (_color.startsWith('#')) {
    if (_color.length == 7) {
      return Color(int.parse('0xff${_color.replaceFirst(RegExp(r'#'), '')}'));
    }

    if (_color.length == 9) {
      String opacity = _color.substring(7);
      String rgb = _color.substring(1, 7);
      return Color(int.parse('0x$opacity$rgb'));
    }
  }

  return Colors.red;
}

class DelayTween extends Tween<double> {
  DelayTween({required double begin, required double end, this.delay = 0.0})
      : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
}
