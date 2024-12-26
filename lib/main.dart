import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invoice_management/firebase_options.dart';
import 'package:invoice_management/pinPage.dart';
import 'package:invoice_management/printing/printCode.dart';

import 'widgets/backGround.dart';
import 'widgets/operations.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CertificateApp());
}

class CertificateApp extends StatelessWidget {
  const CertificateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'abdou sat vers',
      theme: ThemeData(primarySwatch: Colors.blue),
     // home: GetStart(),
     home: PinPage(),
    );
  }
}

class GetStart extends StatefulWidget {
  const GetStart({super.key});

  @override
  _GetStartState createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  String name = "Your Name Here";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          FilterBackGround(),
          Operation(name: name),
        ],
      ),
    );
  }
}
