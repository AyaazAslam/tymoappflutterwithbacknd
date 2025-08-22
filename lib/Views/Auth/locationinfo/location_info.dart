import 'package:flutter/material.dart';

class LocationInfoPage extends StatefulWidget {
  const LocationInfoPage({super.key});

  @override
  State<LocationInfoPage> createState() => _LocationInfoPageState();
}

class _LocationInfoPageState extends State<LocationInfoPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 188, 236),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Container(
              color: Colors.white,
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

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Location Status:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  height: height * .09,
                  width: width * .65,
                  child: const ListTile(
                    leading: Icon(Icons.location_on, color: Colors.red),
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'North Loop West Freeway,\n Houston, Texas',
                        style: TextStyle(fontSize: 16, color: Colors.purple),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'United States',
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text('Last Updated: 1 min ago'),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      topLeft: Radius.circular(50.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'My Location Status:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        height: height * .09,
                        width: width * .7,
                        decoration: const BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: const ListTile(
                          leading: Icon(Icons.location_on, color: Colors.white),
                          title: Text(
                            'Alta Vista Drive, Pasadena,\n Texas',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'United States',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
