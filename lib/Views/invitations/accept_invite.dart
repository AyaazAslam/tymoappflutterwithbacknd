import 'package:flutter/material.dart';
// import 'package:getwidget/components/button/gf_button.dart';
// import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

class AcceptInvite extends StatelessWidget {
  const AcceptInvite({super.key});

  // final RoundedLoadingButtonController acceptbtncontroller =
  //     RoundedLoadingButtonController();
  //final RoundedLoadingButton acceptcontroller=RoundedLoadingButtonController()
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const SizedBox(
            height: 50,
            width: 50,
            child: Image(
              image: AssetImage("images/tym.jpg"),
              filterQuality: FilterQuality.high,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),

          // filterQuality: FilterQuality.high),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              color: const Color(0xff8c47FB),
              child: Text(
                "See received invitations",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  fontSize: height * 0.03,
                ),
                textScaleFactor: 1,
              ),
            ),
            SizedBox(height: height * .1),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox(
                  height: height * .2,
                  child: Center(
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, size: 30),
                      ),
                      title: const Text("@Fizan"),
                      subtitle: const Text("i'm here"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle accept action
                              print("Accepted");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Accept"),
                          ),
                          SizedBox(width: width * .02),
                          ElevatedButton(
                            onPressed: () {
                              // Handle accept action
                              print("Reject");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Reject"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .15),
            SizedBox(
              height: height * .4,
              width: width * .4,
              child: Image(image: AssetImage("images/acept.png")),
            ),
            Text(
              "Search for your friend on Tyamo ",
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.02,
              ),
            ),
            SizedBox(height: height * .1),
          ],
        ),
      ),
    );
  }
}
