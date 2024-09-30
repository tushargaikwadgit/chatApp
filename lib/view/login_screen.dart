import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/view/home_screen.dart';
import 'package:firebase_project1/view/sign_in.dart';
import 'package:firebase_project1/view/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleuser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user!.uid).get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
        });
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(67, 17, 106, 1),
              Color.fromRGBO(104, 225, 253, 1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            stops: [0, 1.6],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 85, left: 26),
              child: SizedBox(
                width: 338,
                height: 388,
                child: Column(
                  children: [
                    Text(
                      "Connect friends easily & quickly",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 68,
                        //height: 78,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 26),
              child: SizedBox(
                width: 327,
                height: 52,
                child: Text(
                  "Our chat app is the perfect way to stay connected with friends and family.",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 44, left: 115),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 0.19),
                      ),
                      child: SvgPicture.asset(
                        "lib/assets/images/Facebook-f_Logo-Blue-Logo.wine.svg",
                        width: 46,
                        height: 36,
                      ),
                    ),
                  ),
                  const SizedBox(width: 22),
                  GestureDetector(
                    onTap: () {
                      _signInWithGoogle();
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 0.19),
                      ),
                      child: SvgPicture.asset(
                        "lib/assets/images/Google_Pay-Logo.wine (1).svg",
                        width: 46,
                        height: 36,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 0.19),
                      ),
                      child: SvgPicture.asset(
                        "lib/assets/images/Apple_Inc.-Logo.wine (1).svg",
                        width: 46,
                        height: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 45),
              child: Row(
                children: [
                  SvgPicture.asset("lib/assets/images/Line 38.svg"),
                  const SizedBox(width: 15),
                  Text("OR",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  SvgPicture.asset("lib/assets/images/Line 38.svg"),
                ],
              ),
            ),
            const SizedBox(height: 37),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(
                    Color.fromRGBO(255, 255, 255, 0.37)),
                minimumSize: const WidgetStatePropertyAll(Size(327, 48)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: Text(
                "Sign up withn mail",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
            const SizedBox(
              height: 46,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 135),
              child: Row(
                children: [
                  Text(
                    "Existing account?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Text(
                      "Log in",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
