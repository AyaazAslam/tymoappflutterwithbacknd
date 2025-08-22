import 'package:flutter/material.dart';

class Album_MainPage extends StatefulWidget {
  const Album_MainPage({super.key});

  @override
  State<Album_MainPage> createState() => _Album_MainPageState();
}

class _Album_MainPageState extends State<Album_MainPage> {
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    BoxDecoration imageBoxDecoration(String assetPath) {
      return BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              height: height * 0.06,
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    decoration: imageBoxDecoration("images/tym.jpg"),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            // Album Title Bar
            Container(
              alignment: Alignment.center,
              height: height * 0.08,
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Faizan's Album",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            // Image Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Column
                    Column(
                      children: [
                        Container(
                          height: height * 0.2,
                          width: width * 0.43,
                          decoration: imageBoxDecoration("images/roads.jpg"),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: height * 0.2,
                          width: width * 0.43,
                          decoration: imageBoxDecoration("images/roads1.jpg"),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: height * 0.2,
                          width: width * 0.43,
                          decoration: imageBoxDecoration("images/office.jpg"),
                        ),
                      ],
                    ),

                    // Right Column
                    Column(
                      children: [
                        Container(
                          height: height * 0.31,
                          width: width * 0.43,
                          decoration: imageBoxDecoration("images/office1.jpg"),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: height * 0.31,
                          width: width * 0.43,
                          decoration: imageBoxDecoration("images/office2.jpg"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
