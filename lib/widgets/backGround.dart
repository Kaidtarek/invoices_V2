import 'package:flutter/material.dart';

Widget Background(){
  return Image.asset(
            "assets/back.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          );
}
Widget FilterBackGround(){
  return Container(
            color: Colors.black.withOpacity(0.5),
          );
}
