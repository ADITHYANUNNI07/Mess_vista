import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shalom_mess/util/util.dart';
import 'package:shalom_mess/widget/widget.dart';

class AddStudentScrn extends StatefulWidget {
  const AddStudentScrn({super.key});

  @override
  State<AddStudentScrn> createState() => _AddStudentScrnState();
}

final formaddkey = GlobalKey<FormState>();
File? image;
TextEditingController namecontroller = TextEditingController();
TextEditingController agecontroller = TextEditingController();
ValueNotifier<bool> isLoadingadduservaluenotifier = ValueNotifier<bool>(false);

class _AddStudentScrnState extends State<AddStudentScrn> {
  @override
  void initState() {
    isLoadingadduservaluenotifier.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
      valueListenable: isLoadingadduservaluenotifier,
      builder: (context, isloading, child) {
        return Scaffold(
          body: SafeArea(
              child: isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        width: size.width,
                        padding:
                            const EdgeInsets.only(top: 70, left: 20, right: 20),
                        child: Form(
                          key: formaddkey,
                          child: Column(
                            children: [
                              Text(
                                'Enter User Details !',
                                style: GoogleFonts.poppins(
                                  fontSize: 30,
                                  color: const Color(0XFF188F79),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ImageUploadWidget(
                                                    title: 'Gallery',
                                                    icon: Icons.photo_album,
                                                    onTap: () async {
                                                      File? picimage =
                                                          await selectImageFromGallery(
                                                              context,
                                                              ImageSource
                                                                  .gallery);
                                                      image = picimage;
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  ImageUploadWidget(
                                                    title: 'Camera',
                                                    icon: Icons.camera_alt,
                                                    onTap: () async {
                                                      File? picimage =
                                                          await selectImageFromGallery(
                                                              context,
                                                              ImageSource
                                                                  .gallery);
                                                      image = picimage;
                                                      setState(() {});
                                                      Navigator.pop(context);
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
                                child: CircleAvatar(
                                  backgroundImage:
                                      image != null ? FileImage(image!) : null,
                                  radius: 90,
                                  child: Icon(
                                    image == null
                                        ? Icons.photo_album_rounded
                                        : null,
                                    size: 60,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormWidget(
                                label: 'Name',
                                icon: Icons.person,
                                controller: namecontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Your Full Name";
                                  } else {
                                    return RegExp(
                                                r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                            .hasMatch(value)
                                        ? "Please enter valid name"
                                        : null;
                                  }
                                },
                              ),
                              TextFormWidget(
                                label: 'Age',
                                icon: Icons.numbers,
                                controller: agecontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Age is required';
                                  }
                                  int age = int.tryParse(value) ?? 0;
                                  if (age <= 0) {
                                    return 'Age must be greater than 0';
                                  } else if (age > 100) {
                                    return 'Age must be less than 100';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedBtnWidget(
                                      onPressed: () => studentAdd(context),
                                      title: 'Save'))
                            ],
                          ),
                        ),
                      ),
                    )),
          floatingActionButton: isLoadingadduservaluenotifier.value
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.people),
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    namecontroller.clear();
    agecontroller.clear();
    image = null;
    super.dispose();
  }
}
