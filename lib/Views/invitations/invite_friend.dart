import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/invitations/accept_invite.dart';
import 'package:flutter_application_1/show_custom_snackbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  final TextEditingController searchController = TextEditingController();
  String searchText = "";
  String? sessionUid;
  String? sessionEmail;
  String? sessionDisplayName;
  String? sessionAvatarUrl;
  final Set<String> _sentReceiverIds = {};

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sessionUid = prefs.getString('session_uid');
      sessionEmail = prefs.getString('session_email');
      sessionDisplayName = prefs.getString('session_displayName');
      sessionAvatarUrl = prefs.getString('session_avatarUrl');
    });
  }

  // ✅ function to send friend request
  Future<void> sendFriendRequest(String receiverId) async {
    // prefer session (email/password auth does not provide FirebaseAuth user here)
    final prefs = await SharedPreferences.getInstance();
    final senderId =
        prefs.getString('session_uid') ??
        FirebaseAuth.instance.currentUser?.uid;
    final senderEmail =
        prefs.getString('session_email') ??
        FirebaseAuth.instance.currentUser?.email;
    String senderName =
        prefs.getString('session_displayName') ??
        FirebaseAuth.instance.currentUser?.displayName ??
        '';
    String senderAvatar =
        prefs.getString('session_avatarUrl') ??
        FirebaseAuth.instance.currentUser?.photoURL ??
        '';
    if (senderId == null || senderId.isEmpty) return;

    try {
      // Check any relation in either direction
      final coll = FirebaseFirestore.instance.collection("friendRequests");
      final myPending = await coll
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: receiverId)
          .limit(1)
          .get();
      final theirPending = await coll
          .where('senderId', isEqualTo: receiverId)
          .where('receiverId', isEqualTo: senderId)
          .limit(1)
          .get();

      bool anyAccepted = false;
      bool anyPendingFromMe = false;
      bool anyPendingToMe = false;

      if (myPending.docs.isNotEmpty) {
        final status = (myPending.docs.first.data()['status'] ?? '').toString();
        if (status == 'accepted') anyAccepted = true;
        if (status == 'pending') anyPendingFromMe = true;
      }
      if (theirPending.docs.isNotEmpty) {
        final status = (theirPending.docs.first.data()['status'] ?? '')
            .toString();
        if (status == 'accepted') anyAccepted = true;
        if (status == 'pending') anyPendingToMe = true;
      }

      if (anyAccepted) {
        showCustomSnackbar(message: "Already friends", context: context);
        return;
      }
      if (anyPendingFromMe) {
        setState(() {
          _sentReceiverIds.add(receiverId);
        });
        showCustomSnackbar(message: "Request already sent", context: context);
        return;
      }
      if (anyPendingToMe) {
        showCustomSnackbar(
          message: "They requested you. Tap Accept.",
          context: context,
        );
        return;
      }

      // If name/avatar are missing, fetch from user profile
      if (senderName.isEmpty || senderAvatar.isEmpty) {
        final profileSnap = await FirebaseFirestore.instance
            .collection('ayaztempUser')
            .doc(senderId)
            .get();
        final profile = profileSnap.data() ?? {};
        if (senderName.isEmpty) {
          senderName =
              (profile['displayName'] ?? profile['username'] ?? 'No Name')
                  .toString();
        }
        if (senderAvatar.isEmpty) {
          senderAvatar = (profile['avatarUrl'] ?? '').toString();
        }
      }

      await FirebaseFirestore.instance.collection("friendRequests").add({
        "senderId": senderId,
        "senderEmail": senderEmail,
        "senderName": senderName,
        "senderAvatar": senderAvatar,
        "receiverId": receiverId,
        "status": "pending",
        "timestamp": FieldValue.serverTimestamp(),
      });

      showCustomSnackbar(message: "Friend request sent!", context: context);

      setState(() {
        _sentReceiverIds.add(receiverId);
      });
    } catch (e) {
      debugPrint("Error sending request: $e");
      showCustomSnackbar(message: "Error: $e", context: context);
    }
  }

  Future<void> acceptFriendRequest(String senderId) async {
    try {
      final myId = sessionUid ?? FirebaseAuth.instance.currentUser?.uid;
      if (myId == null || myId.isEmpty) return;
      final q = await FirebaseFirestore.instance
          .collection('friendRequests')
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: myId)
          .where('status', isEqualTo: 'pending')
          .get();
      for (final d in q.docs) {
        await d.reference.update({'status': 'accepted'});
      }
      if (!mounted) return;
      showCustomSnackbar(message: 'Request accepted', context: context);
    } catch (e) {
      if (!mounted) return;
      showCustomSnackbar(message: 'Failed to accept: $e', context: context);
    }
  }

  // merged relationship state stream
  Stream<Map<String, bool>> _relationshipStateStream(String otherId) {
    final myId = sessionUid ?? FirebaseAuth.instance.currentUser?.uid ?? '';
    final base = FirebaseFirestore.instance.collection('friendRequests');
    final asSender = base
        .where('senderId', isEqualTo: myId)
        .where('receiverId', isEqualTo: otherId)
        .snapshots();
    final asReceiver = base
        .where('senderId', isEqualTo: otherId)
        .where('receiverId', isEqualTo: myId)
        .snapshots();

    QuerySnapshot<Map<String, dynamic>>? sA;
    QuerySnapshot<Map<String, dynamic>>? sB;

    Map<String, bool> compute() {
      bool accepted = false;
      bool pendingFromMe = false;
      bool pendingToMe = false;
      for (final s in [sA, sB]) {
        if (s == null) continue;
        for (final d in s.docs) {
          final data = d.data();
          final status = (data['status'] ?? '').toString();
          final sender = (data['senderId'] ?? '').toString();
          if (status == 'accepted') accepted = true;
          if (status == 'pending') {
            if (sender == myId) {
              pendingFromMe = true;
            } else {
              pendingToMe = true;
            }
          }
        }
      }
      return {
        'accepted': accepted,
        'pendingFromMe': pendingFromMe,
        'pendingToMe': pendingToMe,
      };
    }

    return Stream<Map<String, bool>>.multi((controller) {
      final sub1 = asSender.listen((snap) {
        sA = snap;
        controller.add(compute());
      });
      final sub2 = asReceiver.listen((snap) {
        sB = snap;
        controller.add(compute());
      });
      controller.onCancel = () {
        sub1.cancel();
        sub2.cancel();
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const SizedBox(
            height: 50,
            child: Image(image: AssetImage("images/tym.jpg")),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const AcceptInvite(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.purple,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 🔹 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      hintText: "Type name or email...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchText = val.toLowerCase();
                      });
                    },
                  ),
                ),
                SizedBox(width: width * 0.02),
                Container(
                  height: height * .07,
                  width: height * .07,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),

          // 🔹 User List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("ayaztempUser")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                final currentUserId =
                    sessionUid ?? FirebaseAuth.instance.currentUser?.uid;

                // ✅ Exclude current user + Apply search filter
                final users = snapshot.data!.docs.where((doc) {
                  if (doc["uid"] == currentUserId) return false;

                  final name =
                      ((doc["displayName"] ?? doc['username'] ?? "").toString())
                          .toLowerCase();
                  final email = (doc["email"] ?? "").toString().toLowerCase();

                  return searchText.isEmpty ||
                      name.contains(searchText) ||
                      email.contains(searchText);
                }).toList();

                if (users.isEmpty) {
                  return const Center(child: Text("No matching users found"));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];

                    final username = (user['username'] ?? '').toString().trim();
                    final displayName = (user['displayName'] ?? '')
                        .toString()
                        .trim();
                    final email = (user['email'] ?? '').toString().trim();

                    final titleText = username.isNotEmpty
                        ? username
                        : (displayName.isNotEmpty ? displayName : 'No Name');
                    final hasDisplay =
                        displayName.isNotEmpty && displayName != username;
                    final subtitleText = hasDisplay && email.isNotEmpty
                        ? '$displayName  •  $email'
                        : (email.isNotEmpty
                              ? email
                              : (hasDisplay ? displayName : 'No Email'));

                    return ListTile(
                      title: Text(
                        titleText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(subtitleText),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child:
                            (user["avatarUrl"] != null &&
                                user["avatarUrl"].toString().isNotEmpty)
                            ? ClipOval(
                                child: Image.network(
                                  user["avatarUrl"],
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                  errorBuilder: (c, e, s) => const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(Icons.person, color: Colors.white),
                      ),
                      trailing: StreamBuilder<Map<String, bool>>(
                        stream: _relationshipStateStream(user['uid']),
                        builder: (context, relSnap) {
                          final state =
                              relSnap.data ??
                              const {
                                'accepted': false,
                                'pendingFromMe': false,
                                'pendingToMe': false,
                              };
                          final hasAccepted = state['accepted'] == true;
                          final hasPendingFromMe =
                              state['pendingFromMe'] == true;
                          final hasPendingToMe = state['pendingToMe'] == true;

                          if (hasAccepted) {
                            return const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            );
                          }
                          if (hasPendingFromMe) {
                            return const Text(
                              'Pending',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          if (hasPendingToMe) {
                            return ElevatedButton(
                              onPressed: () => acceptFriendRequest(user['uid']),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () => sendFriendRequest(user["uid"]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
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
