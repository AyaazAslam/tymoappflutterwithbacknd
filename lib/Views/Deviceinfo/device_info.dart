import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/DeviceButton/gradient_button.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              height: height * 0.05,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const Spacer(),
                  Container(
                    height: height * 0.05,
                    width: width * 0.22,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/tym.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),

            // Green Title Bar
            Container(
              height: height * 0.05,
              width: double.infinity,
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                "Device Info",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),

            SizedBox(height: height * 0.05),

            // Top 3 Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GradientButtonWidget(
                        title: "User Status",
                        clr: [Colors.blue.shade200, Colors.purple.shade200],
                        overlaycolor: Colors.white.withOpacity(0.2),
                        height: height * 0.2,
                        width: width * 0.4,
                      ),
                      const SizedBox(height: 10),
                      GradientButtonWidget(
                        title: "Battery",
                        clr: [Colors.orange.shade300, Colors.red.shade200],
                        overlaycolor: Colors.white.withOpacity(0.2),
                        height: height * 0.12,
                        width: width * 0.4,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  GradientButtonWidget(
                    title: "General",
                    clr: [Colors.teal.shade300, Colors.teal.shade100],
                    overlaycolor: Colors.white.withOpacity(0.2),
                    height: height * 0.34,
                    width: width * 0.3,
                  ),
                ],
              ),
            ),

            SizedBox(height: height * 0.1),

            // Bottom 3 Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left Big Button
                  GradientButtonWidget(
                    title: "Device Specs",
                    clr: [Colors.teal.shade700, Colors.teal.shade400],
                    overlaycolor: Colors.white.withOpacity(0.2),
                    height: height * 0.34,
                    width: width * 0.3,
                  ),
                  const SizedBox(width: 10),
                  // Right Column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GradientButtonWidget(
                        title: "Location",
                        clr: [Colors.purple.shade300, Colors.purple.shade100],
                        overlaycolor: Colors.white.withOpacity(0.2),
                        height: height * 0.2,
                        width: width * 0.4,
                      ),
                      const SizedBox(height: 15),
                      GradientButtonWidget(
                        title: "Orientation",
                        clr: [Colors.pink.shade300, Colors.orange.shade200],
                        overlaycolor: Colors.white.withOpacity(0.2),
                        height: height * 0.12,
                        width: width * 0.4,
                      ),
                    ],
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
