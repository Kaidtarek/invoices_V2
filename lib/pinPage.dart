import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:invoice_management/main.dart';
import 'package:invoice_management/materialDesign/constant.dart';
import 'package:invoice_management/widgets/backGround.dart';
import 'package:invoice_management/widgets/button.dart';
import 'package:invoice_management/widgets/textField.dart';

class PinPage extends StatefulWidget {
  PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  TextEditingController pin1 = TextEditingController();

  TextEditingController pin2 = TextEditingController();

  TextEditingController pin3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Background(),
      FilterBackGround(),
      Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 500,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: bgColor.withOpacity(0.3)),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    CustomTextField(
                      passedController: pin1,
                      title: "pin 1",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CustomTextField(
                      passedController: pin2,
                      title: "pin 2",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CustomTextField(
                      passedController: pin3,
                      title: "pin 3",
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    CustomValidateButton(
                        onPress: () {
                          pin1.text == "123" &&
                                  pin2.text == "123" &&
                                  pin3.text == "123"
                              ? AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: ' Sir ',
                                  desc: 'good luck',
                                  btnOkOnPress: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                GetStart()));
                                  },
                                ).show()
                              : AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: ' les information pas vrai ',
                                  desc: 'retaper les information',
                                  btnOkOnPress: () {},
                                ).show();
                        },
                        title: "Login",
                        color: customPurpulColor),
                    Center(
                      child: Image.asset(
                        "assets/logo.png",
                        height: MediaQuery.of(context).size.width / 6,
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
        ),
      )
    ]));
  }
}
