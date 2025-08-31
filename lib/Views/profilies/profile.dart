import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/Widgets/Profiles/profile_detail.dart';
import 'package:flutter_application_1/Views/Widgets/custom_button.dart';
import 'package:flutter_application_1/show_custom_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool more = false;
  String _displayName = "";
  String _username = "";
  String _avatarUrl = "";
  String _email = "";
  bool _uploading = false;
  String _sessionUid = "";

  @override
  void initState() {
    super.initState();
    _loadSessionProfile();
  }

  Future<void> _loadSessionProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDisplayName = prefs.getString('session_displayName') ?? "";
    final savedEmail = prefs.getString('session_email') ?? "";
    final savedAvatar = prefs.getString('session_avatarUrl') ?? "";
    _sessionUid = prefs.getString('session_uid') ?? "";

    // Derive a simple username from email if not explicitly stored
    final derivedUsername = savedEmail.contains('@')
        ? savedEmail.split('@').first
        : "";

    setState(() {
      _displayName = savedDisplayName;
      _username = derivedUsername;
      _avatarUrl = savedAvatar;
      _email = savedEmail;
    });
  }

  Future<void> _pickAndUploadAvatar() async {
    if (_uploading) return;
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked == null) return;
      if (_sessionUid.isEmpty) {
        if (!mounted) return;
        showCustomSnackbar(
          message: 'Please log in to update your photo.',
          context: context,
        );
        return;
      }
      setState(() {
        _uploading = true;
      });
      final storageRef = FirebaseStorage.instance.ref().child(
        'avatars/$_sessionUid.jpg',
      );
      final bytes = await picked.readAsBytes();
      await storageRef.putData(
        bytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final url = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('ayaztempUser')
          .doc(_sessionUid)
          .set({'avatarUrl': url}, SetOptions(merge: true));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('session_avatarUrl', url);

      if (!mounted) return;
      setState(() {
        _avatarUrl = url;
      });
      showCustomSnackbar(message: 'Profile photo updated', context: context);
    } catch (e) {
      if (!mounted) return;
      showCustomSnackbar(message: 'Upload failed: $e', context: context);
    } finally {
      if (!mounted) return;
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              "My Profile ",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: height * 0.021,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
              ),
            ),
            GestureDetector(
              onTap: _pickAndUploadAvatar,
              child: Container(
                height: height * .1,
                width: width * .22,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: ClipOval(
                  child: _avatarUrl.isNotEmpty
                      ? Image.network(
                          _avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                ),
              ),
            ),
            if (_uploading)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            SizedBox(height: height * 0.03),
            Text(
              (_displayName.isNotEmpty ? _displayName : _username).isNotEmpty
                  ? (_displayName.isNotEmpty ? _displayName : _username)
                  : "",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
              ),
            ),
            Text(
              _username.isNotEmpty ? "@$_username" : "",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: 1,
              ),
            ),
            const CustomButtonWidget(
              text: "Edit Profile Details",
              color: Colors.white,
              leadingIcon: Icons.edit,
            ),
            const SizedBox(height: 5),
            if (!more) ...[
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ProfileDetailWidgets(
                  type: "Email",
                  val: _email.isNotEmpty ? _email : "Not set",
                  icon: Icons.email_sharp,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),

                child: const ProfileDetailWidgets(
                  icon: Icons.flag_sharp,
                  type: "Country",
                  val: "Shangacer",
                  color: Colors.white,
                ),
              ),
            ],
            if (more) ...[
              ProfileDetailWidgets(
                type: "Email",
                val: _email.isNotEmpty ? _email : "Not set",
                icon: Icons.email_sharp,
                color: Colors.white,
              ),
              const ProfileDetailWidgets(
                icon: Icons.flag_sharp,
                type: "Country",
                val: "Shangacer",
                color: Colors.white,
              ),
              const ProfileDetailWidgets(
                icon: Icons.phone_callback_sharp,
                type: "Phone Number",
                val: "Not Currently Set",
                color: Colors.white,
              ),
              const ProfileDetailWidgets(
                icon: Icons.male_sharp,
                type: "Gender",
                val: "Male",
                color: Colors.white,
              ),
              const ProfileDetailWidgets(
                icon: Icons.female,
                type: "Partner",
                val: "Robbie Williams",
                color: Colors.white,
              ),
              const ProfileDetailWidgets(
                icon: Icons.upload_file,
                type: "UID",
                val: "hjjhjjhjh jkkkkkkkk",
                color: Colors.white,
              ),
              const ProfileDetailWidgets(
                icon: Icons.account_box,
                type: "Acounts Created",
                val: "24-4-25",
                color: Colors.white,
              ),
            ],
            ElevatedButton(
              style: ButtonStyle(
                side: WidgetStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.grey.shade200),
                ),
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
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height * .15,
                  width: width * .3,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffff9966), Color(0xffff5e62)],
                    ),
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
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Premum",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
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
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Premum",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
