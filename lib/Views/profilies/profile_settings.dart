import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Views/Widgets/Profiles/profile_edit.dart';
import 'package:flutter_application_1/Views/Widgets/Profiles/profile_edit_one.dart';
import 'package:flutter_application_1/Views/Widgets/Profiles/profile_edit_two.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tyamo",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff000221),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: height * .3,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    130,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: height * .03),
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.star_border_sharp),
                      SizedBox(width: width * .01),
                      Text(
                        "Settings",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .012),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle_sharp,
                                  color: Colors.blue,
                                  size: 50,
                                ),
                                Text(
                                  "Ctest",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: height * .01,
                            color: Colors.grey.shade700,
                          ),
                          SizedBox(height: width * .02),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ProfileEditOneWidget(
                              color: Colors.purple,
                              text: "Profile Settings",
                            ),
                          ),
                          const ProfileEditWidget(
                            icon: Icons.arrow_forward,
                            text: "Edit",
                            color: Colors.black,
                          ),
                          const ProfileEditWidget(
                            icon: Icons.arrow_forward,
                            text: "Edit Phone Number",
                            color: Colors.black,
                          ),
                          const ProfileEditWidget(
                            icon: Icons.arrow_forward,
                            text: "Edit Password",
                            color: Colors.black,
                          ),
                          const ProfileEditTwoWidget(
                            icon: Icons.arrow_forward,
                            text: "Email Status",
                            type: "Not verified",
                            color: Colors.black,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ProfileEditOneWidget(
                              color: Colors.purple,
                              text: "Notifications Settings",
                            ),
                          ),
                          const ProfileEditWidget(
                            icon: Icons.arrow_forward,
                            text: "Push Notifications",
                            color: Colors.black,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ProfileEditOneWidget(
                              color: Colors.purple,
                              text: "Applications Settings",
                            ),
                          ),
                          const ProfileEditTwoWidget(
                            icon: Icons.arrow_forward,
                            text: "Back Grounds Updates",
                            type: "Not Updates",
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
