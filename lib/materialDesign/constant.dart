import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color bgColor = Color(0xFFD9D9D9);
final Color borderColor = Colors.black.withOpacity(0.2);
final Color buttonColor = Color(0xFFFFFFFF);
final Color customPurpulColor = Color(0xFF3E3E68);
final Color borderGreenColor = Color(0xFF3EB86F);
final Color storeTitleColor = Color(0xFFA1A1A1);
final Color storeBackGroundColor = Color(0xFFEEEEEE);
final Color blueBodyTextColor = Color(0xFF5973DE);
final Color removeRed = Colors.red.withOpacity(0.5);
final Color redBodyTextColor = Color(0xFFFF4155);
const double paddingSize = 30.0;
InputDecoration decorationInput = InputDecoration(
  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  hintText: "Entrez le nom",
  hintStyle: GoogleFonts.cairo(),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderGreenColor, width: 1),
      borderRadius: BorderRadius.circular(20)),
);
