import 'package:firebase_project1/controller/autheticate_user.dart';
import 'package:firebase_project1/firebase_options.dart';
import 'package:firebase_project1/view/chat_room.dart';
import 'package:firebase_project1/view/home_screen.dart';
import 'package:firebase_project1/view/login_screen.dart';
import 'package:firebase_project1/view/sign_in.dart';
import 'package:firebase_project1/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../view/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Define the initial route
      routes: {
        '/': (context) => const SplashScreen(),
        '/authenticateuser': (context) => AuthenticateUser(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/signin': (context) => const SignIn(),
        '/home': (context) => const HomeScreen(),
        '/chatroom': (context) => ChatRoom(),
      },
    );
  }
}
