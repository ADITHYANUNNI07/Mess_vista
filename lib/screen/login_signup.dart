import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shalom_mess/auth/auth.dart';
import 'package:shalom_mess/screen/loginwithphone.dart';
import 'package:shalom_mess/util/util.dart';
import 'package:shalom_mess/widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final fromKey = GlobalKey<FormState>();
ValueNotifier<bool> issiginvaluenotifier = ValueNotifier(true);
ValueNotifier<bool> isobscurebool = ValueNotifier(true);
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
ValueNotifier<bool> isLoadingvaluenotifier = ValueNotifier<bool>(false);

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder<bool>(
            valueListenable: isLoadingvaluenotifier,
            builder: (contextk, isloading, child) {
              return isloading
                  ? Center(
                      child: FractionallySizedBox(
                          widthFactor: 0.4,
                          heightFactor: 0.4,
                          child: LottieBuilder.asset(
                              'Assets/animation/animation_lo4efsbq.json')),
                    )
                  : Container(
                      width: size.width,
                      padding:
                          const EdgeInsets.only(top: 70, left: 30, right: 30),
                      child: ValueListenableBuilder(
                        valueListenable: issiginvaluenotifier,
                        builder: (contexti, issignup, child) {
                          return Form(
                            key: fromKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    'Hello!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      color: const Color(0XFF188F79),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Welcome Back',
                                    style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      color: const Color(0XFF188F79),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 100),
                                  TextFormWidget(
                                      controller: emailController,
                                      validator: (val) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(val!)
                                            ? null
                                            : "Please enter a valid email";
                                      },
                                      label: 'Email',
                                      icon: Icons.email_outlined),
                                  ValueListenableBuilder(
                                      valueListenable: isobscurebool,
                                      builder: (context, obscurebool, child) {
                                        return TextFormWidget(
                                            obscurebool: obscurebool,
                                            suffixOnpress: () =>
                                                suffixOnpress(),
                                            onChanged: (val) => setState(() {}),
                                            suffixicon: passwordController
                                                    .text.isNotEmpty
                                                ? obscurebool
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined
                                                : null,
                                            controller: passwordController,
                                            validator: (val) {
                                              if (val!.length < 6) {
                                                return "Password must be at least 6 characters";
                                              } else {
                                                return null;
                                              }
                                            },
                                            label: 'Password',
                                            icon: Icons.fingerprint_outlined);
                                      }),
                                  Visibility(
                                    visible: issignup,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot Password ?',
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width,
                                    child: ElevatedBtnWidget(
                                        onPressed: issignup
                                            ? () => signInFn(
                                                emailController.text,
                                                passwordController.text,
                                                context)
                                            : () => signUpFn(
                                                emailController.text,
                                                passwordController.text,
                                                context),
                                        title:
                                            issignup ? 'Sign In' : 'Sign Up'),
                                  ),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () => signUpandSignInFn(issignup),
                                    child: Text.rich(
                                      TextSpan(
                                        text: issignup
                                            ? "Don't have an Account ? "
                                            : 'Already have an account ? ',
                                        style: GoogleFonts.poppins(),
                                        children: [
                                          TextSpan(
                                            text: issignup
                                                ? 'Sign Up'
                                                : 'Sign In',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0XFF188F79),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Divider(thickness: 2),
                                  const SizedBox(height: 20),
                                  SigninWidget(
                                    imagesrc: 'Assets/images/google.png',
                                    label: issignup
                                        ? 'Sign-in with Google'
                                        : 'Sign-up with Google',
                                    onPressed: () {
                                      AuthServiceclass()
                                          .signInWithGoogle(context);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  SigninWidget(
                                    imagesrc: 'Assets/images/telephone.png',
                                    label: issignup
                                        ? 'Sign-in with Phone Number'
                                        : 'Sign-up with Phone Number',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginWithPhoneScrn(),
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
            }),
      ),
    );
  }

  @override
  void dispose() {
    isLoadingvaluenotifier.value = false;
    super.dispose();
  }
}
