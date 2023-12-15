import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shalom_mess/widget/widget.dart';
import 'package:intl/intl.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

TextEditingController nameeditingcontroller = TextEditingController();
TextEditingController phonenumberEditingcontroller = TextEditingController();
TextEditingController dateController = TextEditingController();
int? selectedDay;
File? image;

class _AddUserScreenState extends State<AddUserScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              'Add New User',
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Column(
                  children: [
                    TextFormCircularWidget(
                      label: 'Full Name',
                      widgetprefix: const Icon(Icons.person),
                      controller: nameeditingcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter User Full Name";
                        } else {
                          return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(value)
                              ? "Please enter valid Full Name"
                              : null;
                        }
                      },
                    ),
                    TextFormCircularWidget(
                      label: 'Phone Number',
                      widgetprefix: const Icon(Icons.phone),
                      controller: phonenumberEditingcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter User Phone Number";
                        } else {
                          return RegExp(r'[!@#<>?:_`"~;[\]\\|=+)(*&^%0-9-]')
                                  .hasMatch(value)
                              ? "Please enter valid Phone Number"
                              : null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      initialValue: null,
                      readOnly: true,
                      controller: dateController,
                      decoration: InputDecoration(
                        label: const Text("Starting Date"),
                        prefixIcon: const Icon(Icons.calendar_month),
                        hintText: 'DOB',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          dateController.text =
                              DateFormat('dd MMM yyyy').format(date);
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Select DOB";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        value: selectedDay,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedDay = newValue;
                          });
                        },
                        items: [
                          DropdownMenuItem<int>(
                            value: null,
                            child: Text(
                              'Select The Days',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DropdownMenuItem<int>(
                            value: 5,
                            child: Text(
                              '5 Days',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DropdownMenuItem<int>(
                            value: 10,
                            child: Text(
                              '10 Days',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DropdownMenuItem<int>(
                            value: 15,
                            child: Text(
                              '15 Days',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DropdownMenuItem<int>(
                            value: 30,
                            child: Text(
                              '30 Days',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Upload Payment Screenshot',
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
                          onPressed: () {}, title: 'ADD USER'),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phonenumberEditingcontroller.clear();
    nameeditingcontroller.clear();
    dateController.clear();
    selectedDay = null;
    super.dispose();
  }
}
