import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color scaffoldColor = Colors.black54;
Color gradColor = Colors.blueGrey.shade50;

TextStyle editorStyle(
    {required Color color, required FontWeight weight, required double size}) {
  return GoogleFonts.firaCode(color: color, fontWeight: weight, fontSize: size);
}
