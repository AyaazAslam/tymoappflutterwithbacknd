import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Auth/Features/Album/album_main.dart';
import 'package:flutter_application_1/Views/Auth/Features/Album/my_album.dart';
//import 'package:flutter_application_1/Views/Auth/Features/Album/plus_screen.dart';
import 'package:flutter_application_1/Views/Auth/Features/Album/profile_screen.dart';

class AlBumNavBar extends StatefulWidget {
  const AlBumNavBar({super.key});

  @override
  State<AlBumNavBar> createState() => _AlBumNavBarState();
}

class _AlBumNavBarState extends State<AlBumNavBar> {
  int currentIndex = 0;

  final List<Widget> screens = [
    Album_MainPage(),
    MyAlbum(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 1;
          });
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.person,
                color: currentIndex == 0 ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
            ),
            const SizedBox(width: 40), // space for FAB
            IconButton(
              icon: Icon(
                Icons.people,
                color: currentIndex == 2 ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
