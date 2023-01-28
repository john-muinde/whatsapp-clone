import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum MyColors { tealGreen, tealGreenDark, lightGreen, blue }

extension ColorExtension on MyColors {
  String get name => describeEnum(this);
  String get displayTitle {
    switch (this) {
      case MyColors.tealGreen:
        return 'This is teal Green';
      case MyColors.tealGreenDark:
        return 'This is teal Green Dark';
      case MyColors.lightGreen:
        return 'This is light green';
      case MyColors.blue:
        return 'This is blue';
      default:
        return 'MyColors is null';
    }
  }

  Color toColor(String text) {
    var hexString = text;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Color color() {
    switch (this) {
      case MyColors.tealGreen:
        return toColor('#128C7E');
      case MyColors.tealGreenDark:
        return toColor('#075E54');
      case MyColors.lightGreen:
        return toColor('#25D366');
      case MyColors.blue:
        return toColor('#34B7F1');
      default:
        return Colors.transparent;
    }
  }
}
