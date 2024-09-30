import 'package:firebase_project1/controller/autheticate_user.dart';
import 'package:firebase_project1/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthenticateUser()));
    });
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
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.03), // Transparent white overlay
                ),
              ),
              SvgPicture.asset(
                "lib/assets/images/Vector.svg",
                width: 333.33,
                height: 316.79,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.9), // Low opacity white color
                  BlendMode.srcIn, // Ensures the color is applied correctly
                ),
              ),
              Text(
                "ChatApp",
                style: GoogleFonts.acme(
                  fontWeight: FontWeight.w400,
                  fontSize: 72,
                  color: const Color.fromRGBO(255, 255, 255, 1),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
