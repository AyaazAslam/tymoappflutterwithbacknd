import 'dart:async';
import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/Views/Widgets/Auth/auth_text_field.dart';
import 'package:flutter_application_1/Views/invitations/invite_friend.dart';
import 'package:page_transition/page_transition.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  // Pick image from gallery
  Future<void> handlerChoosedfromGallery() async {
    final pickedImage = await img.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1920,
    );
    if (pickedImage == null) return;

    setState(() {
      file = File(pickedImage.path);
    });

    // Upload to Firebase when image is selected
    if (file != null) {
      await uploadToStorage();
    }
  }

  // Upload process
  Future<void> uploadToStorage() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage();

    // Save to Firestore with current user UID
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection("TemoAsghar").doc(uid).set({
        "name": nameController.text.trim(),
        "username": userNameController.text.trim(),
        "gender": isMale ? "male" : "female",
        "profileImage": mediaUrl,
      }, SetOptions(merge: true));
    }

    debugPrint("Image uploaded: $mediaUrl");

    setState(() {
      isUploading = false;
    });
  }

  // Upload to Firebase Storage
  Future<String> uploadImage() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("profilePictures/$postId.jpg")
        .putFile(file!);

    TaskSnapshot storageSnap = await uploadTask;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Compress image
  Future<void> compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    im.Image? imageFile = im.decodeImage(file!.readAsBytesSync());

    if (imageFile == null) return;

    final compressedImageFile = File("$path/image_$postId.jpg")
      ..writeAsBytesSync(im.encodeJpg(imageFile, quality: 80));

    setState(() {
      file = compressedImageFile;
    });
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
