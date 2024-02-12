import 'package:flutter/material.dart';
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
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
