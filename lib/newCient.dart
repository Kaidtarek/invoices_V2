import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_management/materialDesign/constant.dart';
import 'package:invoice_management/widgets/backGround.dart';
import 'package:invoice_management/widgets/button.dart';
import 'package:invoice_management/widgets/textField.dart';

class NewCilentPage extends StatefulWidget {
  NewCilentPage({super.key});

  @override
  State<NewCilentPage> createState() => _NewCilentPageState();
}

class _NewCilentPageState extends State<NewCilentPage> {
  TextEditingController name = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController mobile = TextEditingController();

  TextEditingController total = TextEditingController();
  bool loading = false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          FilterBackGround(),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 700,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: bgColor.withOpacity(0.3)),
                  child: Container(
                    width: 500,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "Add new clien",
                            style: GoogleFonts.cairo(
                                color: customPurpulColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          )),
                          CustomTextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              passedController: name,
                              title: "name"),
                          CustomTextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              passedController: address,
                              title: "address"),
                          CustomTextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              passedController: mobile,
                              title: "mobile"),
                          CustomTextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              passedController: email,
                              title: "email"),
                          CustomTextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              passedController: total,
                              title: "total"),
                          name.text.isNotEmpty &&
                                  address.text.isNotEmpty &&
                                  mobile.text.isNotEmpty &&
                                  email.text.isNotEmpty &&
                                  total.text.isNotEmpty
                              ? CustomValidateButton(
                                  color: customPurpulColor,
                                  onPress: () async {
                                    loading = true;
                                    setState(() {});
                                    try {
                                      double? totalValue =
                                          double.tryParse(total.text);
                                      await users.add({
                                        "name": name.text,
                                        "address": address.text,
                                        "email": email.text,
                                        "mobile": mobile.text,
                                        "total": totalValue,
                                        "vers": 0
                                      }).then((value) {
                                        print("Client Added");
                                      }).catchError((error) {
                                        print("Failed to add client: $error");
                                      });
                                      loading = false;
                                      setState(() {});
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.rightSlide,
                                        title: 'done ',
                                        desc: 'user added, press OK please ',
                                        btnOkOnPress: () {
                                          Navigator.of(context).pop();
                                        },
                                      ).show();
                                    } catch (e) {
                                      loading = false;
                                      setState(() {});
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        animType: AnimType.rightSlide,
                                        title: 'Error ',
                                        desc: e.toString(),
                                        btnCancelOnPress: () {
                                          Navigator.of(context).pop();
                                        },
                                      ).show();
                                    }
                                  },
                                  title: "Submit Client",
                                )
                              : Container(),
                          SizedBox(height: 15),
                          CustomValidateButton(
                              onPress: () {
                                Navigator.of(context).pop();
                              },
                              title: "Home Page",
                              color: removeRed),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          loading
              ? Center(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text(
                          """wait add user,if it take long time check network without exit this page""",
                          style: GoogleFonts.cairo(
                              color: customPurpulColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
