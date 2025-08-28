import 'dart:async';
import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Model/my_user.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_text_field.dart';
import 'package:flutter_application_1/Views/invitations/invite_friend.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  bool isMale = true;
  File? file;
  String postId = const Uuid().v4();

  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  bool isUploading = false;
  final ImagePicker img = ImagePicker();
  Future<void> uploadToStorage() async {
    if (nameController.text.trim().isEmpty ||
        userNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() {
      isUploading = true;
    });

    String? mediaUrl;

    // 🔹 Upload profile picture if selected
    if (file != null) {
      await compressImage();
      mediaUrl = await uploadImage();
    }

    // 🔹 Always get the current logged-in user's uid (we saved email as uid during signUp)
    // final currentUser = FirebaseAuth.instance.currentUser;
    Uuid uuid = const Uuid();
    String userId = uuid.v4();
    // final uid = currentUser?.uid ?? currentUser?.email;


    // 🔹 Update only the profile-related fields
 await FirebaseFirestore.instance
    .collection("ayaztempUser")
    .doc(userId)
    .set({
      "username": userNameController.text.trim(),
      "displayName": nameController.text.trim(),
      "avatarUrl": mediaUrl ?? "",
      "gender": isMale ? "male" : "female",
      "isLoadingStartupData": false,
    }, SetOptions(merge: true));

    debugPrint("✅ User profile updated for $userId");

    setState(() {
      isUploading = false;
    });
  }

  Future<void> handlerChoosedfromGallery() async {
    final XFile? image = await img.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
  }

  Future<void> compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    im.Image? imageFile = im.decodeImage(file!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadImage() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profilePictures")
        .child("post_$postId.jpg");
    UploadTask uploadTask = ref.putFile(file!);
    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    userNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const SizedBox(
          height: 100,
          width: 100,
          child: Image(image: AssetImage("images/tym.jpg")),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff000221)),
              child: Text(
                "Profile Setup",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Avatar
            CircularProfileAvatar(
              "",
              onTap: handlerChoosedfromGallery,
              backgroundColor: Colors.cyan,
              child: file != null
                  ? ClipOval(
                      child: Image.file(
                        file!,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
                    )
                  : Center(
                      child: Text(
                        "+",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 50),

            // Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AuthTextField(
                labelText: "Your Name",
                icon: Icons.face,
                size: 16,
                keyboardType: TextInputType.text,
                obscureText: false,
                controller: nameController,
              ),
            ),
            const SizedBox(height: 20),

            // Username
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AuthTextField(
                labelText: "Your Username",
                controller: userNameController,
                icon: Icons.alternate_email,
                size: 16,
                keyboardType: TextInputType.text,
                obscureText: false,
              ),
            ),
            const SizedBox(height: 50),

            // Gender buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isMale = true),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: isMale ? Colors.cyan : Colors.grey,
                    child: const Icon(Icons.male, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => isMale = false),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: !isMale ? Colors.purple : Colors.grey,
                    child: const Icon(Icons.female, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Next button
            SizedBox(
              width: double.infinity,
              height: height * 0.065,
              child: ElevatedButton(
                onPressed: () async {
                  if (isUploading) return;
                  await uploadToStorage();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const InviteFriend(),
                    ),
                  );
                  nameController.clear();
                  userNameController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff00c1AA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Next",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
              ),
            ),
            SizedBox(height: height * 0.025),
          ],
        ),
      ),
    );
  }
}
