// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/api/apis.dart';
import 'package:login/auth/firebase_auth_servies.dart';
import 'package:login/auth/signuppage.dart';
import 'package:login/main.dart';
import 'package:login/screens/homescreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSignIn = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                "Enter Email Password to continue",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          //gradient: LinearGradient(colors: Colors.white ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(0, 248, 248, 1),
              Color.fromRGBO(0, 57, 89, 1),
            ],
          ),
        ),
        child: Stack(children: [
          //for showing the robot background image
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/login_frame.png"),
          ),
          Positioned(
              bottom: 0,
              child: Column(
                children: [
                  20.verticalSpace,
                  SizedBox(
                    width: mq.width * 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              20.verticalSpace,
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  color:
                                      Colors.white, // Change text color to blue
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              15.verticalSpace,
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                style: const TextStyle(
                                  color:
                                      Colors.white, // Change text color to blue
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              isSignIn
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : ElevatedButton.icon(
                                      icon: const Icon(Icons.login,
                                          color: Colors.white),
                                      onPressed: () {
                                        print('Email: ${emailController.text}');
                                        print(
                                            'Password: ${passwordController.text}');
                                        _signIn();
                                        
                                      },
                                      label: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blueAccent),
                                        // Change the color here
                                      ),
                                    ),
                              InkWell(
                                onTap: () {
                                  //
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.account_circle),
                                    Text("Sign in with Google "),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  const Text("New User?"),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpPage()),
                                        );
                                      },
                                      child: const Text("Sign up"))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ]),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      isSignIn = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSignIn = false;
    });

    if (user != null) {
      print("User sign in successfully");

      if (await (APIs.userExists())) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      } else {
        await APIs.createUser().then((value) {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
        });
      }
    } else {
      print("Error occurred in Sign In");
    }
  }
}
