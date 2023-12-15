// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shalom_mess/db/firestore_database.dart';
import 'package:shalom_mess/helper/sharedpreference.dart';
import 'package:shalom_mess/model/usermodel.dart';
import 'package:shalom_mess/screen/dashboard.dart';
import 'package:shalom_mess/screen/login_signup.dart';
import 'package:shalom_mess/screen/loginwithphone.dart';
import 'package:shalom_mess/widget/widget.dart';

String verificationID = '';

class AuthServiceclass {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//login
  Future loginUserAccount(
      String email, String password, BuildContext context) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        QuerySnapshot snapshot =
            await DataBaseClass(uid: user.uid).gettingUserData();
        if (snapshot != null) {
          await SharedpreferenceClass.saveUserLoggedInStatus(true);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const DashboardScrn(),
          ));
        } else {
          newshowSnackbar(context, 'User data is not found',
              'User data is not found', ContentType.failure);
        }
        return true;
      }
    } on FirebaseAuthException catch (e) {}
  }

//signUp
  Future createUserAccount(Usermodel userDetails, BuildContext context) async {
    try {
      isLoadingvaluenotifier.value = true;
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: userDetails.email, password: userDetails.password))
          .user;

      if (user != null) {
        await DataBaseClass(uid: user.uid)
            .saveUserdata(userDetails.email, context);

        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      isLoadingvaluenotifier.value = false;
      return false;
    }
  }

  Future signOut() async {
    try {
      await firebaseAuth.signOut();
      await SharedpreferenceClass.saveUserLoggedInStatus(false);
    } catch (e) {
      return null;
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    isLoadingvaluenotifier.value = true;
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      if (guser != null) {
        final GoogleSignInAuthentication gauth = await guser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: gauth.accessToken, idToken: gauth.idToken);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          QuerySnapshot snapshot =
              await DataBaseClass(uid: user.uid).gettingUserData();
          if (snapshot == null) {
            await DataBaseClass(uid: user.uid)
                .saveUserdata(user.email!, context);
          } else {
            await SharedpreferenceClass.saveUserLoggedInStatus(true);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DashboardScrn(),
            ));
            isLoadingvaluenotifier.value = false;
          }
        }
      } else {
        isLoadingvaluenotifier.value = false;
        return;
      }
    } catch (e) {
      isLoadingvaluenotifier.value = false;
      print(e);
      // newshowSnackbar(context, 'Google Sign In',
      //     'Error signing in with Google ${e.toString()}', ContentType.failure);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future phoneNumberAuth(String phonenumber, BuildContext context) async {
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (phoneAuthCredential) async {
        await firebaseAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException e) {
        newshowSnackbar(context, 'Phone Number Signin Failed', e.toString(),
            ContentType.failure);
      },
      codeSent: (verificationId, forceResendingToken) {
        verificationID = verificationId;
        isotpValuenotifier.value = true;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future otpverify(BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpcontroller.text.trim());
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        QuerySnapshot snapshot =
            await DataBaseClass(uid: user.uid).gettingUserData();
        if (snapshot == null) {
          isLoadingvaluenotifier.value = false;
          await DataBaseClass(uid: user.uid).saveUserdata(user.email!, context);
        } else {
          isLoadingvaluenotifier.value = false;
          await SharedpreferenceClass.saveUserLoggedInStatus(true);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => DashboardScrn(),
          ));
        }
      }
    } catch (e) {
      isLoadingvaluenotifier.value = false;
      newshowSnackbar(
          context, 'OTP is Incorrect', e.toString(), ContentType.failure);
    }
  }
}
