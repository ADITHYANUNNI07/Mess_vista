// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shalom_mess/auth/auth.dart';
import 'package:shalom_mess/db/firestore_database.dart';
import 'package:shalom_mess/helper/sharedpreference.dart';
import 'package:shalom_mess/model/addusermodel.dart';
import 'package:shalom_mess/model/usermodel.dart';
import 'package:shalom_mess/screen/addstudent.dart';
import 'package:shalom_mess/screen/login_signup.dart';
import 'package:shalom_mess/screen/loginwithphone.dart';
import 'package:shalom_mess/widget/widget.dart';

//----------------------------------------------LOGIN AND SIGNUP WITH EMAIL & PASSWORD----------------------------------------------------
signUpandSignInFn(bool issignin) {
  if (issignin) {
    issignin = false;
  } else {
    issignin = true;
  }
  issiginvaluenotifier.value = issignin;
  emailController.clear();
  passwordController.clear();
}

suffixOnpress() {
  if (isobscurebool.value) {
    isobscurebool.value = false;
  } else {
    isobscurebool.value = true;
  }
}

signInFn(String email, String password, BuildContext context) async {
  if (fromKey.currentState!.validate()) {
    AuthServiceclass authService = AuthServiceclass();
    dynamic value =
        await authService.loginUserAccount(email, password, context);
    if (value == true) {
      await SharedpreferenceClass.saveUserLoggedInStatus(true);
    } else {
      newshowSnackbar(context, 'Login Failure',
          'Email and password is incorrect', ContentType.failure);
    }
  }
}

signUpFn(String email, String password, BuildContext context) async {
  if (fromKey.currentState!.validate()) {
    AuthServiceclass authService = AuthServiceclass();
    final userDetails = Usermodel(password: password, email: email);
    dynamic value = await authService.createUserAccount(userDetails, context);
    if (value == true) {
    } else {
      newshowSnackbar(context, 'Login Failure',
          'Email and password is Already existing', ContentType.failure);
    }
  }
}

//----------------------------------------------LOGIN WITH PHONENUMBER----------------------------------------------------

phoneNumberValidation(BuildContext context) {
  if (fromKeyphone.currentState!.validate()) {
    AuthServiceclass()
        .phoneNumberAuth('+91${phonenumbercontroller.text}', context);
  }
}

otpVerification(BuildContext context) {
  if (fromKeyphone.currentState!.validate()) {
    AuthServiceclass().otpverify(context);
  }
}

//----------------------------------------------USER DETAILS----------------------------------------------------

studentAdd(BuildContext context) async {
  if (formaddkey.currentState!.validate()) {
    if (image != null) {
      isLoadingadduservaluenotifier.value = true;
      String? imageurl = await uploadImageAndStoreURL(image!, context);
      final userdata = AgeAddUserModel(
          image: imageurl!,
          name: namecontroller.text.trim(),
          age: int.parse(agecontroller.text.trim()));
      User? user = FirebaseAuth.instance.currentUser;
      await DataBaseClass(uid: user!.uid).saveEachuserdata(userdata, context);
    } else {
      newshowSnackbar(context, 'Please Select Image', 'Please select the image',
          ContentType.failure);
    }
  }
}

Future<String?> uploadImageAndStoreURL(
    File imageFile, BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${user!.uid}/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  } catch (e) {
    newshowSnackbar(
        context, 'Error uploading image: ', '$e', ContentType.failure);
  }
  return null;
}
