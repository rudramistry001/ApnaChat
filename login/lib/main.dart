import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/auth/loginscreen.dart';
import 'package:login/screens/onboard_screen.dart';
import 'package:login/screens/splashscreen.dart';
import 'package:login/widgets/app_theme.dart';
import 'firebase_options.dart';

// global object for accessing device screen size
late Size mq;
var appTheme = AppTheme();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initialiseFirebase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    appTheme.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: appTheme.themeMode,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginPage(),
        '/onboard': (context) => const OnBoardScreen(),

        // other routes...
      },
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(primarySwatch: Colors.green),

      // standard dark theme
      // darkTheme: ThemeData.dark(),
      // themeMode: _themeMode,
      title: 'Apna Chat',
      home: const SplashScreen(),
    );
  }
}

_initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
