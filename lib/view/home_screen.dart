import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/controller/methods.dart';
import 'package:firebase_project1/view/chat_room.dart';
import 'package:firebase_project1/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchcontroller = TextEditingController();
  bool isloading = false;
  Map<String, dynamic> userMap = {};
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> userChatRooms = [];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _fetchChatRooms();
  }

  void _fetchChatRooms() async {
    if (auth.currentUser != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("chatRooms")
          .orderBy("lastMessageTime", descending: true)
          .snapshots()
          .listen((querySnapshot) {
        setState(() {
          userChatRooms = querySnapshot.docs.map((doc) => doc.data()).toList();
        });
      });
    }
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  void onSearch() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    setState(() {
      isloading = true;
    });
    try {
      QuerySnapshot snapshot = await firestore
          .collection("users")
          .where("email", isEqualTo: searchcontroller.text)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          userMap = snapshot.docs[0].data() as Map<String, dynamic>;
          isloading = false;
        });
      } else {
        setState(() {
          userMap = {};
          isloading = false;
        });
        print("No user found");
      }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: const Color.fromRGBO(61, 74, 122, 1),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 61),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                  child: TextField(
                    controller: searchcontroller,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      onSearch();
                    },
                    child: const Text("Search")),
                const SizedBox(height: 20),
                userMap.isNotEmpty
                    ? ListTile(
                        onTap: () async {
                          if (auth.currentUser != null &&
                              userMap.containsKey('name')) {
                            String currentUserName =
                                auth.currentUser!.displayName ??
                                    auth.currentUser!.email!;
                            String roomID =
                                chatRoomId(currentUserName, userMap['name']);

                            try {
                              DocumentSnapshot chatRoomSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(auth.currentUser!.uid)
                                      .collection("chatRooms")
                                      .doc(roomID)
                                      .get();

                              if (!chatRoomSnapshot.exists) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(auth.currentUser!.uid)
                                    .collection("chatRooms")
                                    .doc(roomID)
                                    .set({
                                  "chatRoomId": roomID,
                                  "userMap": userMap,
                                  "lastMessageTime":
                                      FieldValue.serverTimestamp(),
                                });
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                    chatRoomId: roomID,
                                    userMap: userMap,
                                  ),
                                ),
                              );
                            } catch (e) {
                              print("Error while accessing chat room: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('An error occurred: $e')),
                              );
                            }
                          } else {
                            print(
                                "Current user or userMap data is not available");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Error: User information is missing'),
                              ),
                            );
                          }
                        },
                        leading:
                            const Icon(Icons.account_box, color: Colors.black),
                        title: Text(
                          userMap['name'],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(userMap['email']),
                        trailing: const Icon(Icons.chat, color: Colors.black),
                      )
                    : const Text("No user found."),
              ],
            ),
    );
  }
}
