import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/DeviceButton/device_space.dart';

class DeviceSpacePage extends StatefulWidget {
  const DeviceSpacePage({super.key});

  @override
  State<DeviceSpacePage> createState() => _DeviceSpacePageState();
}

class _DeviceSpacePageState extends State<DeviceSpacePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: SafeArea(
      //   child: Column(

      //     children: [
      //     // Top Bar
      //     Container(
      //       height: height * 0.05,
      //       padding: const EdgeInsets.symmetric(horizontal: 10),
      //       child: Row(
      //         children: [
      //           IconButton(
      //             onPressed: () {},
      //             icon: const Icon(Icons.arrow_back_ios_new),
      //           ),
      //           const Spacer(),
      //           Container(
      //             height: height * 0.05,
      //             width: width * 0.22,
      //             decoration: const BoxDecoration(
      //               image: DecorationImage(
      //                 image: AssetImage("images/tym.jpg"),
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //           ),
      //           const Spacer()
      //         ],
      //       ),
      //     ),
      //     Expanded(
      //       child: Container(

      //         child: Column(
      //           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 15),
      //               child: Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text(
      //                   "Device Information",
      //                   style: GoogleFonts.poppins(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w600,
      //                     fontSize: 16,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [

      //                     // ),
      //                     //     DeviceSpaceWidget(
      //                     // height: height * .17,
      //                     // width: width * .31,
      //                     // title: "External Memory",
      //                     // type: "5.37 GB",
      //                     // txtclr: Colors.white),
      //                   ],
      //                 ),
      //                 DeviceSpaceWidget(
      //                     height: height * .23,
      //                     width: width * .31,
      //                     title: "Internal Memory",
      //                     type: "5.37 GB",
      //                     txtclr: Colors.white),
      //               ],
      //             ),
      //             const SizedBox(
      //               height: 33,
      //             ),

      //             Container(
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 //  crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     children: [
      //                       DeviceSpaceWidget(
      //                           height: height * .17,
      //                           width: width * .31,
      //                           title: "Internal Memory",
      //                           type: "5.37 GB",
      //                           txtclr: Colors.white),
      //                       // Padding(
      //                       //   padding: const EdgeInsets.only(top: 16),
      //                       DeviceSpaceWidget(
      //                           height: height * .17,
      //                           width: width * .31,
      //                           title: "External Memory",
      //                           type: "5.37 GB",
      //                           txtclr: Colors.white),
      //                       // ),
      //                     ],
      //                   ),
      //                   Column(
      //                     children: [
      //                       DeviceSpaceWidget(
      //                           height: height * .1,
      //                           width: width * .31,
      //                           title: "Total Ram",
      //                           type: "5.37 GB",
      //                           txtclr: Colors.white),
      //                       // Padding(
      //                       //   padding: const EdgeInsets.only(top: 16),
      //                       DeviceSpaceWidget(
      //                           height: height * .1,
      //                           width: width * .31,
      //                           title: "Refresh Rate",
      //                           type: "6 HZ",
      //                           txtclr: Colors.white),
      //                       // )
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ), //
      //           ],
      //         ),
      //       ),
      //     )
      //   ]),
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal.shade800, Colors.teal.shade300])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              color: Colors.red,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        DeviceSpaceWidget(
                            height: height * .15,
                            width: width * .41,
                            title: "Total Ram",
                            type: "5.37 GB",
                            txtclr: Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                        DeviceSpaceWidget(
                            height: height * .1,
                            width: width * .31,
                            title: "Refresh Rate",
                            type: "6 HZ",
                            txtclr: Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 170,
                          width: 200,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 170,
                          width: 200,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 22,
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 190,
                          width: 200,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 190,
                          width: 200,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 120,
                          width: 200,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 120,
                          width: 200,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
