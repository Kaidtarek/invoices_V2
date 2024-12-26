import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../materialDesign/constant.dart';

Widget CustomTextField(
    {required TextEditingController passedController, required String title,ValueChanged? onChanged ,bool? setMaxChar}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: paddingSize / 3),
    child: TextFormField(
     maxLength: setMaxChar != null ? 200 : null,
      onChanged: onChanged ,
      textAlign: TextAlign.right,
      controller: passedController,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: title,
        hintStyle: GoogleFonts.cairo(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderGreenColor, width: 1),
            borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}