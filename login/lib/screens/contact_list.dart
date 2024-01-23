import 'package:flutter/material.dart';
import 'package:login/api/apis.dart';
import 'package:login/constants/strings.dart';
import 'package:login/main.dart';
import 'package:login/model/chat_user_model.dart';
import 'package:login/widgets/contact_user_card.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<ChatUser> _list = [];
  final List<String> items = List<String>.generate(10000, (i) => '$i');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.contacts,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlue,
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
              _list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (_list.isNotEmpty) {
                return ListView.builder(
                  itemCount: _list.length, // Use the length of the list
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    //return Text('Name: ${list[index]}');
                    return ContactUserCard(user: _list[index]);
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
