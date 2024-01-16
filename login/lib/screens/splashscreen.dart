import 'package:flutter/material.dart';
import 'package:login/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        milliseconds: 1500,
      ),
      () {
        Navigator.pushReplacementNamed(context, '/onboard');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            Positioned(
              top: mq.height * .25,
              right: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset('assets/images/logo.png'),
            ),
            Positioned(
              bottom: mq.height * .25,
              width: mq.width * .9,
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Hamari बातें...💬',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 36, color: Colors.lightBlueAccent),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Hamare बीच...🤲🏻',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 36, color: Colors.lightBlueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Made',
                            style:
                                TextStyle(fontSize: 14, color: Colors.orange),
                          ),
                          Text(
                            ' In ',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'India',
                            style: TextStyle(
                                fontSize: 14, color: Colors.lightGreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
