import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFF188F79),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}
