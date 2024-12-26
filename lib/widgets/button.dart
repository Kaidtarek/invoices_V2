import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../materialDesign/constant.dart';

Widget CustomValidateButton(
    {required VoidCallback onPress, required String title, IconData? icon, required Color color}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(color: Colors.white,fontSize: 20),
          ),
          const SizedBox(
            width: 5,
          ),
          icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : Container()
        ],
      ),
    ),
  );
}