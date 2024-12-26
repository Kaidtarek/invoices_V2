import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_management/materialDesign/constant.dart';
import 'package:invoice_management/widgets/backGround.dart';
import 'package:invoice_management/widgets/button.dart';
import 'package:invoice_management/widgets/textField.dart';

class Editcient extends StatefulWidget {
  String id;
  Editcient({super.key, required this.id});

  @override
  State<Editcient> createState() => _EditcientState();
}

class _EditcientState extends State<Editcient> {
  TextEditingController name = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController mobile = TextEditingController();

  TextEditingController total = TextEditingController();
  TextEditingController vers = TextEditingController();

  bool loading = false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> GetData() async {
    DocumentSnapshot docSnap = await users.doc(widget.id).get();
    if (docSnap.exists) {
      setState(() {
        name.text = docSnap['name'] ?? '';
        address.text = docSnap['address'] ?? '';
        email.text = docSnap['email'] ?? '';
        mobile.text = docSnap['mobile'] ?? '';

        // Handle 'total' and 'vers' based on their type in Firestore
        var totalValue = docSnap['total'];
        var versValue = docSnap['vers'];

        // Ensure you handle the case where these values might be null
        if (totalValue is int) {
          total.text = totalValue.toString();
        } else if (totalValue is double) {
          total.text = totalValue.toStringAsFixed(2);
        }

        if (versValue is int) {
          vers.text = versValue.toString();
        } else if (versValue is double) {
          vers.text = versValue.toStringAsFixed(2);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
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
                            "modification du client ",
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
                              title: "nom"),
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
                          CustomTextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              passedController: vers,
                              title: "versement"),
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
                                      await users.doc(widget.id).update({
                                        "name": name.text,
                                        "address": address.text,
                                        "email": email.text,
                                        "mobile": mobile.text,
                                        "total": double.tryParse(total.text),
                                        "vers": double.tryParse(vers.text)
                                      }).then((value) {
                                        print("Client Added");
                                      }).catchError((error) {
                                        print("Failed to add client: $error");
                                      });
                                      loading = false;
                                      setState(()  {});
                                      AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.rightSlide,
                                        title: 'done ',
                                        desc: "valeur modifiée, appuyez sur OK s'il vous plaît ",
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
                                        title: 'Erreur ',
                                        desc: e.toString(),
                                        btnCancelOnPress: () {
                                          Navigator.of(context).pop();
                                        },
                                      ).show();
                                    }
                                  },
                                  title: "enregistrer modifier",
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
    ));
  }
}
