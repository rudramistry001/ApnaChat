import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/constants/strings.dart';
import 'package:login/main.dart';
import 'package:login/screens/homescreen.dart';

class MoreSettings extends StatefulWidget {
  const MoreSettings({super.key});

  @override
  State<MoreSettings> createState() => _MoreSettingsState();
}

class _MoreSettingsState extends State<MoreSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.profilescreen,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose your theme:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Change theme & rebuild to
                // show it using these buttons
                // ElevatedButton(
                //     onPressed: () {
                //       // changeTheme(ThemeMode.light);
                //       changeTheme(ThemeMode.light);
                //       setState(() {});
                //     },
                //     child: const Text('Light theme')),
                // ElevatedButton(
                //     onPressed: () {
                //       changeTheme(ThemeMode.dark);
                //       setState(() {});
                //     },
                //     child: const Text('Dark theme')),
                IconButton(
                  // onPressed: () => \
                  onPressed: () {
                    appTheme.toggleTheme(context);
                  },
                  icon: const Icon(Icons.settings_display_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
