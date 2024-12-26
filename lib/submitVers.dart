import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invoice_management/materialDesign/constant.dart';
import 'package:invoice_management/widgets/backGround.dart';
import 'package:invoice_management/widgets/button.dart';
import 'package:invoice_management/widgets/textField.dart';

import 'printing/printCode.dart';

class Submitvers extends StatefulWidget {
  final String id;
  Submitvers({super.key, required this.id});

  @override
  State<Submitvers> createState() => _SubmitversState();
}

class _SubmitversState extends State<Submitvers> {
  String? name, address, email, mobile;
  String? total, vers;
  TextEditingController submitValue = TextEditingController();
  TextEditingController message = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference facture =
      FirebaseFirestore.instance.collection('factureCounter');
  int? factureNumber;
  @override
  void initState() {
    super.initState();
    GetData();
    getFactureNumber();
  }

  Future<void> GetData() async {
    try {
      print("The uid is ${widget.id}");
      DocumentSnapshot docSnap = await users.doc(widget.id).get();
      if (docSnap.exists) {
        setState(() {
          name = docSnap['name'] ?? '';
          address = docSnap['address'] ?? '';
          email = docSnap['email'] ?? '';
          mobile = docSnap['mobile'] ?? '';

          var totalValue = docSnap['total'];
          var versValue = docSnap['vers'];

          if (totalValue is int) {
            total = totalValue.toString();
          } else if (totalValue is double) {
            total = totalValue.toStringAsFixed(2);
          }

          if (versValue is int) {
            vers = versValue.toString();
          } else if (versValue is double) {
            vers = versValue.toStringAsFixed(2);
          }
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getFactureNumber() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('factureCounter')
          .doc('facture')
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          factureNumber = documentSnapshot.get('number') as int?;
        });
        print("The facture num is : $factureNumber"); // Moved inside setState
      }
    } catch (e) {
      print('Error retrieving facture number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double? finalVers = double.tryParse(vers.toString());
    double? submit = double.tryParse(submitValue.text);
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
                            "Add amount to:",
                            style: GoogleFonts.cairo(
                                color: customPurpulColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          )),
                          CustomCard(title: "name", desc: name ?? ''),
                          CustomCard(title: "e-mail", desc: email ?? ''),
                          CustomCard(title: "mobile", desc: mobile ?? ''),
                          CustomCard(title: "address", desc: address ?? ''),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 60),
                            child: Container(
                              color: customPurpulColor,
                              height: 1,
                            ),
                          ),
                          CustomCard(title: "total", desc: total ?? ''),
                          CustomCard(title: "vers", desc: vers ?? ''),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 30),
                            child: CustomTextField(
                                setMaxChar: true,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                passedController: message,
                                title: "Message"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 30),
                            child: CustomTextField(
                                onChanged: (value) {
                                  setState(() {});
                                },
                                passedController: submitValue,
                                title: "type here vers amount"),
                          ),
                          CustomCard(
                            title: "total vers",
                            // desc: "${{finalVers + submit!} ?? 0}",
                            desc: finalVers != null &&
                                    submit != null &&
                                    message.text.isNotEmpty
                                ? '${finalVers + submit}'
                                : "...",
                          ),
                          finalVers != null &&
                                  submit != null &&
                                  message.text.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: CustomValidateButton(
                                      onPress: () {
                                        try {
                                          users.doc(widget.id).update({
                                            "vers": finalVers + submit,
                                            "message": message.text
                                          });
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.info,
                                            animType: AnimType.rightSlide,
                                            title: 'sucsess',
                                            desc:
                                                ' $name verse ${finalVers + submit}',
                                            dismissOnTouchOutside: false,
                                            btnOkOnPress: () async {
                                              facture.doc("facture").update({
                                                "number": factureNumber == null
                                                    ? 1
                                                    : factureNumber! + 1,
                                              });
                                              printCertificate(
                                                name: name ?? '',
                                                address: address ?? '',
                                                mobile: mobile ?? '',
                                                email: email ?? '',
                                                vers: submit,
                                                total: total ?? '',
                                                totalVers: submit + finalVers,
                                                message: message.text,
                                                number: factureNumber == null ? 1: factureNumber! +1
                                              );
                                              // Navigator.of(context).pop();
                                            },
                                          ).show();
                                        } catch (e) {}
                                      },
                                      title: "enregistrer le paiement",
                                      color: customPurpulColor),
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
        ],
      ),
    );
  }
}

Widget CustomCard({required String title, required String desc}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          color: borderColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: GoogleFonts.cairo(
                  color: title == "total vers"
                      ? borderGreenColor
                      : storeTitleColor,
                  fontSize: 20),
            )),
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text(
                      desc,
                      style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          color: title == "total vers"
                              ? borderGreenColor
                              : storeTitleColor,
                          fontSize: 25),
                    ),
                    title == "total" || title == "vers" || title == "total vers"
                        ? Text(
                            ".00 DZD",
                            style: GoogleFonts.cairo(
                                color: storeTitleColor, fontSize: 20),
                          )
                        : Container(),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}
