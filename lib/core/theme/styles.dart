import 'package:flutter/material.dart';

const dynamic fontRegular = 'Regular';
const dynamic fontBold = 'Bold';
const dynamic fontSemiBold = 'SemiBold';
const dynamic fontMedium = 'Medium';
const dynamic mediumNumberFont = 'NumberMedium';

TextStyle fontStyle(
    {double fontSize = 16,
    dynamic fontFamily = fontRegular,
    Color color = const Color.fromRGBO(0, 54, 72, 1),
    bool isBold = false,
    bool isSemiBold = false,
    bool isfontLight = false,
    bool isMediumNumberFont = false,
    bool isMediumFont = false}) {
  return TextStyle(
    fontSize: fontSize - 1,
    fontFamily: isMediumNumberFont ? fontMedium : isMediumFont ? fontMedium : isBold ? fontMedium : fontRegular,
    color: color,
    fontWeight: isSemiBold ? FontWeight.w600 : isBold ? FontWeight.w700 : null
  );
}
