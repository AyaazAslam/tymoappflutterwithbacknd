import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/show_custom_snackbar.dart';

class ChatScreen extends StatefulWidget {
  final String friendId;
  final String friendName;
  final String friendAvatar;

  const ChatScreen({
    super.key,
    required this.friendId,
    required this.friendName,
    required this.friendAvatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _myUid = '';
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _myUid = prefs.getString('session_uid') ?? '';
    });
    if (_myUid.isNotEmpty) {
      // Mark myself online while chatting
      await FirebaseFirestore.instance
          .collection('ayaztempUser')
          .doc(_myUid)
          .set({
            'online': true,
            'lastSeen': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
    }
  }

  @override
  void dispose() {
    // Best-effort mark offline on dispose
    if (_myUid.isNotEmpty) {
      FirebaseFirestore.instance.collection('ayaztempUser').doc(_myUid).set({
        'online': false,
        'lastSeen': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
    _messageController.dispose();
    super.dispose();
  }

  String _chatId(String a, String b) {
    final list = [a, b]..sort();
    return '${list[0]}_${list[1]}';
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _messagesStream() {
    if (_myUid.isEmpty) {
      return const Stream<QuerySnapshot<Map<String, dynamic>>>.empty();
    }
    final cid = _chatId(_myUid, widget.friendId);
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(cid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(200)
        .snapshots();
  }

  Future<void> _sendMessage() async {
    if (_myUid.isEmpty) return;
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    final cid = _chatId(_myUid, widget.friendId);
    _messageController.clear();
    try {
      await FirebaseFirestore.instance.collection('chats').doc(cid).set({
        'participants': [_myUid, widget.friendId],
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(cid)
          .collection('messages')
          .add({
            'senderId': _myUid,
            'text': text,
            'timestamp': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      if (!mounted) return;
      showCustomSnackbar(message: 'Failed to send: $e', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: widget.friendAvatar.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        widget.friendAvatar,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.person, color: Colors.white),
                      ),
                    )
                  : const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.friendName.isNotEmpty ? widget.friendName : 'Chat',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('ayaztempUser')
                        .doc(widget.friendId)
                        .snapshots(),
                    builder: (context, snap) {
                      final online =
                          (snap.data?.data()?['online'] ?? false) == true;
                      return Text(
                        online ? 'Online' : 'Offline',
                        style: TextStyle(
                          color: online ? Colors.green : Colors.grey,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _myUid.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _messagesStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final msgs = snapshot.data?.docs ?? [];
                      if (msgs.isEmpty) {
                        return const Center(child: Text('Say hello 👋'));
                      }
                      return ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: msgs.length,
                        itemBuilder: (context, index) {
                          final m = msgs[index].data();
                          final isMe = m['senderId'] == _myUid;
                          final text = (m['text'] ?? '').toString();
                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: isMe ? 60 : 12,
                                right: isMe ? 12 : 60,
                                top: 4,
                                bottom: 4,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? const Color(0xFF2F76EA)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                text,
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF2F76EA),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
