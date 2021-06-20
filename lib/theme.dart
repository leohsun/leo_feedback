part of 'package:leo_feedback/leo_feedback.dart';

class FeedbackThemeData {
  Color? backgroundPrimaryColor;
  Color? backgroundSecondaryColor;
  Color? backgroundTertiaryColor;

  Color? opaqueSeparatorColor;
  Color? nonOpaqueSeparatorColor;

  Color? labelPrimaryColor;
  Color? labelSecondaryColor;
  Color? labelTertiaryColor;
  Color? labelQuarternaryColor;

  Color? fillPrimaryColor;
  Color? fillSecondaryColor;
  Color? fillTertiaryColor;
  Color? fillQuarternaryColor;

  Color? baseRedColor;
  Color? baseOrangeColor;
  Color? baseYellowColor;
  Color? baseGreenColor;
  Color? baseTealColor;
  Color? baseBlueColor;
  Color? baseIndigoColor;
  Color? basePurpleColor;
  Color? basePinkColor;
  Color? baseGreyColor;
  Color? baseGrey2Color;
  Color? baseGrey3Color;
  Color? baseGrey4Color;
  Color? baseGrey5Color;
  Color? baseGrey6Color;

  Color? primaryColor;
  Color? errorColor;
  Color? textPrimaryColor;
  Color? textSecondaryColor;
  Color? textDisabledColor;
  Color? dialogBackgroundColor;
  List<BoxShadow>? boxShadow;
  FeedbackBrightness? brightness;

  FeedbackThemeData({this.brightness}) {
    brightness ??= FeedbackBrightness.dark;
    final bool isDark = brightness == FeedbackBrightness.dark;
    backgroundPrimaryColor = isDark ? Colors.black : Colors.white;
    backgroundSecondaryColor = isDark
        ? Color.fromRGBO(28, 28, 30, 1)
        : Color.fromRGBO(242, 242, 247, 1);
    backgroundTertiaryColor =
        isDark ? Color.fromRGBO(44, 44, 46, 1) : Colors.white;

    opaqueSeparatorColor = isDark
        ? Color.fromRGBO(56, 56, 58, 1)
        : Color.fromRGBO(198, 198, 200, 1);
    nonOpaqueSeparatorColor = isDark
        ? Color.fromRGBO(84, 84, 88, 0.65)
        : Color.fromRGBO(60, 60, 67, 0.36);

    labelPrimaryColor = isDark ? Colors.white : Colors.black;
    labelSecondaryColor = isDark
        ? Color.fromRGBO(235, 235, 245, 0.6)
        : Color.fromRGBO(60, 60, 67, 0.6);
    labelTertiaryColor = isDark
        ? Color.fromRGBO(235, 235, 245, 0.3)
        : Color.fromRGBO(60, 60, 67, 0.3);
    labelQuarternaryColor = isDark
        ? Color.fromRGBO(235, 235, 245, 0.18)
        : Color.fromRGBO(60, 60, 67, 0.18);

    fillPrimaryColor = isDark
        ? Color.fromRGBO(120, 120, 128, 0.36)
        : Color.fromRGBO(120, 120, 128, 0.2);
    fillSecondaryColor = isDark
        ? Color.fromRGBO(120, 120, 128, 0.32)
        : Color.fromRGBO(120, 120, 128, 0.16);
    fillTertiaryColor = isDark
        ? Color.fromRGBO(120, 120, 128, 0.24)
        : Color.fromRGBO(120, 120, 128, 0.12);
    fillQuarternaryColor = isDark
        ? Color.fromRGBO(120, 120, 128, 0.18)
        : Color.fromRGBO(120, 120, 128, 0.08);

    baseRedColor = isDark
        ? Color.fromRGBO(255, 69, 58, 1)
        : Color.fromRGBO(255, 69, 48, 1);
    baseOrangeColor = isDark
        ? Color.fromRGBO(255, 159, 10, 1)
        : Color.fromRGBO(255, 149, 0, 1);
    baseYellowColor = isDark
        ? Color.fromRGBO(255, 214, 10, 1)
        : Color.fromRGBO(255, 204, 0, 1);
    baseGreenColor = isDark
        ? Color.fromRGBO(50, 215, 75, 1)
        : Color.fromRGBO(52, 199, 89, 1);
    baseTealColor = isDark
        ? Color.fromRGBO(100, 210, 255, 1)
        : Color.fromRGBO(90, 200, 250, 1);
    baseBlueColor = isDark
        ? Color.fromRGBO(10, 132, 255, 1)
        : Color.fromRGBO(0, 122, 255, 1);
    baseIndigoColor = isDark
        ? Color.fromRGBO(94, 92, 230, 1)
        : Color.fromRGBO(88, 86, 214, 1);
    basePurpleColor = isDark
        ? Color.fromRGBO(191, 90, 242, 1)
        : Color.fromRGBO(175, 82, 222, 1);
    basePinkColor = isDark
        ? Color.fromRGBO(255, 55, 95, 1)
        : Color.fromRGBO(255, 45, 85, 1);
    baseGreyColor = isDark
        ? Color.fromRGBO(142, 142, 147, 1)
        : Color.fromRGBO(142, 142, 147, 1);
    baseGrey2Color = isDark
        ? Color.fromRGBO(99, 99, 102, 1)
        : Color.fromRGBO(147, 147, 178, 1);
    baseGrey3Color = isDark
        ? Color.fromRGBO(72, 72, 74, 1)
        : Color.fromRGBO(199, 199, 204, 1);
    baseGrey4Color = isDark
        ? Color.fromRGBO(58, 58, 60, 1)
        : Color.fromRGBO(209, 209, 214, 1);
    baseGrey5Color = isDark
        ? Color.fromRGBO(44, 44, 46, 1)
        : Color.fromRGBO(229, 229, 234, 1);
    baseGrey6Color = isDark
        ? Color.fromRGBO(28, 28, 30, 1)
        : Color.fromRGBO(242, 242, 247, 1);

    dialogBackgroundColor = isDark
        ? Color.fromRGBO(30, 30, 30, 0.99)
        : Color.fromRGBO(242, 242, 242, .99);

    errorColor = isDark
        ? Color.fromRGBO(207, 102, 121, 1.000)
        : Color.fromRGBO(176, 1, 32, 1.000);

    boxShadow = [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.14),
          offset: Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0),
    ];
  }
}
