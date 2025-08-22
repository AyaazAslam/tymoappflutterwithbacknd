import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/DeviceButton/device_button.dart';
//import 'package:flutter_application_1/Views/Widgets/DeviceButton/device_button.dart';
import 'package:flutter_application_1/Views/Widgets/userStatus/user_status.dart';
import 'package:google_fonts/google_fonts.dart';

class UserStatusPage extends StatefulWidget {
  const UserStatusPage({super.key});

  @override
  State<UserStatusPage> createState() => _UserStatusPageState();
}

class _UserStatusPageState extends State<UserStatusPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.blueAccent,
            child: Column(
              children: [
                // app bar section
                Container(
                  height: height * 0.05,
                  width: width,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: width * 0.25,
                      ),
                      Container(
                        height: height * 0.05,
                        width: width * 0.22,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/tym.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),

                // user section
                SizedBox(
                  height: height * .44,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Text(
                          "User Status :",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.3,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.,
                              children: [
                                DeviceButtonWidget(
                                    color: Colors.white,
                                    text: "User is \n online",
                                    height: height * .12,
                                    width: width * .4),
                                DeviceButtonWidget(
                                    color: Colors.white,
                                    text: "Last App Action \n two minutes ago",
                                    height: height * .1,
                                    width: width * .4),
                              ],
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            DeviceButtonWidget(
                                color: Colors.white,
                                text: "user Status \n Driving",
                                height: height * .3,
                                width: width * .25),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Last Update 1 Minutes ago",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.0),
                          topLeft: Radius.circular(50.0)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "My Status: Eating",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.black45,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            UserStatusWidget(
                              height: height * .15,
                              width: width * .26,
                              clr: Colors.lightBlueAccent,
                              txtclr: Colors.white,
                              text: "AWAY",
                              imagePath: 'images/away.jpg',
                            ),
                            UserStatusWidget(
                                height: height * 0.15,
                                width: width * 0.26,
                                clr: Colors.lightBlueAccent,
                                txtclr: Colors.white,
                                text: "DRIVING",
                                imagePath:
                                    'images/driving.jpg' // Make sure this matches your asset path
                                ),
                            UserStatusWidget(
                                height: height * 0.15,
                                width: width * 0.26,
                                clr: Colors.lightBlueAccent,
                                txtclr: Colors.white,
                                text: "MEETING",
                                imagePath:
                                    'images/eating.jpg' // Make sure this matches your asset path
                                ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            UserStatusWidget(
                                height: height * 0.15,
                                width: width * 0.26,
                                clr: Colors.lightBlueAccent,
                                txtclr: Colors.white,
                                text: "DON'T DISTURB",
                                imagePath:
                                    'images/dontnotdistrub.jpg' // Make sure this matches your asset path
                                ),
                            UserStatusWidget(
                                height: height * 0.15,
                                width: width * 0.26,
                                clr: Colors.lightBlueAccent,
                                txtclr: Colors.white,
                                text: "EATING",
                                imagePath:
                                    'images/eating.jpg' // Make sure this matches your asset path
                                ),
                            UserStatusWidget(
                                height: height * 0.15,
                                width: width * 0.26,
                                clr: Colors.lightBlueAccent,
                                txtclr: Colors.white,
                                text: "OUT DOOR",
                                imagePath:
                                    "images/outdoor.jpeg" // Make sure this matches your asset path
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
