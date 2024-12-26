import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoice_management/editCient.dart';
import 'package:invoice_management/newCient.dart';
import 'package:invoice_management/submitVers.dart';
import 'package:invoice_management/widgets/button.dart';
import '../materialDesign/constant.dart';
import '../printing/printCode.dart';

class Operation extends StatefulWidget {
  String name;
  bool correct_choose = false;
  String selected_docID = "";
  Operation({super.key, required this.name});

  @override
  State<Operation> createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> searchResults = [];
  TextEditingController _controller = TextEditingController();

  // Function to search users by name in Firestore
  void searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    final results = await _firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      searchResults = results.docs.map((doc) {
        return {
          'id': doc.id, // Storing document ID
          'name': doc['name'],
          'mobile': doc['mobile'],
        };
      }).toList();
    });
  }

  Future<void> deleteUser(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(docId).delete();
      print('Document deleted successfully');
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 1.3,
        child: Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            widget.correct_choose = false;
                            widget.selected_docID = "";
                            widget.name = value;
                            searchUsers(
                                value); // Call search function on text change
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: decorationInput,
                      ),
                      const SizedBox(height: 20),
                      ...searchResults.map((user) {
                        return ListTile(
                          title: Text(
                            user['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            user['mobile'],
                            style: TextStyle(color: Colors.white60),
                          ),
                          onTap: () {
                            setState(() {
                              widget.correct_choose = true;
                              widget.name = user['name'];
                              _controller.text = user[
                                  'name']; // Set selected name in the TextField
                              searchResults = []; // Clear the search results
                              widget.selected_docID = user["id"];
                              print(widget.selected_docID);
                            });
                          },
                        );
                      }).toList(),
                      const SizedBox(height: 50),
                      CustomValidateButton(
                        color: Colors.green.withOpacity(0.5),
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NewCilentPage()));
                        },
                        title: "nouveau client",
                        icon: CupertinoIcons.add_circled,
                      ),
                      widget.correct_choose == true
                          ? Column(
                              children: [
                                const SizedBox(height: 50),
                                CustomValidateButton(
                                  color: Colors.cyan.withOpacity(0.5),
                                  onPress: () {
                                   
                                     Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Submitvers(id: widget.selected_docID,)));
                                  },
                                  title: "versement",
                                  icon: CupertinoIcons.add_circled,
                                ),
                                const SizedBox(height: 30),
                                CustomValidateButton(
                                  color: Colors.red.withOpacity(0.5),
                                  onPress: () {
                                    deleteUser(widget.selected_docID);
                                    _controller.clear();
                                    widget.correct_choose = false;
                                    setState(() {});
                                  },
                                  title: "Supprimer le client",
                                  icon: CupertinoIcons.add_circled,
                                ),
                                const SizedBox(height: 30),
                                CustomValidateButton(
                                  color: Colors.amber.withOpacity(0.5),
                                  onPress: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Editcient(id: widget.selected_docID)));
                                  },
                                  title: "Modifier",
                                  icon: CupertinoIcons.add_circled,
                                )
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}







