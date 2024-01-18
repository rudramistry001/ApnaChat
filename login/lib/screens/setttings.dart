import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/constants/strings.dart';
import 'package:login/screens/homescreen.dart';
import 'package:login/screens/more_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.settings,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlue,
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoreSettings(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => ProfileSettingsScreen()),
              // );
            },
            child: const ListTile(
              leading: Icon(Icons.edit_attributes),
              title: Text("Profile Settings"),
              trailing: Icon(Icons.more_vert),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LockAppScreen()),
              // );
            },
            child: const ListTile(
              leading: Icon(Icons.lock),
              title: Text("Lock App"),
              trailing: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}
