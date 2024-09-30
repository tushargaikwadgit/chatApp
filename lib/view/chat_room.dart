import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic>? userMap;
  final String? chatRoomId;
  ChatRoom({this.chatRoomId, this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendMessage() async {
    print("Display Name: ${auth.currentUser!.displayName}");

    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": auth.currentUser!.displayName,
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
      };
      try {
        await _firestore
            .collection('chatRooms')
            .doc(chatRoomId)
            .collection('chats')
            .add(messages);
        print("Message sent: ${messages['message']}");
        _message.clear();
      } catch (e) {
        print(e);
      }
    } else {
      print("Enter some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text(userMap != null ? userMap!['name'] : 'Chat Room'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatRooms')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        bool isSentByMe = snapshot.data!.docs[index]
                                ['sendby'] ==
                            auth.currentUser!.displayName;

                        return Row(
                          mainAxisAlignment: isSentByMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isSentByMe)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: SvgPicture.asset(
                                    "lib/assets/images/Rectangle 1092.svg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: isSentByMe
                                      ? const Color.fromRGBO(61, 74, 122, 1)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(12),
                                    topRight: const Radius.circular(12),
                                    bottomLeft: isSentByMe
                                        ? const Radius.circular(12)
                                        : Radius.zero,
                                    bottomRight: isSentByMe
                                        ? Radius.zero
                                        : const Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: isSentByMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['message'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateTime.fromMillisecondsSinceEpoch(
                                              (snapshot.data!.docs[index]
                                                          ['time'] as Timestamp)
                                                      .millisecondsSinceEpoch *
                                                  1000)
                                          .toLocal()
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return const Center(child: Text("No messages yet"));
                },
              ),
            ),
            // Message input field and send button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                        hintText: "Enter message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
