import 'package:flutter/material.dart';
import 'package:login/model/chat_user_model.dart';
import 'package:login/screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(125);

  @override
  Widget build(BuildContext context) {
    List<ChatUser> list = [];

    return AppBar(
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "WhatsApp",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(top: 12, right: 15),
            child: Icon(
              Icons.search,
              size: 28,
            ),
          ),
          PopupMenuButton(
            elevation: 10,
            padding: const EdgeInsets.symmetric(vertical: 20),
            iconSize: 28,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: InkWell(
                  onTap: () {
                    // Handle the onTap for "New Group"
                    // Add your logic here
                  },
                  child: const Text(
                    "New Group",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: InkWell(
                  onTap: () {
                    // Handle the onTap for "New broadcast"
                    // Add your logic here
                  },
                  child: const Text(
                    "New broadcast",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: InkWell(
                  onTap: () {
                    // Handle the onTap for "Linked devices"
                    // Add your logic here
                  },
                  child: const Text(
                    "Linked devices",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: InkWell(
                  onTap: () {
                    // Handle the onTap for "Starred messages"
                    // Add your logic here
                  },
                  child: const Text(
                    "Starred messages",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                user: list[0],
                              )),
                    );
                  },
                  child: const Text(
                    "profile",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]);
  }
}
