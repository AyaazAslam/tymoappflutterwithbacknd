import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Homepage/homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int curentIndex = 0;
  List g = [
    HomeScreen(),
    const Center(child: Text("two")),
    const Center(child: Text("three")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: g.elementAt(curentIndex),
      bottomNavigationBar: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.teal,
          currentIndex: curentIndex,
          onTap: (value) {
            setState(() {
              curentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.message), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ]),
    );
  }
}
