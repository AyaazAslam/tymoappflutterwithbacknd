import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:getwidget/components/button/gf_button.dart';
// import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

class AcceptInvite extends StatefulWidget {
  const AcceptInvite({super.key});

  @override
  State<AcceptInvite> createState() => _AcceptInviteState();
}

class _AcceptInviteState extends State<AcceptInvite> {
  String? sessionUid;

  Widget _buildRequestTile({
    required double height,
    required String name,
    required String avatarUrl,
    required String requestId,
  }) {
    return Card(
      elevation: 1.5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : const AssetImage('images/ayaz.jpeg') as ImageProvider,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name.isNotEmpty ? name : 'Unknown',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _updateRequestStatus(requestId, 'accepted'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                minimumSize: const Size(0, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Accept'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _updateRequestStatus(requestId, 'rejected'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                minimumSize: const Size(0, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Reject'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // prefer saved session; fallback to auth immediately to avoid flicker
      sessionUid =
          prefs.getString('session_uid') ??
          FirebaseAuth.instance.currentUser?.uid;
    });
  }

  Stream<QuerySnapshot> _incomingRequests() {
    final uid = sessionUid ?? FirebaseAuth.instance.currentUser?.uid ?? '';
    return FirebaseFirestore.instance
        .collection('friendRequests')
        .where('receiverId', isEqualTo: uid)
        .snapshots();
  }

  Future<void> _updateRequestStatus(String requestId, String status) async {
    await FirebaseFirestore.instance
        .collection('friendRequests')
        .doc(requestId)
        .update({'status': status});
  }

  // final RoundedLoadingButtonController acceptbtncontroller =
  //     RoundedLoadingButtonController();
  //final RoundedLoadingButton acceptcontroller=RoundedLoadingButtonController()
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          // automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const SizedBox(
            height: 50,
            width: 50,
            child: Image(
              image: AssetImage("images/tym.jpg"),
              filterQuality: FilterQuality.high,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),

          // filterQuality: FilterQuality.high),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            color: const Color(0xff8c47FB),
            child: Text(
              "See received invitations",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                fontSize: height * 0.03,
              ),
              textScaleFactor: 1,
            ),
          ),
          Expanded(
            child:
                (sessionUid ?? FirebaseAuth.instance.currentUser?.uid) ==
                        null ||
                    ((sessionUid ?? FirebaseAuth.instance.currentUser?.uid) ??
                            '')
                        .isEmpty
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot>(
                    stream: _incomingRequests(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Error loading invitations',
                              style: GoogleFonts.poppins(color: Colors.red),
                            ),
                          ),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * .25,
                                  child: const Image(
                                    image: AssetImage('images/acept.png'),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No invitations yet',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // Filter pending only and sort by timestamp desc on client
                      final requests =
                          snapshot.data!.docs.where((doc) {
                            final m = doc.data() as Map<String, dynamic>;
                            return (m['status'] ?? 'pending') == 'pending';
                          }).toList()..sort((a, b) {
                            final am = a.data() as Map<String, dynamic>;
                            final bm = b.data() as Map<String, dynamic>;
                            final at =
                                (am['timestamp'] as Timestamp?)?.toDate() ??
                                DateTime.fromMillisecondsSinceEpoch(0);
                            final bt =
                                (bm['timestamp'] as Timestamp?)?.toDate() ??
                                DateTime.fromMillisecondsSinceEpoch(0);
                            return bt.compareTo(at);
                          });
                      if (requests.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * .25,
                                  child: const Image(
                                    image: AssetImage('images/acept.png'),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No invitations yet',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        itemCount: requests.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, idx) {
                          final req = requests[idx];
                          final data = req.data() as Map<String, dynamic>;
                          final senderName = (data['senderName'] ?? '')
                              .toString()
                              .trim();
                          final senderAvatar = (data['senderAvatar'] ?? '')
                              .toString();
                          final senderId = (data['senderId'] ?? '').toString();

                          // If name missing, fetch from users profile as fallback
                          if (senderName.isEmpty && senderId.isNotEmpty) {
                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('ayaztempUser')
                                  .doc(senderId)
                                  .get(),
                              builder: (context, snap) {
                                String fallbackName = 'Unknown';
                                String fallbackAvatar = senderAvatar;
                                if (snap.hasData && snap.data!.exists) {
                                  final m =
                                      (snap.data!.data() ?? {})
                                          as Map<String, dynamic>;
                                  final dn = (m['displayName'] ?? '')
                                      .toString()
                                      .trim();
                                  final un = (m['username'] ?? '')
                                      .toString()
                                      .trim();
                                  fallbackName = dn.isNotEmpty
                                      ? dn
                                      : (un.isNotEmpty ? un : 'Unknown');
                                  final av = (m['avatarUrl'] ?? '')
                                      .toString()
                                      .trim();
                                  if (fallbackAvatar.isEmpty && av.isNotEmpty) {
                                    fallbackAvatar = av;
                                  }
                                }
                                return _buildRequestTile(
                                  height: height,
                                  name: fallbackName,
                                  avatarUrl: fallbackAvatar,
                                  requestId: req.id,
                                );
                              },
                            );
                          }
                          return _buildRequestTile(
                            height: height,
                            name: senderName,
                            avatarUrl: senderAvatar,
                            requestId: req.id,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
