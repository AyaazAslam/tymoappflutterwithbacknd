import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Views/invitations/accept_invite.dart';
import 'package:page_transition/page_transition.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const SizedBox(
            height: 50,
            child: Image(image: AssetImage("images/tym.jpg")),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                print("Navigating to AcceptInvite...");
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: AcceptInvite(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.purple,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 25,
              color: const Color(0x00ff00cc),
              child: Text(
                " Find your friend ",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.black26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  fontSize: height * 0.02,
                ),
              ),
            ),
            SizedBox(height: height * .12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          hintText: "Hi Faizan, type your exact username",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * .02),
                  Container(
                    height: height * .15,
                    width: height * .15,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * .14),
            SizedBox(
              height: height * .42,
              width: width * .5,
              child: Image.asset("images/invitechat.png", fit: BoxFit.contain),
            ),
            SizedBox(height: height * .03),
            Text(
              "Search for your friend on Tyamo,\nOr invite your friend on Tyamo",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.03,
              ),
            ),
            SizedBox(height: height * .02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Timer(const Duration(seconds: 2), () {
                 // _btncontroller.success();
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: AcceptInvite(),
                    ),
                  );
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcceptInvite()),
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Invite sent!")));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(
                  " Invite a Friend ",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
