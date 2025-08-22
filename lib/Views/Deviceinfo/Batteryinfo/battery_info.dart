import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/batteryinfo/battery_info.dart';
import 'package:flutter_application_1/Views/Widgets/batteryinfo/batteryicon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class BatteryInfoPage extends StatefulWidget {
  const BatteryInfoPage({super.key});

  @override
  State<BatteryInfoPage> createState() => _BatteryInfoPageState();
}

class _BatteryInfoPageState extends State<BatteryInfoPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Bar
              Container(
                height: height * 0.06,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    const Spacer(),
                    Container(
                      height: height * 0.06,
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
              Container(
                height: height,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFAD585), Color(0xFFFA7A7D)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Battery Status",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BatteryInfoWidget(
                            height: height * 0.15,
                            width: width * 0.26,
                            txtclr: Colors.black,
                            clr: Colors.white,
                            text: "Status Discharge"),
                        BatteryIconWidget(
                          height: height * 0.2,
                          width: width * 0.26,
                          txtclr: Colors.black,
                          clr: Colors.white,
                          text: "Charging Percentage",
                          subwidget: const SleekCircularSlider(
                            min: 0,
                            max: 100,
                            appearance: CircularSliderAppearance(
                              size: 80,
                            ),
                          ),
                        ),
                        BatteryInfoWidget(
                          height: height * 0.15,
                          width: width * 0.26,
                          txtclr: Colors.black,
                          clr: Colors.white,
                          text: "Battery health",
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: height * 0.0,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BatteryInfoWidget(
                            height: height * 0.15,
                            width: width * 0.26,
                            txtclr: Colors.black,
                            clr: Colors.white,
                            text: "Charging type"),
                        BatteryInfoWidget(
                          height: height * 0.1,
                          width: width * 0.26,
                          txtclr: Colors.black,
                          clr: Colors.white,
                          text: "Temprature",
                        ),
                        BatteryInfoWidget(
                          height: height * 0.15,
                          width: width * 0.26,
                          txtclr: Colors.black,
                          clr: Colors.white,
                          text: "Battery Technology",
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    fontSize: 16,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BatteryInfoWidget(
                                    height: height * 0.15,
                                    width: width * 0.26,
                                    txtclr: Colors.black,
                                    clr: Colors.orange,
                                    text: "Charging type"),
                                BatteryIconWidget(
                                  height: height * 0.2,
                                  width: width * 0.26,
                                  txtclr: Colors.black,
                                  clr: Colors.orange,
                                  text: "Charging Percentage",
                                  subwidget: const SleekCircularSlider(
                                    min: 0,
                                    max: 100,
                                    appearance: CircularSliderAppearance(
                                      size: 80,
                                    ),
                                  ),
                                ),
                                BatteryInfoWidget(
                                  height: height * 0.15,
                                  width: width * 0.26,
                                  txtclr: Colors.black,
                                  clr: Colors.orange,
                                  text: "Battery Technology",
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BatteryInfoWidget(
                                    height: height * 0.15,
                                    width: width * 0.26,
                                    txtclr: Colors.black,
                                    clr: Colors.orange,
                                    text: "Charging type"),
                                BatteryInfoWidget(
                                  height: height * 0.1,
                                  width: width * 0.26,
                                  txtclr: Colors.black,
                                  clr: Colors.orange,
                                  text: "Temprature",
                                ),
                                BatteryInfoWidget(
                                  height: height * 0.15,
                                  width: width * 0.26,
                                  txtclr: Colors.black,
                                  clr: Colors.orange,
                                  text: "Battery Technology",
                                )
                              ],
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
      ),
    );
  }
}
