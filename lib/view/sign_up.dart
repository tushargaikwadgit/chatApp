import 'package:firebase_project1/controller/methods.dart';
import 'package:firebase_project1/view/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conformpassword = TextEditingController();
  bool isloading = false;
  bool _obscureText = true;
  bool _cnfmObscureText = true;

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
                              Navigator.pop(context);
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
                        "Sign up with Email",
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
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        width: 293,
                        height: 40,
                        child: Text(
                          "Get chatting with friends and family today by signing up for our chat app!",
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
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Your name",
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
                        controller: name,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter you name",
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
                            "password",
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
                                _obscureText =
                                    !_obscureText; // Toggle password visibility
                              });
                            },
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
                            "Conform Password",
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
                        controller:
                            conformpassword, // Your TextEditingController
                        keyboardType: TextInputType.visiblePassword,
                        obscureText:
                            _obscureText, // Variable to control password visibility
                        decoration: InputDecoration(
                          hintText: " ReEnter your password",
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
                              _cnfmObscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _cnfmObscureText =
                                    !_cnfmObscureText; // Toggle password visibility
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
                        minimumSize:
                            const WidgetStatePropertyAll(Size(327, 48)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                      ),
                      onPressed: () {
                        if (name.text.isNotEmpty &&
                            email.text.isNotEmpty &&
                            password.text.isNotEmpty &&
                            conformpassword.text.isNotEmpty) {
                          if (password.text == conformpassword.text) {
                            setState(() {
                              isloading = true;
                            });

                            // Call createAccount only after checking password match
                            createAccount(name.text, email.text, password.text)
                                .then((user) {
                              setState(() {
                                isloading =
                                    false; // stop loading after response
                              });

                              if (user != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Account Created Successfully'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );

                                // Navigate to sign-in page after successful signup
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Account Creation Failed'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Create an account",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
