import 'package:flutter/material.dart';

class AlbumNewPost extends StatelessWidget {
  const AlbumNewPost({super.key});

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
                    const Spacer(),
                  ],
                ),
              ),

              // Instead of ListView, use Column inside SingleChildScrollView
              Container(
                height: height * .35,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/outdoor.jpeg"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.blue),
                title: SizedBox(
                  width: width * .25,
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Write a caption",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const Divider(),
              SizedBox(height: height * .07),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 30,
                ),
                child: SizedBox(
                  height: height * .06,
                  width: width * .5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xffFFD700),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Post",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
