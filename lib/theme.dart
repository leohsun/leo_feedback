part of 'package:leo_feedback/leo_feedback.dart';

enum FeedbackBrightness { dark, light }

class FeedbackThemeData {
  Color backgroundColor;
  Color primaryColor;
  Color errorColor;
  Color textPrimaryColor;
  Color textSecondaryColor;
  Color textDisabledColor;
  Color dialogBackgroundColor;
  List<BoxShadow> boxShadow;
  FeedbackBrightness brightness;

  FeedbackThemeData({this.brightness}) {
    brightness ??= FeedbackBrightness.dark;
    final bool isDark = brightness == FeedbackBrightness.dark;
    backgroundColor = isDark ? Color.fromRGBO(18, 18, 18, 1.000) : Colors.white;
    primaryColor = isDark ? Color.fromRGBO(31, 26, 36, 1) : Colors.black;
    errorColor = isDark
        ? Color.fromRGBO(207, 102, 121, 1.000)
        : Color.fromRGBO(176, 1, 32, 1.000);
    textPrimaryColor = isDark
        ? Colors.white.withOpacity(0.87)
        : Colors.black.withOpacity(0.87);
    textSecondaryColor = isDark
        ? Colors.white.withOpacity(0.60)
        : Colors.black.withOpacity(0.60);
    textDisabledColor = isDark
        ? Colors.white.withOpacity(0.38)
        : Colors.black.withOpacity(0.38);
    dialogBackgroundColor =
        isDark ? Color.fromRGBO(55, 55, 55, 55) : Colors.white;
    boxShadow = isDark
        ? [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.14),
                offset: Offset(24, 38),
                blurRadius: 38,
                spreadRadius: 3),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                offset: Offset(0, 9),
                blurRadius: 46,
                spreadRadius: 8),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.20),
                offset: Offset(0, 11),
                blurRadius: 15,
                spreadRadius: 0)
          ]
        : [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.14),
                offset: Offset(0, 24),
                blurRadius: 38,
                spreadRadius: 3),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                offset: Offset(0, 9),
                blurRadius: 46,
                spreadRadius: 8),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.20),
                offset: Offset(0, 11),
                blurRadius: 15,
                spreadRadius: -7)
          ];
  }
}
