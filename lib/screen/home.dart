import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shalom_mess/screen/home/add_group.dart';
import 'package:shalom_mess/screen/home/add_user.dart';
import 'package:shalom_mess/widget/widget.dart';

class HomeScrn extends StatefulWidget {
  const HomeScrn({super.key});

  @override
  State<HomeScrn> createState() => _HomeScrnState();
}

class _HomeScrnState extends State<HomeScrn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    String? greeting;
    if (currentHour >= 0 && currentHour < 12) {
      greeting = 'Good Morning ☀️';
    } else if (currentHour >= 12 && currentHour < 17) {
      greeting = 'Good Afternoon 🌤️';
    } else if (currentHour >= 17 && currentHour < 21) {
      greeting = 'Good Evening 🌙';
    } else {
      greeting = 'Good Night 🌜';
    }
    String? userPhotoURL = FirebaseAuth.instance.currentUser?.photoURL;
    return Container(
      color: const Color(0XFF188F79),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser!.displayName!,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: userPhotoURL == null
                          ? const CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage('Assets/images/user.png'),
                            )
                          : CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(userPhotoURL),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: size.height / 3.5,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Text(
                                  'Select the Options',
                                  style: GoogleFonts.poppins(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ImageUploadWidget(
                                      title: 'Group',
                                      icon: Icons.group_add,
                                      onTap: () async {
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddGroupScrn(),
                                          ),
                                        );
                                      },
                                    ),
                                    ImageUploadWidget(
                                      title: 'Indiviual',
                                      icon: Icons.person_add,
                                      onTap: () async {
                                        Navigator.pop(context);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddUserScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: const Color(0Xff188F79).withOpacity(0.7),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 2)
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.group, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Create a Group / Individual',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Icon(Icons.add, color: Colors.white),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
