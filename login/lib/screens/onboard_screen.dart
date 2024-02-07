// ignore_for_file: use_key_in_widget_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:login/auth/loginscreen.dart';
import 'package:login/auth/signuppage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  late CarouselController _carouselController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _carouselController,
              items: [
                buildOnboardingPage(
                  imagePath: "assets/images/onboard1.png",
                  headtext: "Welcome To the community of ApnaChat",
                  bodytext:
                      "We ensure you end to end encrypted Chatting...and lots of more more ahead",
                  appIconPath: "assets/images/logo.png",
                  appName: "ApnaChat",
                ),
                buildOnboardingPage(
                  imagePath: "assets/images/onboard2.png",
                  headtext: "We Wont let YOU miss any UPDATE",
                  bodytext:
                      "we ensure real time messaging along with the push notification service for you to stay updated",
                  appIconPath:
                      "assets/images/logo.png", // Replace with your desired icon
                  appName: "ApnaChat",
                ),
                buildOnboardingPage(
                  imagePath: "assets/images/onboard3.png",
                  headtext: "NOT JUST CHAT BUT A LOT MORE",
                  bodytext:
                      "We also pack the leading AI Chat Gpt's capabilities in our App...",
                  appIconPath: "assets/images/logo.png",
                  appName: "ApnaChat",
                ),
              ],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
          ),
          AnimatedSmoothIndicator(
            activeIndex: _currentPage,
            count: 3,
            effect: SwapEffect(
              radius: 10,
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Colors.blueAccent,
              dotColor: Colors.lightBlueAccent.withOpacity(0.17),
            ),
            onDotClicked: (index) {
              _carouselController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
          ),
          // Buttons at the bottom
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage == 2)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // Set button size
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(120, 50),

                      // Set button border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                        side: const BorderSide(
                            color: Colors.blue), // Set border color
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                if (_currentPage == 2)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // Set button size
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(120, 50),

                      // Set button border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                        side: const BorderSide(
                            color: Colors.blue), // Set border color
                      ),
                    ),
                    child: const Text("Sign Up"),
                  ),
                if (_currentPage < 2)
                  ElevatedButton(
                    onPressed: () {
                      _carouselController.jumpToPage(2);
                    },
                    style: ElevatedButton.styleFrom(
                      // Set button size
                      foregroundColor: Colors.grey,
                      backgroundColor: Colors.white,
                      minimumSize: const Size(120, 50),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          "Skip",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        SizedBox(width: 8.0), // Adjust the spacing as needed
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blueAccent,
                          size: 20.0, // Adjust the size as needed
                        ),
                      ],
                    ),
                  ),
                if (_currentPage < 2)
                  ElevatedButton(
                    onPressed: () {
                      _carouselController.nextPage();
                    },
                    style: ElevatedButton.styleFrom(
                      // Set button size
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(120, 50),

                      // Set button border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                        side: const BorderSide(
                            color: Colors.blue), // Set border color
                      ),
                    ),
                    child: const Text("Next"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage({
    required String imagePath,
    required String headtext,
    required String bodytext,
    required String appIconPath, // Path to the app icon in assets
    required String appName,
  }) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove the shadow
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Image.asset(
              appIconPath,
              height: 40.0, // Adjust the height as needed
              width: 40.0, // Adjust the width as needed
            ),
            const SizedBox(width: 10.0),
            // App Name
            Text(
              appName,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 34.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image centered above the text
            Image.asset(
              imagePath,
              height: 240.0, // Adjust the height as needed
            ),
            const SizedBox(height: 20.0),

            // Text below the image
            Text(
              headtext,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              bodytext,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.w100,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
