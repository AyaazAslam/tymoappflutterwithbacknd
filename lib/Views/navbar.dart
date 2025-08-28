import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Homepage/homepage.dart';
import 'package:flutter_application_1/Views/invitations/invite_friend.dart';
import 'package:flutter_application_1/Views/profilies/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int curentIndex = 0;
  List g = [HomeScreen(), InviteFriend(), ProfilePage()];

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
            icon: Icon(FontAwesomeIcons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
    );
  }
}
