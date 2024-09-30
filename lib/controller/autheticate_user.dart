import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/view/home_screen.dart';
import 'package:firebase_project1/view/login_screen.dart';
import 'package:flutter/material.dart';
import '../view/sign_in.dart';

class AuthenticateUser extends StatelessWidget {
  AuthenticateUser({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return const HomeScreen();
    } else {
      return const Login();
    }
  }
}
