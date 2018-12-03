import 'package:flutter/material.dart';

final List<LinearGradient> gradientList = [
  getGradient(0xFF009E00, 0xFFFFFF96),
  getGradient(0xFFD4145A, 0xFFFBB03B),
  getGradient(0xFFED1E79, 0xFF662D8C),
  getGradient(0xFF667EEA, 0xFF764BA2),
  getGradient(0xFFD74177, 0xFFFFE98A),
  getGradient(0xFF2E3192, 0xFF1BFFFF),
  getGradient(0xFFB066FE, 0xFF63E2FF),
  getGradient(0xFF009245, 0xFFFCEE21),
  getGradient(0xFF8E78FF, 0xFFFC7D7B),
  getGradient(0xFF3A3897, 0xFFA3A1FF),
  getGradient(0xFF312A6C, 0xFF852D91),
  getGradient(0xFF333333, 0xFF5A5454),
];

LinearGradient getGradient(int begin, int end) {
  return LinearGradient(
      colors: [Color(begin), Color(end)],
      begin: FractionalOffset(0.0, 0.5),
      end: FractionalOffset(0.5, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.mirror);
}
