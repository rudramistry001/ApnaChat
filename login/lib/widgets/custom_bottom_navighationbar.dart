import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login/screens/chat_screen.dart';
import 'package:login/screens/homescreen.dart';
import 'package:login/screens/settings_screen.dart';

class CustomBottomTabBar extends StatefulWidget {
  final Function(int) onTabSelected;

  const CustomBottomTabBar({Key? key, required this.onTabSelected})
      : super(key: key);

  @override
  _CustomBottomTabBarState createState() => _CustomBottomTabBarState();
}

class _CustomBottomTabBarState extends State<CustomBottomTabBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AIChatScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 57, 89, 1),
              Color.fromRGBO(0, 57, 89, 1),
            ],
          ),
        ),
        padding: EdgeInsets.only(left: 5.sp, right: 5.sp, bottom: 10.sp),
        child: Container(
          height: 100.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0.sp),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 163, 255, 1),
                Color.fromRGBO(0, 163, 255, 1),
              ],
            ),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                ),
                label: 'AI',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
