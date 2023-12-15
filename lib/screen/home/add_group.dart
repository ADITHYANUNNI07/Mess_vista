import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shalom_mess/widget/widget.dart';

class AddGroupScrn extends StatefulWidget {
  const AddGroupScrn({super.key});

  @override
  State<AddGroupScrn> createState() => _AddGroupScrnState();
}

final formKey = GlobalKey<FormState>();

final namecontroller = TextEditingController();
final organisationcontroller = TextEditingController();
File? image;

class _AddGroupScrnState extends State<AddGroupScrn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      color: const Color(0Xff188F79),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 32,
                color: Color(0Xff188F79),
              ),
            ),
            title: Text(
              'Create New Community',
              style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              color: const Color(0Xff188F79).withOpacity(0.05),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormCircularWidget(
                      label: 'Group Name',
                      widgetprefix: const Icon(Icons.group),
                      controller: namecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Group Name";
                        } else {
                          return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(value)
                              ? "Please enter valid Group name"
                              : null;
                        }
                      },
                    ),
                    TextFormCircularWidget(
                      label: 'Organization / Community Name',
                      widgetprefix: const Icon(Icons.school),
                      controller: organisationcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Full Organization / Community name";
                        } else {
                          return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(value)
                              ? "Please enter valid name"
                              : null;
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Upload Image',
                      style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),
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
                                          title: 'Gallery',
                                          icon: Icons.photo_album,
                                          onTap: () async {
                                            File? pickedImage =
                                                await selectImageFromGallery(
                                                    context,
                                                    ImageSource.gallery);
                                            setState(() {
                                              image = pickedImage;
                                            });
                                          },
                                        ),
                                        ImageUploadWidget(
                                          title: 'Camera',
                                          icon: Icons.camera_alt,
                                          onTap: () async {
                                            File? pickedImage =
                                                await selectImageFromGallery(
                                                    context,
                                                    ImageSource.camera);
                                            setState(() {
                                              image = pickedImage;
                                            });
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(21),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 2,
                                spreadRadius: 1)
                          ],
                        ),
                        child: image == null
                            ? Image.asset('Assets/images/Imageupload-bro.png')
                            : Image.file(image!),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: size.width,
                      height: 50,
                      child: ElevatedBtnWidget(
                          onPressed: () {}, title: 'CREATE GROUP'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
