import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/api/apis.dart';
import 'package:login/constants/strings.dart';
import 'package:login/main.dart';
import 'package:login/model/chat_user_model.dart';
import 'package:login/screens/profile_screen.dart';
import 'package:login/widgets/chat_user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatUser> list = [];

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlue,
        leading: const Icon(
          CupertinoIcons.home,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      user: APIs.me,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {},
        child: const Icon(
          Icons.add_comment_rounded,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: APIs.getAllUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // if data s loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );

            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: list.length, // Use the length of the list
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    //return Text('Name: ${list[index]}');
                    return ChatUserCard(user: list[index]);
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "No Connections Found...",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
