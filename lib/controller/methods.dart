// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project1/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    User? user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Account created Successfully");
      user.updateProfile(displayName: name);
      await _firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({"name": name, "email": email, "status": "unavilable"});
      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> login(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    User? user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Login Successfully");
      return user;
    } else {
      print("Login Failure");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => SignIn()),
    (Route<dynamic> route) => false, // Redirect to Sign In
  );
}
