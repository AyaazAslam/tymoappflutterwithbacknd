import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/Profiles/profile_detail.dart';
import 'package:flutter_application_1/Views/Widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool more = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/tym.jpg")),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Text(
              "My Profile ",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: height * 0.021,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1),
            ),
            Container(
              height: height * .15,
              width: width * .3,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueAccent),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 100,
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Jaydon Black ",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1),
            ),
            Text(
              "@jsb ",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1),
            ),
            const CustomButtonWidget(
                text: "Edit Profile Details",
                color: Colors.white,
                leadingIcon: Icons.edit),
            const SizedBox(
              height: 5,
            ),
            if (!more) ...[
              const ProfileDetailWidgets(
                  type: "Email",
                  val: "abc@gmail.com",
                  icon: Icons.email_sharp,
                  color: Colors.white),
              const ProfileDetailWidgets(
                  icon: Icons.flag_sharp,
                  type: "Country",
                  val: "Shangacer",
                  color: Colors.white),
            ],
            if (more) ...[
              const ProfileDetailWidgets(
                  type: "Email",
                  val: "abc@gmail.com",
                  icon: Icons.email_sharp,
                  color: Colors.white),
              const ProfileDetailWidgets(
                  icon: Icons.flag_sharp,
                  type: "Country",
                  val: "Shangacer",
                  color: Colors.white),
              const ProfileDetailWidgets(
                  icon: Icons.phone_callback_sharp,
                  type: "Phone Number",
                  val: "Not Currently Set",
                  color: Colors.white),
              const ProfileDetailWidgets(
                  icon: Icons.male_sharp,
                  type: "Gender",
                  val: "Male",
                  color: Colors.white),
              const ProfileDetailWidgets(
                  icon: Icons.female,
                  type: "Partner",
                  val: "Robbie Williams",
                  color: Colors.white),
              const ProfileDetailWidgets(
                  icon: Icons.upload_file,
                  type: "UID",
                  val: "hjjhjjhjh jkkkkkkkk",
                  color: Colors.white),
              const ProfileDetailWidgets(
                  icon: Icons.account_box,
                  type: "Acounts Created",
                  val: "24-4-25",
                  color: Colors.white)
            ],
            ElevatedButton(
                style: ButtonStyle(
                  side: WidgetStateProperty.all<BorderSide>(BorderSide(
                    color: Colors.grey.shade200,
                  )),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.grey.shade200,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    more = !more;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    more ? "- Show less" : "+ Show more",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height * .15,
                  width: width * .3,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffff9966), Color(0xffff5e62)]),
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Subscribed to",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      ),
                      Text(
                        "Premum",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height * .15,
                  width: width * .3,
                  decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    // colors: [Color(0xffff9966), Color(0xffff5e62)]),
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Subscribed to",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      ),
                      Text(
                        "Premum",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
