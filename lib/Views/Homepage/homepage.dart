import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Views/Widgets/Homepage/drawer_list_tile.dart';
import 'package:flutter_application_1/Views/Widgets/custom_button.dart';
import 'package:flutter_application_1/Views/Widgets/simple_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _homepagekey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _homepagekey,
      appBar: AppBar(
        elevation: 0,
        title: SizedBox(
          height: height * .1,
          width: width * .1,
          child: const Image(image: AssetImage("images/tym.jpg")),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            _homepagekey.currentState!.openDrawer();
          },
          child: const Icon(Icons.menu, color: Colors.black),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            height: height * .1,
            width: width * .1,
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: const Image(image: AssetImage("images/message.png")),
          ),
        ],
      ),
      drawer: GFDrawer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: Image.asset("images/person.png").image,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jayan Black",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      "JB@gmail.com",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 22),
                height: height * 0.06,
                width: width * 0.3,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Center(
                  child: Text(
                    "Premum",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            const Divider(),
            Column(
              children: [
                DrawerListTile(
                  iconName: FontAwesomeIcons.solidCreditCard,
                  listTitle: "Subscription",
                ),
                DrawerListTile(iconName: Icons.settings, listTitle: "Settings"),
                DrawerListTile(
                  iconName: FontAwesomeIcons.circleQuestion,
                  listTitle: "Help",
                ),
                DrawerListTile(
                  iconName: FontAwesomeIcons.message,
                  listTitle: "FeedBack",
                ),
                DrawerListTile(
                  iconName: FontAwesomeIcons.share,
                  listTitle: "Tell Others",
                ),
                DrawerListTile(
                  iconName: FontAwesomeIcons.starHalfStroke,
                  listTitle: "Rate the App",
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Divider(),
                    const SizedBox(height: 10),
                    DrawerListTile(
                      iconName: FontAwesomeIcons.rightFromBracket,
                      listTitle: "Sign Out",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "DASHBOARD ",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF2F76EA),
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              " Your Friends ",
              style: GoogleFonts.poppins(
                color: const Color(0xffc1272D),
                fontSize: height * 0.02,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.start,
            ),
            Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.circle_rounded, size: 30),
                      ),
                      title: Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("  Robbie Williams "),
                        ],
                      ),
                      subtitle: Row(
                        children: const [
                          Icon(Icons.location_on),
                          Text(
                            " and where are you please\n please call me sooner",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Status", style: TextStyle(fontSize: 13)),
                            Text(
                              "Offline",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 3,
                          decoration: const BoxDecoration(color: Colors.black),
                        ),
                        Column(
                          children: const [
                            Text("User Status", style: TextStyle(fontSize: 13)),
                            Text(
                              "N/A",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 3,
                          decoration: const BoxDecoration(color: Colors.black),
                        ),
                        const Text("Mood N/A", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * .02),
            SizedBox(
              height: height * 0.075,
              width: width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CustomButtonWidget(
                    text: " Device info ",
                    color: Colors.green,
                    leadingIcon: Icons.mobile_friendly,
                  ),
                  CustomButtonWidget(
                    text: " Gallery ",
                    color: Colors.orangeAccent,
                    leadingIcon: Icons.browse_gallery,
                  ),
                  CustomButtonWidget(
                    text: " Moods ",
                    color: Colors.purple,
                    leadingIcon: Icons.mood_sharp,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              " Our Features ",
              style: GoogleFonts.poppins(
                color: const Color(0xffc1272D),
                fontSize: height * 0.02,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SimpleButton(
                  text: " PlayList ",
                  iconColor: Colors.red,
                  color: Colors.white38,
                  borderRadius: 15,
                  leadingIcon: Icons.featured_play_list_sharp,
                ),
                SimpleButton(
                  iconColor: Colors.red,
                  text: " Location ",
                  color: Colors.white38,
                  borderRadius: 15,
                  leadingIcon: Icons.location_off_sharp,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SimpleButton(
                  iconColor: Colors.red,
                  text: " To-do-List ",
                  color: Colors.white38,
                  borderRadius: 15,
                  leadingIcon: Icons.list_alt_sharp,
                ),
                SimpleButton(
                  iconColor: Colors.red,
                  text: " Diary ",
                  color: Colors.white38,
                  borderRadius: 15,
                  leadingIcon: Icons.directions_railway,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                SimpleButton(
                  iconColor: Colors.red,
                  text: "Surprize note",
                  color: Colors.white38,
                  borderRadius: 15,
                  leadingIcon: Icons.notes_sharp,
                ),
                SimpleButton(
                  iconColor: Colors.blue,
                  text: " Horoscope ",
                  color: Colors.white38,
                  borderRadius: 15,
                  leadingIcon: Icons.microwave_sharp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
