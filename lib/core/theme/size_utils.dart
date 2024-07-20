
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

MediaQueryData mediaQueryData = MediaQueryData.fromWindow(ui.window);

double baseWidth = 375;
double fem = mediaQueryData.size.width / baseWidth;
double ffem = fem * 0.97;

get width {
  return mediaQueryData.size.width;
}

get height {
  return mediaQueryData.size.height;
}
