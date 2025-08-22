import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/generinfo/general_info.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralInfoPage extends StatefulWidget {
  const GeneralInfoPage({super.key});

  @override
  State<GeneralInfoPage> createState() => _GeneralInfoPageState();
}

class _GeneralInfoPageState extends State<GeneralInfoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                    const Spacer(),
                  ],
                ),
              ),
              // Expanded widget must have a child
              Container(
                height: height * 0.9, // or any fixed height
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF50c9c2), Color(0xFF95DEDA)]),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                    Expanded(
                        child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 7,
                                ),
                                GeneralInfoWidget(
                                    height: height * .1,
                                    width: width * .3,
                                    clr: Colors.white,
                                    txtclr: Colors.black,
                                    text: "Screen State\n unloack"),
                                GeneralInfoWidget(
                                    height: height * .2,
                                    width: width * .3,
                                    clr: Colors.white,
                                    txtclr: Colors.black,
                                    text:
                                        "System volume \n 0/7 \n Media Vlume \n 4/7"),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 7,
                                ),
                                GeneralInfoWidget(
                                    height: height * .2,
                                    width: width * .3,
                                    clr: Colors.white,
                                    txtclr: Colors.black,
                                    text:
                                        "System volume \n 0/7 \n Media Vlume \n 4/7"),
                                GeneralInfoWidget(
                                    height: height * .1,
                                    width: width * .3,
                                    clr: Colors.white,
                                    txtclr: Colors.black,
                                    text: "Screen State\n unloack"),
                              ],
                            ),
                          )),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                const SizedBox(
                                  height: 7,
                                ),
                                GeneralInfoWidget(
                                    height: height * .2,
                                    width: width * .3,
                                    clr: Colors.green,
                                    txtclr: Colors.black,
                                    text: "Screen State\n unloack"),
                                GeneralInfoWidget(
                                    height: height * .1,
                                    width: width * .3,
                                    clr: Colors.green,
                                    txtclr: Colors.black,
                                    text:
                                        "System volume \n 0/7 \n Media Vlume \n 4/7"),
                              ],
                            ),
                          )),
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 7,
                                ),
                                GeneralInfoWidget(
                                    height: height * .1,
                                    width: width * .3,
                                    clr: Colors.green,
                                    txtclr: Colors.black,
                                    text:
                                        "System volume \n 0/7 \n Media Vlume \n 4/7"),
                                GeneralInfoWidget(
                                    height: height * .2,
                                    width: width * .3,
                                    clr: Colors.green,
                                    txtclr: Colors.black,
                                    text: "Screen State\n unloack"),
                              ],
                            ),
                          )),
                        ],
                      ),
                    )),
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
