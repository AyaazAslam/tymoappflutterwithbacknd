import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/chat/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  String _uid = "";
  final Set<String> _friendIds = {};
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subSender;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subReceiver;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _uid = prefs.getString('session_uid') ?? '';
    });
    if (_uid.isNotEmpty) {
      _attachFriendsListeners();
    }
  }

  void _attachFriendsListeners() {
    final base = FirebaseFirestore.instance.collection('friendRequests');
    _subSender = base
        .where('status', isEqualTo: 'accepted')
        .where('senderId', isEqualTo: _uid)
        .snapshots()
        .listen((snap) {
          for (final d in snap.docs) {
            final receiverId = (d.data()['receiverId'] ?? '').toString();
            if (receiverId.isNotEmpty) _friendIds.add(receiverId);
          }
          setState(() {});
        });
    _subReceiver = base
        .where('status', isEqualTo: 'accepted')
        .where('receiverId', isEqualTo: _uid)
        .snapshots()
        .listen((snap) {
          for (final d in snap.docs) {
            final senderId = (d.data()['senderId'] ?? '').toString();
            if (senderId.isNotEmpty) _friendIds.add(senderId);
          }
          setState(() {});
        });
  }

  @override
  void dispose() {
    _subSender?.cancel();
    _subReceiver?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _uid.isEmpty
          ? const Center(child: Text('Please log in'))
          : (_friendIds.isEmpty
                ? const Center(child: Text('No friends yet'))
                : ListView.builder(
                    itemCount: _friendIds.length,
                    itemBuilder: (context, index) {
                      final fid = _friendIds.elementAt(index);
                      return FutureBuilder<
                        DocumentSnapshot<Map<String, dynamic>>
                      >(
                        future: FirebaseFirestore.instance
                            .collection('ayaztempUser')
                            .doc(fid)
                            .get(),
                        builder: (context, userSnap) {
                          if (userSnap.connectionState ==
                              ConnectionState.waiting) {
                            return const ListTile(
                              leading: CircleAvatar(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              title: Text('Loading...'),
                            );
                          }
                          final user = userSnap.data?.data() ?? {};
                          String nameCandidate = (user['displayName'] ?? '')
                              .toString()
                              .trim();
                          if (nameCandidate.isEmpty) {
                            nameCandidate = (user['username'] ?? '')
                                .toString()
                                .trim();
                          }
                          if (nameCandidate.isEmpty) {
                            nameCandidate = (user['email'] ?? '')
                                .toString()
                                .trim();
                          }
                          if (nameCandidate.isEmpty) {
                            nameCandidate = fid;
                          }
                          final avatar = (user['avatarUrl'] ?? '').toString();

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: avatar.isNotEmpty
                                  ? ClipOval(
                                      child: Image.network(
                                        avatar,
                                        fit: BoxFit.cover,
                                        width: 40,
                                        height: 40,
                                        errorBuilder: (c, e, s) => const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                            ),
                            title: Text(
                              nameCandidate,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(
                                    friendId: fid,
                                    friendName: nameCandidate,
                                    friendAvatar: avatar,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  )),
    );
  }
}
