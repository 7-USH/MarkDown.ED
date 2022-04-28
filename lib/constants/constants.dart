// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color scaffoldColor = Color(0XFF19282F);
Color gradColor = Colors.blueGrey.shade50;

TextStyle editorStyle(
    {required Color color, required FontWeight weight, required double size}) {
  return GoogleFonts.firaCode(color: color, fontWeight: weight, fontSize: size);
}

List<BoxShadow> kBoxShadows = [
  BoxShadow(
      color: Colors.black.withOpacity(0.5),
      offset: const Offset(0.6, 4),
      spreadRadius: 1,
      blurRadius: 8),
  BoxShadow(
      color: Colors.white.withOpacity(0.5),
      offset: const Offset(-2, -4),
      spreadRadius: -1,
      blurRadius: 18),
];

List<BoxShadow> kButtonShadows = [
  BoxShadow(
      color: Colors.black.withOpacity(0.2),
      offset: const Offset(0.6, 4),
      spreadRadius: 1,
      blurRadius: 8)
];
