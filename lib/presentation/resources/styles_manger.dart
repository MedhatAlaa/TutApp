import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/font_manger.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontWeight: fontWeight,
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    color: color,
  );
}

/// Regular Style
TextStyle getRegularStyle(
    {double fontSize = FontSizeManger.size12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.regular, color);
}

/// Medium Style
TextStyle getMediumStyle(
    {double fontSize = FontSizeManger.size12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.medium, color);
}

/// Light Style
TextStyle getLightStyle(
    {double fontSize = FontSizeManger.size12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.light, color);
}

/// SemiBold Style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSizeManger.size12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.semiBold, color);
}

/// Bold Style
TextStyle getBoldStyle(
    {double fontSize = FontSizeManger.size12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.bold, color);
}
