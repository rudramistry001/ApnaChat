import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/auth/loginscreen.dart';
import 'package:login/screens/homescreen.dart';
import 'package:login/screens/onboard_screen.dart';
import 'package:login/screens/splashscreen.dart';
import 'firebase_options.dart';

// global object for accessing device screen size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initialiseFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            routes: {
              '/home': (context) => const HomePage(),
              '/login': (context) => const LoginPage(),
              '/onboard': (context) => const OnBoardScreen(),

              // other routes...
            },
            debugShowCheckedModeBanner: false,
            title: 'Apna Chat',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        });
  }
}

_initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
