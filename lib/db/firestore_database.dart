// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shalom_mess/helper/sharedpreference.dart';
import 'package:shalom_mess/model/addusermodel.dart';
import 'package:shalom_mess/screen/addstudent.dart';
import 'package:shalom_mess/screen/dashboard.dart';

class DataBaseClass {
  final String uid;
  DataBaseClass({required this.uid});
  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection('users');
  Future saveUserdata(String email, BuildContext context) async {
    usercollection.doc(uid).set({'email': email, 'uid': uid});
    await SharedpreferenceClass.saveUserLoggedInStatus(true);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const BottomNavigatorScreen(),
    ));
  }

  Future gettingUserData() async {
    QuerySnapshot snapshot =
        await usercollection.where("uid", isEqualTo: uid).get();
    return snapshot;
  }

  Future saveEachuserdata(
      AgeAddUserModel userModel, BuildContext context) async {
    final userDoc = await usercollection.doc(uid).get();
    final folderDoc = await userDoc.reference
        .collection('usercollection')
        .doc(uid + DateTime.now().millisecondsSinceEpoch.toString())
        .get();
    await folderDoc.reference.set({
      'imageurl': userModel.image,
      'name': userModel.name,
      'age': userModel.age
    });
    isLoadingadduservaluenotifier.value = true;
    Navigator.pop(context);
  }
}
