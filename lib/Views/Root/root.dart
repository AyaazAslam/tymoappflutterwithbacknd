import 'package:flutter/material.dart';
enum AuthStatus{
firstTime,
authenticating,
notLoggedIn,
loggedInHome,
noProfile,
noFriend
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}