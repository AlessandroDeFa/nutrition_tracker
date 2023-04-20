import 'package:flutter/cupertino.dart';

class AppTheme {
  static const darkTheme = CupertinoThemeData(
    scaffoldBackgroundColor: Color(0xFF292929),
    primaryColor: Color(0xFF39828D),
    primaryContrastingColor: Color(0xFF3E3D3F),
    brightness: Brightness.dark,
  );

  static const lightTheme = CupertinoThemeData(
    scaffoldBackgroundColor: Color(0xFFF2F2F6),
    primaryColor: Color(0xFF39828D),
    primaryContrastingColor: Color(0xFFC9C8CC),
    brightness: Brightness.light,
  );
}
