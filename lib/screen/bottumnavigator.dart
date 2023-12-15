import 'package:flutter/material.dart';
import 'package:shalom_mess/screen/home.dart';
import 'package:shalom_mess/screen/notification.dart';
import 'package:shalom_mess/screen/payment.dart';
import 'package:shalom_mess/screen/profile.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({super.key});

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorScreenState();
}

int currentIndex = 0;

class _BottomNavigatorScreenState extends State<BottomNavigatorScreen> {
  int currentIndex = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeScrn(),
      const PaymentScrn(),
      const NotificationScreen(),
      const ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 25,
                offset: const Offset(8, 20))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
              selectedItemColor: const Color(0XFF188F79),
              unselectedItemColor: Colors.black,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.payment), label: "Payment"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: "Notification"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ]),
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
