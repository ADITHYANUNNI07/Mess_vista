import 'package:flutter/material.dart';
import 'package:shalom_mess/util/util.dart';
import 'package:shalom_mess/widget/widget.dart';

class LoginWithPhoneScrn extends StatefulWidget {
  const LoginWithPhoneScrn({super.key});

  @override
  State<LoginWithPhoneScrn> createState() => _LoginWithPhoneScrnState();
}

final fromKeyphone = GlobalKey<FormState>();
TextEditingController phonenumbercontroller = TextEditingController();
ValueNotifier<bool> isotpValuenotifier = ValueNotifier(false);
TextEditingController otpcontroller = TextEditingController();

class _LoginWithPhoneScrnState extends State<LoginWithPhoneScrn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            padding: const EdgeInsets.all(20),
            child: Form(
              key: fromKeyphone,
              child: ValueListenableBuilder(
                valueListenable: isotpValuenotifier,
                builder: (context, isotp, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormCircularWidget(
                        controller: phonenumbercontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        widgetprefix: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('+91'),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isotp,
                        child: TextFormCircularWidget(
                            controller: otpcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'OTP is required';
                              } else if (!RegExp(r'^[0-9]{6}$')
                                  .hasMatch(value)) {
                                return 'Enter a valid 6-digit OTP number';
                              }
                              return null;
                            },
                            label: 'OTP',
                            widgetprefix: const Icon(Icons.keyboard_alt)),
                      ),
                      const SizedBox(height: 10),
                      ElevatedBtnWidget(
                          onPressed: () => isotp
                              ? otpVerification(context)
                              : phoneNumberValidation(context),
                          title: isotp ? 'Verify' : 'Get OTP')
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    isotpValuenotifier.value = false;
    phonenumbercontroller.clear();
    otpcontroller.clear();
    super.dispose();
  }
}
