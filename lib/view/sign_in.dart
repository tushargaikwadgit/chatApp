import 'package:firebase_project1/controller/methods.dart';
import 'package:firebase_project1/view/home_screen.dart';
import 'package:firebase_project1/view/login_screen.dart';
import 'package:firebase_project1/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  bool _obscureText = true;
  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 61, left: 25),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            child: SvgPicture.asset(
                              "lib/assets/images/Back.svg",
                              width: 35,
                              height: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 55),
                  Center(
                    child: Text(
                      "Log in to Chatbox",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromRGBO(61, 74, 122, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      width: 293,
                      height: 40,
                      child: Text(
                        "Welcome back! Sign in using your social account or email to continue us",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: const Color.fromRGBO(121, 124, 123, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 44, left: 127),
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
                          onTap: () {},
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
                              "lib/assets/images/Apple_Inc.-Logo.wine (1) (1).svg",
                              width: 46,
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 65.0, right: 45),
                    child: Row(
                      children: [
                        SvgPicture.asset("lib/assets/images/Line 39.svg"),
                        const SizedBox(width: 15),
                        Text("OR",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: const Color.fromRGBO(121, 124, 123, 1),
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        SvgPicture.asset("lib/assets/images/Line 39.svg"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 37),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text(
                          "Your email",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color.fromRGBO(61, 74, 122, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter you email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(61, 74, 122, 1),
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color.fromRGBO(61, 74, 122, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: password, // Your TextEditingController
                      keyboardType: TextInputType.visiblePassword,
                      obscureText:
                          _obscureText, // Variable to control password visibility
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(61, 74, 122, 1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                          Color.fromRGBO(61, 74, 122, 1)),
                      minimumSize: const WidgetStatePropertyAll(Size(327, 48)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                    ),
                    onPressed: () {
                      if (email.text.isNotEmpty && password.text.isNotEmpty) {
                        setState(() {
                          isloading = true;
                        });
                        login(email.text, password.text).then((user) {
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Successfully'),
                                duration: Duration(seconds: 3),
                              ),
                            );

                            setState(() {
                              isloading = false;
                            });
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Incorrect username or password'),
                                duration: Duration(seconds: 3),
                              ),
                            );

                            setState(() {
                              isloading = false;
                            });
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please Enter Fields'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Log in",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      "Forgot password?",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color.fromRGBO(61, 74, 122, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
