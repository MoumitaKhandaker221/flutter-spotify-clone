import 'package:flutter/material.dart';

class ColorConstants {
   //static Color starterWhite = hexToColor('#DADADA');
   //static Color primaryColor = hexToColor('#1ED760');
  static Color cardBackGroundColor = hexToColor('#0E0E0F');
  static Color inputHintColor = hexToColor('#FFFFFF');
  static Color primaryColor = hexToColor("#DE3163");
  static final Color starterWhite = Colors.white;
  static Color colorPrimary() {
    return Color(0xFFFC6011);
  }
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) + (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
