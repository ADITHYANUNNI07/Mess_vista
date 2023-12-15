import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: implementation_imports
import 'package:awesome_snackbar_content/src/awesome_snackbar_content.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    required this.icon,
    this.suffixicon,
    this.suffixOnpress,
    this.obscurebool = false,
    this.onChanged,
    this.keyboardType,
  });
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData icon;
  final IconData? suffixicon;
  final void Function()? suffixOnpress;
  final void Function(String?)? onChanged;
  final bool obscurebool;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        obscureText: obscurebool,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: suffixOnpress,
            icon: Icon(suffixicon),
          ),
          prefixIcon: Icon(
            icon,
          ),
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFF188F79),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        validator: validator,
      ),
    );
  }
}

class TextFormCircularWidget extends StatelessWidget {
  const TextFormCircularWidget({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    required this.widgetprefix,
    this.suffixicon,
    this.suffixOnpress,
    this.obscurebool = false,
    this.onChanged,
  });
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? widgetprefix;
  final IconData? suffixicon;
  final void Function()? suffixOnpress;
  final void Function(String?)? onChanged;
  final bool obscurebool;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscurebool,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: suffixOnpress,
            icon: Icon(suffixicon),
          ),
          prefixIcon: widgetprefix,
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFF188F79),
              ),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        validator: validator,
      ),
    );
  }
}

class ElevatedBtnWidget extends StatelessWidget {
  const ElevatedBtnWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: const Color(0XFF188F79),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class SigninWidget extends StatelessWidget {
  const SigninWidget({
    super.key,
    required this.imagesrc,
    required this.label,
    this.onPressed,
  });
  final String imagesrc;
  final String label;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          foregroundColor: Colors.black,
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        onPressed: onPressed,
        icon: Image.asset(
          imagesrc,
          width: 21,
        ),
        label: Text(label, style: GoogleFonts.poppins()),
      ),
    );
  }
}

void newshowSnackbar(
    BuildContext context, String title, String message, contentType) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
          inMaterialBanner: true,
          title: title,
          message: message,
          contentType: contentType)));
}

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });
  final void Function()? onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0Xff188F79).withOpacity(0.09),
              ),
              child: Icon(
                icon,
                size: 30,
                color: const Color(0Xff188F79),
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

Future<File?> selectImageFromGallery(
    BuildContext context, ImageSource option) async {
  File? image;
  try {
    final pickedImage = await ImagePicker().pickImage(source: option);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    __showSnackBar(context, e.toString());
  }
  return image;
}

void __showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
